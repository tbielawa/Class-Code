/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: StackClass ADT Implements IntStack
 * Description: Standard Stack with push, pop, isEmpty, and count
 **/

public class StackClass implements IntStack
{     
     private Node head = null;
     private Node top = null;
     private int size = 0; //initialize size to 0
     
     /**
      * Determines wether the stack is empty
      * @return True if the stack size equals 0. 
      * False if stack size is greater than 0
      **/
     public boolean isEmpty()
     {
          if (size == 0)
               return true;
          else
               return false;
     }
     
     /**
      * Adds a new value to the top of the stack
      * @param newValue The integer being pushed onto the stack
      **/
     public void push(int newValue)
     {
          if(size == 0)
          {
               this.head = new Node(newValue);
               this.top = new Node(newValue);
               size++;
          } else {
               //loop to the end...
               //tmpNode.setNext = new Node(newValue)
               Node tmpNode = this.head;
               while(tmpNode.getNext() != null)
               {
                    tmpNode = tmpNode.getNext();
               }
               
               tmpNode.setNext(new Node(newValue));
               this.top = new Node(newValue);
               size++;
          }
     }
     
     /**
      * Retrieves the value at the top of the stack
      * @return The value at the top of the stack.<BR />
      * Error Code (-999): Returned if called with an empty stack
      **/
     public int pop()
     {
         if(size == 0)
         {
              return -999; // error code (-999)
         } else if(size == 1) { //one item in list
              Node returnMe = this.top;
              this.head = null; //no more items, head is null
              this.top = null; //no more items, head = top = null
              size--; //reflect change in list into size          
              return returnMe.getItem();
         } else { //more than 1 item in list
              Node tmpNode = head;
              Node returnMe = this.top;
              
              //loop to end and change references to last node.
              while(tmpNode.getNext().getNext() != null) //look ahead by two
              {
                   tmpNode = tmpNode.getNext();
              }
              //now tmpNode should be the second to last item
              tmpNode.setNext(null);
              this.top = tmpNode;

              size--; //decrement size to reflect the popping of an element
              return returnMe.getItem();
         }
     }
     
     /**
      * Return the number of elements in the stack
      * @return The number of elements in the stack
      **/
     public int count()
     { 
          return this.size;
     }
}
