/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: Node ADT
 * Description: Basic String Node Object. Links to next node
 * if applicable, contains data in String format.
 **/

public class SNode
{
     private String item;
     private SNode next;
     
     /**
      * Initializes this list node object
      * @param item String being saved into a node in the list
      **/
     public SNode(String item)
     {
          this.item = item;
          next = null;
     }
     
     /**
      * Sets reference to the next node in the list
      * @param nextNode Next object in the list
      **/
     public void setNext(SNode nextNode)
     {
          this.next = nextNode;
     }
     
     /**
      * Return the String stored in this node in the list
      * @return The String stored in this node
      **/
     public String getItem()
     {
          return this.item;
     }
     
     /**
      * Return a refence to the next node in the list
      * @return Next node reference
      **/
     public SNode getNext()
     {
          return this.next;
     }
     
}