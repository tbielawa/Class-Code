/**
 * Node stores data. In this case it stores Passenger
 * objects. Node objects are part of a singley linked
 * list, they only point to the next node, not backwards.
 * <BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class Node
{
     private Passengers item;
     private Node next;
     
     /**
      * Initialize new node object
      * @param item Object being stored in this node
      **/
     public Node(Passengers item)
     {
          this.item = item;
          next = null;
     }
     
     /**
      * Sets reference to next node in list
      * @param nextNode Reference variable to next node
      **/
     public void setNext(Node nextNode)
     {
          this.next = nextNode;
     }
     
     /**
      * Get Object stored in this node
      * @return Object stored in node
      **/
     public Passengers getItem()
     {
          return this.item;
     }
     
     /**
      * Get reference variable to next
      * node in the list
      * @return Reference variable to next node in list
      **/
     public Node getNext()
     {
          return this.next;
     }
}