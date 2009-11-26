public interface IntStack {

public boolean isEmpty();
// determines whether the stack is empty.
// // Precondition:  None.
// // Postcondition:  returns true if the stack is empty, and false otherwise.

public void push( int newValue);
// // adds a new value to the top of the stack
// // Preconditions:  none.
// // Postconditions:  NewValue is inserted at the top of the stack

public int pop();
// // retrieves the value at the top of the stack
// // Precondition:  The stack must not be empty.
// // Postconditon:  If the stack is not empty, the value at the top of the stack
// //______is returned.
// //_Errors:  returns -999 if called with an empty stack.

public int count();
// //  returns the number of elements in the stack.
// // Preconditions:  NONE;
// // Postconditions:  None;
}
