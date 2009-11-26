
public class StackByList
{
     private OurList list = new OurList();
     
     
     public boolean isEmpty()
     {
          return list.isEmpty();
     }
     
     public Object pop()
     {
          Object tmpItem = list.getFirstItem();
          list.delete(0);
          return tmpItem;
     }
     
     public Object peek()
     {
          return list.getFirstItem();
     }
     
     public void push(Object o)
     {
          list.add(o, 0);
     }
}