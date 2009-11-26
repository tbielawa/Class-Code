/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: PrefixOps ADT
 * Description: Evaluates mathematical operations
 * in prefix notation.
 **/

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class PrefixOps
{
     public static QueueClass prefixExp = new QueueClass();
     
     /**
      * Reads in a data file containing a string
      * representation of a prefix mathematical expression.
      * @param dataFile The Name of the file being read in.
      * @return A queue containing the string read in.
      **/
     public static QueueClass queueUpExp( String dataFile)
     {
          try
          {
               Scanner input = new Scanner(new File(dataFile));
              
               while(input.hasNext())
               {
                    prefixExp.enqueue(input.next());
               }
          } catch (FileNotFoundException e) {
          }
          
          return prefixExp;
     }
     
     /**
      * Evaluates a prefix notation mathematical
      * expression read in from a queue.
      * @param queue A queue containing the mathematical
      * expression to be evaluated.
      * @return The result of the expresson
      * being calculated.
      **/
     public static int calcPre( QueueClass queue)
     {
          if(queue.count() < 3)
          {
               System.out.println("Expression not valid. Does not contain at least 3 elements.");
               System.out.println("As a reminder, an expression must contian at least 2 operands and an operator.");
               return -9999; 
          }

          char A = queue.dequeue().charAt(0);
          char B = queue.dequeue().charAt(0);
          char C = queue.dequeue().charAt(0);
          
          while(queue.count() != 1)
          {
               if(PrefixOps.isOperator(A)) //is the first dequeued element an operator?
               {
                    if(Character.isDigit(B) && Character.isDigit(C)) //and the next two are numbers
                    {
                         int result = PrefixOps.operate( Character.digit(B, 10), Character.digit(C, 10), A);
                         queue.enqueue(Integer.toString(result, 10));
                         if(queue.count() >= 3)
                         {
                              A = queue.dequeue().charAt(0);
                              B = queue.dequeue().charAt(0);
                              C = queue.dequeue().charAt(0);
                         } else if(queue.count() == 1) {
                              break;
                         } else {
                              System.out.println("Error in your expression. Please check it and try again.");
                         }    
                    } else { //B and C are not both numbers. SHIFT everything
                         queue.enqueue(Character.toString(A));
                         A = B;
                         B = C;
                         C = queue.dequeue().charAt(0);
                    }
               } else { //first dequeued element isn't an operator, shift everything
                    queue.enqueue(Character.toString(A));
                    A = B;
                    B = C;
                    C = queue.dequeue().charAt(0);
               }
          }
          return Character.digit(queue.dequeue().charAt(0), 10);
     }
     
     /**
      * Preforms the indicated math operation
      * @param op1 Second value dequeued. 
      * First value in the expression being evaluated.
      * @param op2 First Value dequeued.
      * Second value in the expression being evaluated.
      * @return Value of evaluated expression.
      **/
     public static int operate( int op1, int op2, char operation)
     {
         switch(operation)
         {
              case '/':
                   System.out.println("Dividing " + op1 + " by " + op2);
                   return op1/op2;
                   
              case '*':
                   System.out.println("Multiplying " + op1 + " with " + op2);
                   return op1*op2;
                   
              case '+':
                   System.out.println("Adding " + op1 + " to " + op2);
                   return op2+op1;
                   
              case '-':
                   System.out.println("Subtracting " + op2 + " from " + op1);
                   return op1-op2;
         }
         return 0; //if all else fails.... return 0
     }
     
     /**
      * Check to see if the given character is a valid
      * mathematical operator. Accepted operators are
      * (+, -, *, /)
      * @param charIn Character to check
      * @return True if the character is a valid operator,
      * False if is not.
      **/
     public static boolean isOperator( char charIn)
     {
          switch(charIn)
          {
               case '+':
                    return true;
               case '-':
                    return true;
               case '*':
                    return true;
               case '/':
                    return true;
               default:
                    return false;
          }
     }
}
