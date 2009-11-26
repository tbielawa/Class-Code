/**
 * DLinkedList is an internally accessed class
 * used in this instance to keep track of cruises.
 * Inside of DLinkedList is an anonymous Node class
 * which is where actual data storage and node mapping
 * takes place. DLinkedList is just a set of tools used 
 * on top of Node to make managing them easier.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class DLinkedList
{
     public class Node
     {
          Node last = null;
          Node next = null;
          Cruise item;
          
          /**
           * Initialize our Node and
           * store an an object into it
           * @param item Object being stored
           **/
          public Node( Cruise item)
          {
               this.item = item;
          }
          
          /**
           * Set next Node reference
           * @param next Reference variable to next node
           **/
          public void setNext( Node next)
          {
               this.next = next;
          }
          
          /**
           * Sets last Node reference
           * @param last Reference variable to last node
           **/
          public void setLast( Node last)
          {
               this.last = last;
          }
          
          /**
           * Get reference to next Node
           * @return Reference variable to next node 
           * in the list
           **/
          public Node getNext()
          {
               return next;
          }
          
          /**
           * Get reference to last Node
           * @return Reference variable to last node
           **/
          public Node getLast()
          {
               return last;
          }
          
          /**
           * Get Object stored in this Node
           * @return Object stored in this Node
           **/
          public Cruise getItem()
          {
               return item;
          }
     }
     
     private Node head = null;
     private int count;
     
     /**
      * Initialize list size
      **/
     public DLinkedList()
     {
          count = 0;
     }
     
     /**
      * Get size of the doublely linked list
      * @return Size of list
      **/
     public int size()
     {
          return count;
     }
     
     /**
      * Add a new cruise to the list in 
      * ascending order.
      * @param item Reference to Cruise Object being added
      **/
     public void add(Cruise item)
     {
          DLinkedList.Node newNode = new Node(item);
          DLinkedList.Node tmpNode = head;
          
          //No nodes in list
          if(this.size() == 0)
          {
               head = newNode;
               count++;
               return;
          }
          
          //One node in list
          if(this.size() == 1)
          {
               if(head.getItem().getCruiseID() > newNode.getItem().getCruiseID())
               {
                    head.setNext(newNode);
                    newNode.setLast(head);
                    count++;
                    return;
               } else {
                    newNode.setNext(head);
                    head.setLast(newNode);
                    head = newNode;
                    count++;
                    return;
               }
          }
          
          //Any number of nodes in list greater than 1, new node less than first node
          if(newNode.getItem().getCruiseID() < head.getItem().getCruiseID())
          {
               newNode.setNext(head);
               head.setLast(newNode);
               head = newNode;
               count++;
               return;
          }
          
          //Any number of nodes in list, new node greater than first node
          while((newNode.getItem().getCruiseID() > tmpNode.getItem().getCruiseID()) && (tmpNode.getNext() != null))
          {
               //tmp < new < tmp.next
               if((tmpNode.getItem().compareTo(newNode.getItem()) == -1) && (newNode.getItem().compareTo(tmpNode.getNext().getItem()) == -1))
               {
                    newNode.setLast(tmpNode);
                    newNode.setNext(tmpNode.getNext());
                    tmpNode.getNext().setLast(newNode);
                    tmpNode.setNext(newNode);
                    count++;
                    return;
               } else {
                    tmpNode = tmpNode.getNext();
               }
          }
          
          //at end of list. new > last
          tmpNode.setNext(newNode);
          newNode.setLast(tmpNode);
          count++;
          return;
     }
     
     /**
      * Deletes a node from the list
      * @param id ID of node to delete
      **/
     public void delete( int id)
     {
          //one item, and it's the head
          if(count == 1 && head.getItem().getCruiseID() == id)
          {
               head = null;
               count--;
          } else if (head.getItem().getCruiseID() == id) {
               head = head.getNext();
               head.setLast(null);
               count--;
          } else { //in middle or at end
               Node tmpNode, lastNode;
               lastNode = head;
               tmpNode = head;
               while((tmpNode != null) && (tmpNode.getItem().getCruiseID() != id))
               {
                    lastNode = tmpNode;
                    tmpNode = tmpNode.getNext();
               }
               
               if(tmpNode == null || tmpNode.getItem().getCruiseID() != id)
               {
                    System.out.println("FAIL");
                    //in theory if you call CruiseManager.CruiseExists(cid)
                    //this will never happen.... you can never be too safe though
               } else {
                    if(tmpNode.getNext() == null) // at end
                    {
                         lastNode = tmpNode;
                         count--;
                    } else { //in between two nodes
                         lastNode.setNext(tmpNode.getNext());
                         tmpNode.getNext().setLast(lastNode);
                         count--;
                    }
               }
          }
     }
     
     /**
      * Get the DLinkedList.Node Object Reference Variable
      * of the first Node in the list
      * @return Reference Variable to first Node Object.
      **/
     public Node getHead()
     {
          return head;
     }
}