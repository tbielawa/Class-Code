import java.util.*;

public class CreateLL {
     
     public static void main(String[] args) {
          
          sLinkedList lista = new sLinkedList();
          Scanner input = new Scanner(System.in);
          int tempvalue;
          
          for(int i=1; i<=10; i++){
               System.out.println("Please enter value #" + i + " ");
               tempvalue = input.nextInt();
               
               lista.insertOrdered(tempvalue);
          }
          
          lista.trav();
// sLinkedList.Node kj = new sLinkedList.Node();
          for (int i=1; i<=4; i++) {
               System.out.println("Please enter the value to delete");
               tempvalue = input.nextInt();
               
               lista.delete(tempvalue);
               lista.trav();
          }
     }
}