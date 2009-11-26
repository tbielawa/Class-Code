/**
 * @author Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: In Class Linked Lists - Nodes
 * 
 * Class: Nodes ADT
 **/

public class Node
{
     private Object item;
     private Node next;
     
     /**
      * initializes this list node object
      * @param item object being saved into a node in a linked list
      **/
     public Node(Object item)
     {
          this.item = item;
          next = null;
     }
     
     /**
      * sets reference to the next node in the list
      * @param nextNode next object in the list
      **/
     public void setNext(Node nextNode)
     {
          this.next = nextNode;
     }
     
     /**
      * return the object stored in this node in the list
      * @return the object stored in this node
      **/
     public Object getItem()
     {
          return this.item;
     }
     
     /**
      * return a refence to the next node in the list
      * @return next node reference
      **/
     public Node getNext()
     {
          return this.next;
     }
     
}