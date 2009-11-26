/**********************
  * Author: Tim Bielawa
  * Email: Tim_Bielawa@IEEE.org
  * Class: CS111-(001)
  * Assignment: In Class 3 - Ghetto List
***********************/

public class ListByArrays{
  
  private int [] array;
  private int capacity = 0;
  
  public ListByArrays(){
    //constructor doesn't have to do anything
  }
  
  public void add(int o){
   capacity++;
   
   if(capacity == 1)
   {
        growArray(o, 0);
   } else {
        growArray(o, array.length);
   }
  }
  
  public void add(int index, int o)
  {
       capacity++;
       growArray(o, index);
  }
  
  public void remove(int index)
  {
    if( ( index >= capacity ) || ( index < 0 ) ) //legal?
    {
         System.out.println("Invalid index point. Remeber, it's from 0 -> Capacity-1");
    } else {
         int [] temp = new int [capacity - 1];
         int fix = 0;
         
         for(int i = 0; i < capacity; i++) //we use ( i < capacity - 1 ) in this case because we're removing an element, decreasing our size by one
         {
              if( i < index)
              {
                   temp[i] = array[i];
              } else if (i > index) {
                   temp[i-1] = array[i];
              }
         }
         capacity--; //adjust
         array = temp; //redeclare
    }

  }
  
  public int size()
  {
       if(capacity == 0)
            return 0;
       else
            return array.length;
  }
  
  public void printList() 
  {
       for(int i = 0; i < capacity; i++)
            System.out.println("Item (" + i + "): " + array[i]);
  }
  
  private void growArray(int item, int index){
       if( ( index < 0 ) || ( index > capacity ) )
       {
            System.out.println("Invalid index for insertion choosen");
       } else {
            int [] temp = new int [capacity];
            int fix = 0;
            
            if(capacity == 1) //first time here huh? damn nullpointer exceptions....
            {
                 temp[index] = item;
            } else { //we have to insert at a specific index, daaaang, more work
                 for(int i = 0; i < capacity; i++)
                 {
                      if(i != index)
                      {
                           temp[i] = array[i - fix]; //the idea of fix is to make adjusting for the index offset easier
                      } else {
                           temp[i] = item;
                           fix = 1; //declare our fix for the index offset
                      }
                 }
            }
            array = temp;
       }
  }
}