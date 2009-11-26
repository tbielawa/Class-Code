
public class Node
{
     private Object item;
     private Node next;
     
     public Node(Object item)
     {
          this.item = item;
          next = null;
     }
     
     public void setNext(Node nextNode)
     {
          this.next = nextNode;
     }
     
     public Object getItem()
     {
          return this.item;
     }
     
     public Node getNext()
     {
          return this.next;
     }
     
}