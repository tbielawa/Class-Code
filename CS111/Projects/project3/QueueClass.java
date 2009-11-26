/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: QueueClas Implements IntStack ADT
 * Description: Standard Stack with push, pop, isEmpty, and count
 **/

public class QueueClass implements SQueue
{
     private int size = 0;
     private SNode head = null; //The string next in line to be dequeued. 
     private SNode tail = null; //The last string enqueued into the list.
     
     /**
      * Determines wether the queue is empty.
      * @return True if the list size equals 0. False if 
      * the size is greater than 0.
      **/
     public boolean isEmpty()
     {
          if(size == 0)
               return true;
          else
               return false;
     }
     
     /**
      * Adds a new value to the end of the queue.
      * @param newValue Value being inserted to end of queue.
      **/
     public void enqueue( String newValue)
     {
          if(size == 0) //no elements
          {
               size++;
               head = new SNode(newValue);
               tail = new SNode(newValue);
          } else if(size == 1) { //only one element
               head.setNext(new SNode(newValue));
               tail = head.getNext();
               size++;
          } else { //more than 1 element
               tail.setNext(new SNode(newValue));
               tail = tail.getNext();
               size++;
          }
     }
     
     /**
      * Retrieves the value at the front of the queue.
      * @return String stored at front of the queue.<BR />
      * Error Code (-999): Returned if called with an empty stack
      **/
     public String dequeue()
     {
          if(size == 0) //zero elements in queue
          {
               return "-999";
          } else if(size == 1) { //one item in queue
               String returnMe = head.getItem();
               head = null;
               tail = null;
               size--; //decrement size to reflect change in queue length
               return returnMe;
          } else { //more than one element in queue
               String returnMe = head.getItem();
               head = head.getNext();
               size--; //decrement size to reflect change in queue length
               return returnMe;
          }
     }
     
     /**
      * Returns the value at the front of the queue 
      * without removing it.
      * @return String stored at the front of the queue.<BR />
      * Error Code (-999): Returned if called with an empty stack
      **/
     public String peek()
     {
          if(size == 0)
               return "-999";
          else 
               return head.getItem();
     }
     
     /**
      * Returns the number of elements in the queue.
      * @return Number of elements in the queue.
      **/
     public int count()
     {
          return this.size;
     }
}
