
// TDFDRIVE.C
// Contains all functions related to the serial port drivers for TDF
//
// tours de force: http://www.ducksarepeople.com/tdf

#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include "mpx_supt.h"
#include "tdfdrive.h"

DCB *dev;

void interrupt (*cur_int_handler)();

int com_open (int *eflag_p, int baud_rate) {
// Return Values: 0 if no error, -101 if invalid flag pointer,
// -102 if invalid baud rate divisor, -103 if port is already open
  int return_value = 0;
  int baud_rate_div;
  int mask;

// 1. Ensure that the parameters are valid (eflag_p is not null and 
//    baud_rate is not negative), and that the device is not currently open.
  if ( eflag_p == NULL ){
    return_value = ERR_CO_INVALID_FLAG_PNTR;
    return return_value;
  }
  else if ( baud_rate < 0 ){
    return_value = ERR_CO_INVALID_BAUD;
    return return_value;
  }
  
// 2. Initialize the DCB. In particular, this should include indicating 
//    that the device is open, saving a copy of the event flag pointer, 
//    and setting the initial device status to idle. In addition, the ring 
//    buffer parameters must be initialized (set them all to 0).

  dev = malloc(sizeof(DCB));
  dev->event_flag = eflag_p;
  dev->flag = OPEN;
  dev->status = IDLE;
  dev->ring_buffer_in = 0;
  dev->ring_buffer_out = 0;
  dev->ring_buffer_count = 0;

// 3. Save the address of the current interrupt handler, and install the 
//    new handler in the interrupt vector. Use getvect and setvect for this.

  // Fix these later ... this is still fuzzy.
  cur_int_handler = getvect(COM1_INT_ID);
  setvect(COM1_INT_ID, &com_interrupt);

// 4. Compute the required baud rate divisor. Should already be computed.
  
// 5. Store the value 0x80 in the Line Control Register. This allows the 
//    first two port addresses to access the Baud Rate Divisor register.

  outportb(COM1_LC, 0x80);

// 6. Store the high order and low order bytes of the baud rate divisor 
//    into the MSB and LSB registers, respectively. Use the following:
  baud_rate_div = 115200 / (long) baud_rate;
  outportb(COM1_BRD_LSB, baud_rate_div & 0xFF);
  outportb(COM1_BRD_MSB, (baud_rate_div >> 8) & 0xFF);
  
// 7. Store the value 0x03 in the Line Control Register. This sets the line 
//    characteristics to 8 data bits, 1 stop bit, and no parity. It also 
//    restores normal functioning of the first two ports.

  outportb(COM1_LC, 0x03);

// 8. Enable the appropriate level in the PIC mask register.
//    mask & ~0x10 will set the level to 4, which is perfectly in the middle
//    between levels 0 (highest) and 7 (lowest). mask & ~0x10 will set
//    change only the single bit at position 4.
  disable();
  mask = inportb(PIC_MASK);
  mask = mask & ~0x10;
  outportb(PIC_MASK, mask);
  enable();

// 9. Enable overall serial port interrupts by storing the value 0x08 in the 
//    Modem Control register.

  outportb(COM1_MC, 0x08);

//10. Enable input ready interrupts only by storing the value 0x01 in the 
//    Interrupt Enable register.

  outportb(COM1_INT_EN, 0x01);
  
  return return_value;
}


int com_close (void) {
// Return values: 0 if no error, -201 if serial port not open
  int return_value = 0;
  int mask;

// 1. Ensure that the port is currently open.

  if ( dev->flag != OPEN ){
    return_value = ERR_CC_PORT_NOT_OPEN;
    return return_value;
  }

// 2. Clear the open indicator in the DCB.

  dev->flag = CLOSED;

// 3. Disable the appropriate level in the PIC mask register. Using the
//    logical or operator on the bit that was enabled will toggle that
//    bit to 1, but will not touch any other bit.

  disable();
  mask = inportb(PIC_MASK);
  mask = mask | 0x10;
  outportb(PIC_MASK, mask);
  enable();

// 4. Disable all interrupts in the ACC by loading zero values to the 
//    Modem Status register and the Interrupt Enable register.

  outportb(COM1_MS, 0x00);
  outportb(COM1_INT_EN, 0x00);
  
// 5. Restore the original saved interrupt vector using setvect.
  
  setvect(COM1_INT_ID, cur_int_handler);

  return return_value;
}


int com_read (char *buf_p, int *count_p) {
// Return values: 0 if no error, -301 if port not open, -302 if invalid
// buffer address, -303 if invalid count address or count value,
// -304 if device is busy
  int return_value;

// 1. Validate the supplied parameters.
  if ( buf_p == NULL ) {
    return ERR_CR_INVALID_BUFF_ADDR;
  }
  if ( count_p == NULL ) {
    return ERR_CR_INVALID_COUNT_ADDR;
  }

// 2. Ensure that the port is open, and the status is idle.
  if ( dev->flag != OPEN ) {
    return ERR_CR_PORT_NOT_OPEN;
  }
  if ( dev->status != IDLE ) {
    return ERR_CR_DEVICE_BUSY;
  }

// 3. Initialize the input buffer variables (not the ring buffer!) and 
//    set the status to reading. Save the address of the requestor's buffer 
//    (parameter) to the input buffer in the DCB.  This will allow you to 
//    copy data into the requestor's buffer directly from the DCB.  You 
//    also need to save the address of the count (parameter) to the DCB's 
//    input count variable. Set the input done count to 0.
  dev->in_buff = buf_p;
  dev->in_count = count_p;
  dev->in_done = 0;
  dev->status = READING;

// 4. Clear the caller's event flag. Disable interrupts, set device status 
//    to READING; now the system will know that a READ operation is under way.
  *dev->event_flag = 0;
  disable( );

// 5. Copy characters from the ring buffer to the requestor's buffer, 
//    until the ring buffer is emptied, the requested count has been reached, 
//    or a CR (ENTER) code has been found. The copied characters should, 
//    of course, be removed from the ring buffer. Re-enable interrupts.
  while ( dev->ring_buffer_count != 0 && 
	  dev->in_done < *dev->in_count  && 
	  dev->ring_buffer[dev->ring_buffer_in] != '\r' ) {
    dev->in_buff[dev->in_done] = dev->ring_buffer[dev->ring_buffer_in];
    dev->in_done = dev->in_done + 1;
    dev->ring_buffer[dev->ring_buffer_in] = '\0';
    // Does it read from the left or the right? Not sure about this
    dev->ring_buffer_in = dev->ring_buffer_in + 1;
    dev->ring_buffer_count = dev->ring_buffer_count - 1;
  }
  enable( );

// 6. If more characters are needed, return. If the block is complete, 
//    continue with step 7. This will keep the device's status at READING. 
//    Since the status is READING, when a character is received later on, 
//    your interrupt handler will know to put the character in the 
//    requestor's buffer, not the ring buffer.
  if ( dev->in_done < *dev->in_count ) {
    return 0;
  }

// 7. Reset the DCB status to idle, set the event flag, null terminate the
//    input buffer (add a \0 to the end of the buffer) and return the 
//    actual count to the requestor's variable.
  dev->status = IDLE;
  *dev->event_flag = 1;
  dev->in_buff[dev->in_done] = '\0';
  *dev->in_count = dev->in_done;

  return 0;
}


int com_write (char *buf_p, int *count_p) {
// Return values: 0 if no error, -401 if port not open, -402 if invalid
// buffer address, -403 if invalid count address or count value,
// -404 if device is busy          
  int return_value = 0;
  int mask;
  
// 1. Ensure that the input parameters are valid.
// 2. Ensure that the port is currently open and idle. 

  if ( dev->flag != OPEN ){
    return_value = ERR_CW_PORT_NOT_OPEN;
    return return_value;
  }
  else if ( dev->status != IDLE ){
    return_value = ERR_CW_DEVICE_BUSY;
    return return_value;
  }
  else if ( buf_p == NULL ){
    return_value = ERR_CW_INVALID_BUFF_ADDR;
    return return_value;
  }
  else if ( count_p == NULL ){
    return_value = ERR_CW_INVALID_COUNT_ADDR;
    return return_value;
  }

// 3. Install the buffer pointer and counters in the DCB, and set the 
//    current status to writing. Set output done count to 0.

  dev->out_buff = buf_p;
  dev->out_count = count_p;
  dev->out_done = 0;
  dev->status = WRITING;

// 4. Clear the caller's event flag.

  *dev->event_flag = 0;

// 5. Get the first character from the requestor's buffer and store it in 
//    the output register. Write it to the com port, using:
//    Outportb(COM1_BASE, *DCB.outputbuff);
//    Increment the output buffer by one.

  outportb(COM1_BASE, *dev->out_buff);
  dev->out_buff++;
  dev->out_done++;

// 6. Enable write interrupts by setting bit 1 of the Interrupt Enable 
//    register. This must be done by setting the register to the logical 
//    or of its previous contents and 0x02.
  disable();
  mask = inportb(COM1_INT_EN);
  mask = mask | 0x02;
  outportb(COM1_INT_EN, mask);
  enable();

  return return_value;
}


void interrupt com_interrupt () {
  int interrupt_ID;

// 1. If the port is not open, clear the interrupt and return. Can do so by
//    sending the end of interrupt code to the PIC command register.
  if ( dev->flag != OPEN ) {
    outportb( PIC_CMD, EOI );
    return;
  }

// 2. Read the Interrupt ID register to determine the exact cause of the 
//    interrupt. Bit 0 must be a 0 if the interrupt was actually caused 
//    by the serial port. In this case, bits 2 and 1 indicate the specific 
//    interrupt type as follows:
//        Bit 2 Bit 1 Interrupt Type
//          0     0   Modem Status Interrupt
//          0     1   Output Interrupt
//          1     0   Input Interrupt
//          1     1   Line Status Interrupt
//    To simplify this, can use bitwise & operation betwen interrupt ID
//    register and 0x07, if 2 then it's a write, 4 for read. 
  interrupt_ID = inportb( COM1_INT_ID_REG );

// 3. Call the appropriate second-level handler.
  if ( (interrupt_ID & 0x07) == 2)
    com_interrupt_write( );
  else if ( (interrupt_ID & 0x07) == 4)
    com_interrupt_read( );

// 4. Clear the interrupt by sending EOI to the PIC command register.
  outportb( PIC_CMD, EOI );
}


void com_interrupt_read () {
  char char_in;
// 1. Read a character from the input register.
  char_in = inportb( COM1_BASE );

// 2. If the current status is not reading, store the character in the 
//    ring buffer. If the buffer is full, discard the character. In either 
//    case return to the first-level handler. Do not signal completion. If
//    the ring buffer is not full, then store the character and increment
//    the indices.
  if ( dev->status != READING  && 
       dev->ring_buffer_count < RING_BUFFER_SIZE ) {
    dev->ring_buffer[dev->ring_buffer_in] = char_in;
    dev->ring_buffer_in = dev->ring_buffer_in + 1;
    dev->ring_buffer_count = dev->ring_buffer_count + 1;
    return;
  }
  
// 3. Otherwise, the current status is reading. Store the character in 
//    the requestor's input buffer.
// 4. If the count is not completed and the character is not '\r', return. 
//    Do not signal completion.
  if ( dev->in_done < *dev->in_count && 
       char_in != '\r' ) {
    dev->in_buff[dev->in_done] = char_in;
    dev->in_done = dev->in_done + 1;
    return;
  }
  
// 5. Otherwise, the transfer has completed. Set the status to idle. Set 
//    the event flag, set input count to input done, null terminate input
//    buffer, and return the requestor's count value.
  dev->status = IDLE;
  *dev->event_flag = 1;
  *dev->in_count = dev->in_done;
  dev->in_buff[dev->in_done] = '\0';
}


void com_interrupt_write () {
  int mask;
// 1. If the current status is not writing, ignore the interrupt and return.
  if ( dev->status != WRITING )
    return;
// 2. Otherwise, if the count has not been exhausted, get the next character 
//    from the requestor's output buffer and store it in the output register.
//    Increment appropriate variables. Return without signaling completion.
  if ( dev->out_done < *dev->out_count ){
    outportb(COM1_BASE, *dev->out_buff);
    dev->out_buff++;
    dev->out_done++;
    return;
  }
// 3. Otherwise, all characters have been transferred. Reset the status to 
//    idle. Set the event flag and return the count value. Disable write 
//    interrupts by clearing bit 1 in the interrupt enable register.
//    Disable write interrupts by clearing bit 1 in the interrupt enable 
//    register:
//       mask = inportb(COM1_INT_EN);
//       mask = mask & ~0x02;
//       outportb(COM1_INT_EN ,mask);
  else{
    dev->status = IDLE;
    *dev->event_flag = 1;
    *dev->out_count = dev->out_done;
    disable();
    mask = inportb(COM1_INT_EN);
    mask = mask & ~0x02;
    outportb(COM1_INT_EN, mask);
    enable();
  }
}

