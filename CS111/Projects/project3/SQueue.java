public interface SQueue {

public boolean isEmpty();
// determines whether the queue is empty.
// // Precondition:  None.
// // Postcondition:  returns true if the queue is empty, and false otherwise.

public void enqueue( String newValue);
// // adds a new value to the end of the queue
// // Preconditions:  none.
// // Postconditions:  NewValue is inserted at the end of the
// //				queue

public String dequeue();
// // retrieves the value at the front of the queue
// // Precondition:  The queue must not be empty.
// // Postconditon:  If the queue is not empty, the value at 
// //				the front of the queue is removed and 
// //				returned.
// //_Errors:  returns -999 if called with an empty queue.

public String peek();
// //  returns the value at the front of the queue without
// // 	removing it.
// // Preconditions:  The queue must not be empty.
// // Postconditon:  If the queue is not empty, the value at 
// //				the front of the queue is returned.
// //_Errors:  returns -999 if called with an empty queue.

public int count();
// //  returns the number of elements in the queue.
// // Preconditions:  NONE;
// // Postconditions:  None;

}
