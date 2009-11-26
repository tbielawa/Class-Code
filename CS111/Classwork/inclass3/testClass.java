/**********************
  * Author: Tim Bielawa
  * Email: Tim_Bielawa@IEEE.org
  * Class: CS111-(001)
  * Assignment: In Class 3 - Ghetto List
***********************/

import java.util.Scanner;
class testClass
{
     public static void main(String[] args)
     {
          Scanner input = new Scanner(System.in);

          ListByArrays ghettoList = new ListByArrays();
          
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          
          ghettoList.add(42); //add the value 1337 to index 0 in our ghetto list
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          ghettoList.printList();

          ghettoList.add(1);
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          ghettoList.printList();
          
          ghettoList.add(2);
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          ghettoList.printList();

          ghettoList.add(1,1337);
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          ghettoList.printList();          

          System.out.print("Choose an element to remove: ");
          ghettoList.remove(input.nextInt());
          System.out.println("Current Ghetto List Length: " + ghettoList.size());
          ghettoList.printList();
     }
     
}