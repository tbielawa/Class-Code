/**
 * @author Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: In Class Linked Lists - Nodes
 * 
 * Class: Testing Class of OurList list
 **/


public class Test
{
     
     public static void main(String[] args)
     {
          
          OurList testlist = new OurList();
          
          testlist.add(new String("node1"));
          
          testlist.add(new String("node2"));
          
          testlist.add(new String("node3"));
          
          testlist.add(new String("node4"));
          
          testlist.printList();
          
          testlist.delete(0);
          
          System.out.println("After deletion: ");
          
          testlist.printList();
     }
}