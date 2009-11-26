/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: Node ADT
 * Description: Basic Node Object. Links to next node
 * if applicable, contains data in integer format.
 **/

public class Node
{
     private int item;
     private Node next;
     
     /**
      * Initializes this list node object
      * @param item Integer being saved into a node in the list
      **/
     public Node(int item)
     {
          this.item = item;
          next = null;
     }
     
     /**
      * Sets reference to the next node in the list
      * @param nextNode Next Integer in the list
      **/
     public void setNext(Node nextNode)
     {
          this.next = nextNode;
     }
     
     /**
      * Return the integer stored in this node in the list
      * @return The integer stored in this node
      **/
     public int getItem()
     {
          return this.item;
     }
     
     /**
      * Return a refence to the next node in the list
      * @return Next node reference
      **/
     public Node getNext()
     {
          return this.next;
     }
     
}