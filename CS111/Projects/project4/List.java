/**
 * List is an internal class used in this
 * instance to keep track of passengers. It is accessed
 * through the Cruise class and holds Passengers objects.
 * List uses an external class "Node" to store data and
 * map to other nodes in the list.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class List
{
     private Node first;
     private Node last;
     private int size;
     
     /**
      * Initialize list size
      **/
     public List()
     {
          this.size = 0;
     }
     
     /**
      * Get size of this list
      * @return Size of list
      **/
     public int size()
     {
          return size;
     }
     
     /**
      * Adds a passenger to the list
      * @param item Passenger object being inserted into the list
      **/
     public void add(Passengers item)
     {
          if(first == null)
          {
               first = new Node(item);
               last = first;
               this.size++;
          } else {
               Node tmpNode;
               tmpNode = first;
               while(tmpNode.getNext() != null)
               {
                    tmpNode = tmpNode.getNext();
               }
               tmpNode.setNext(new Node(item));
               this.size++;
          }
     }
     
     /**
      * Adds a passenger to the list at a
      * specified index.
      * @param item Passenger object being stored in list
      * @param index Index at which to insert new Passenger object.
      **/
     public void add(Passengers item, int index)
     {
          if((index > this.size) || (index < 0))
          {
               //Can't insert before 0 or after our max size. Continuing...
               return; //break out
          }
          
          Node tempNode = this.first;
          
          if(index == 0) //inserting at beginning?
          {
               Node tempNext = tempNode;
               this.first = new Node(item);
               this.first.setNext(tempNode);
               this.size++;
               return; //end this methods run
          }
          for(int i = 0; i < index; i++)
          {
               if( i == index-1)
               {
                    Node tempNext = tempNode.getNext(); //hold our next node
                    tempNode.setNext(new Node(item)); //set our current nodes next to our inserted node
                    tempNode.getNext().setNext(tempNext); //set the next node **NEW** to our **OLD** last node
                    this.size++;
               } else {
                    tempNode = tempNode.getNext();
               }
          }
     }
     
     /**
      * Going to base this all off of return codes
      * 0 = fail. Nothing removed
      * > 0 = success. That many seats opened up
      **/
     public int deletePassenger(String lname, String fname)
     {
          Node tmpNode;
          tmpNode = first;
          Passengers thisPassenger = (Passengers) tmpNode.getItem();
          
          //only one person
          if(size == 1)
          { //are the the person being search for?
               if(thisPassenger.getLastName().equals(lname) && thisPassenger.getFirstName().equals(fname))
               {
                    first = null; //wipe the list clean
                    last = null;
                    size = 0;
                    return thisPassenger.getTickets(); //in return code, this means we successfully wiped the passenger
               } else {
                    return 0; //that passenger doesn't exist
               }
               //this else if checks for the first person in the >1 element list being the person to be removed
          } else if(thisPassenger.getLastName().equals(lname) && thisPassenger.getFirstName().equals(fname)) {
               first = tmpNode.getNext();
               return thisPassenger.getTickets();
          }
          
          Node lastNode;
          while(tmpNode.getNext() != null)
          {
               lastNode = tmpNode;
               tmpNode = tmpNode.getNext();
               thisPassenger = (Passengers) tmpNode.getItem();
               
               if(thisPassenger.getLastName().equals(lname) && thisPassenger.getFirstName().equals(fname))
               {
                    lastNode.setNext(tmpNode.getNext());
                    return thisPassenger.getTickets();
               }
          } //this loop works until it breaks at a return or until it reaches the end. 
          //if it reaches the end, then the searched person does not exist;
          
          return 0; //no tickets removed
     }

     /**
      * Return head Node from the list
      * @return Reference variable to first Node in list
      **/
     public Node getHead()
     {
          return first;
     }
     
     /**
      * Print contents of list. Mostly
      * used in debugging
      **/
     public void printList()
     {
          Node temp;
          temp = first;
          Passengers thisPassenger;
          if(size == 1)
          {
               thisPassenger = temp.getItem();
               System.out.print(thisPassenger.getLastName() + ", " + thisPassenger.getFirstName() + " (" + thisPassenger.getTickets() + ")");
          }

          while(temp.getNext() != null)
          {
               temp = temp.getNext();
               thisPassenger = temp.getItem();
               System.out.println(thisPassenger.getLastName() + ", " + thisPassenger.getFirstName() + " (" + thisPassenger.getTickets() + ")");
          }
     }
}