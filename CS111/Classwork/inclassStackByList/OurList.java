public class OurList
{
     private Node first;
     private Node last;
     private int size;
     
     public OurList()
     {
          this.size = 0;
     }
     
     /**
      * @param item what we are inserting
      * **/
     
     public Object getFirstItem()
     {
          return first.getItem();
     }
     
     public boolean isEmpty()
     {
          if(this.size == 0)
               return true;
          else
               return false;
     }
     
     public void add(Object item)
     {
          if(first == null)
          {
               first = new Node(item);
               last = first;
               this.size++;
          } else {
               last.setNext(new Node(item));
               last = last.getNext();
               this.size++;
          }
     }
     
     public void add(Object item, int index)
     {
          if((index > this.size) || (index < 0))
          {
               System.out.println("Can't insert before 0 or after our max size. Continuing...");
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
          for( int i = 0; i < index; i++)
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
     
     public void delete(int index)
     {
          if((index < 0) || (index > size))
          {
               System.out.println("Can not remove non-existant element: " + index + ". Continuing....");
               return;
          }
          if(index == 0)
          {
               this.first = this.first.getNext();
               this.size--;
               return;
          }
          
          Node tempNode = this.first;
          for(int i = 0; i < this.size; i++)
          {
               if(i == index - 1) //are right before the one we want to remove(index)?
               {
                    tempNode.setNext(tempNode.getNext().getNext()); //then SKIP the next one
                    this.size--; //decrement size
               } else if ((index == size) && (i == size-1)) { //we want to remove the last one
                    tempNode.setNext(null); //set the second to last node's next pointer to null
                    this.size--;
               } else {
                    tempNode = tempNode.getNext(); //otherwise just increment our temp node
               }
          }
     }

     public void printList()
     {
          Node temp = first;
          
          while(temp != null)
          {
               System.out.println(temp.getItem().toString());
               temp = temp.getNext();
          }
     }
}