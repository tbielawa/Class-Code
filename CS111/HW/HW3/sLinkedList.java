
public class sLinkedList {
     
     protected static class Node{
          protected int value;
          protected Node  next;
          
          protected Node() {
               value=0;
               next=null;
          }
     }// end node class
     
     
     private Node head;
     private int count;
     
     public sLinkedList(){
          count =0;
          head = null;
     }
     ////////////////////////////////////////////////////
     public void insertAtEnd(int newValue) {
          Node newNode,nextNode;
          
          if (head == null) {
               head = new Node();
               head.value =newValue;
               head.next = null;
               ++count;
          }
          else {
               nextNode = head;
               
               while (nextNode.next != null) {
                    nextNode = nextNode.next;
               }
               
               nextNode.next = new Node();
               nextNode.next.value = newValue;
               count++;
               
          }
     } // end insertATEnd;
     
     ////////////////////////////////////////////////////
     
     public void insertAtHead(int newValue) {
          
          Node newNode;
          
          if (head == null) {
               head = new Node();
               head.value =newValue;
               head.next = null;
               ++count;
          }
          else {
               newNode = new Node();
               newNode.value = newValue;
               newNode.next = head;
               
               head = newNode;
               ++count;
          }
          
          
     }// end insertAtHead;
     
////////////////////////////////////////////////////
     public void insertOrdered(int newValue) {
          
          Node newNode;
          Node previousNode=null, nextNode=null;
          
          // Traverse the list, until either the end of the list is found or 
          // a node containing a value >= the new value
          nextNode = head;
          
          while( nextNode !=null && nextNode.value < newValue) {
               previousNode = nextNode;
               nextNode = nextNode.next;
          }
          newNode =new Node();
          newNode.value = newValue;
          newNode.next = null;
          
          // see if inserting first element into an empty
          if (head == null){
               head = newNode;
               ++count;
          }
          
          // see if inserting at head of existing list
          
          else if (previousNode == null) {
               newNode.next = head;
               head = newNode;
               ++count;
          }
          
          // see if inserting at end of existing list
          
          else if (nextNode == null) {
               previousNode.next = newNode;
          }
          
          // else adding in middle
          
          else {
               previousNode.next = newNode;
               newNode.next = nextNode;
          }  
          
          
     } // end insert ordered
     
//delete nodes:
     
////////////////////////////////////////////////////
     public void deleteAll(int value)
     {
          Node last, tmpNode;
          tmpNode = head;
          last = head;
          int size = count;
          for(i = 0; i < size; i++)
          {
               
               if(tmpNode.value == value)
               {
                    //first
                    //only
                    //last
                    //middle
                    if(
               }
          }
     }
     public void delete(int aValue) {
          
          Node previousNode = null, nextNode = null;
          
          
          // look through the list for a value >= aValue
          nextNode = head;
          
          while (nextNode != null && nextNode.value < aValue) {
               previousNode = nextNode;
               nextNode = nextNode.next;
          }
          
          if (nextNode == null  || nextNode.value > aValue){
               System.out.println("The value was not found and could not" +
                                  " be deleted. " );
               return;
          }
          
          //  A node was found
          // check to see if it was the head of the list.
          
          if (previousNode == null) {
               head = nextNode.next;
               --count;
          }
          else {
               previousNode.next = nextNode.next;
               --count;
          }
          
     } // end delete
     
////////////////////////////////////////////////////
     
     public void trav() {
          
          Node nextNode;
          
          nextNode = head;
          
          while (nextNode != null) {
               System.out.println("The value in the node is " + nextNode.value);
               nextNode = nextNode.next;
          }
     } // end trav
     
     
} // end sLinkedList