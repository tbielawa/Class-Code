/**
 * Author: Tim Bielawa
 * Email: Tim_Bielawa@IEEE.org
 * Assignment: Project 3
 * Due : 2007/10/26
 * 
 * Class: PostfixOps ADT
 * Description: Evaluates mathematical 
 * expressions in postfix notation.
 **/
import java.lang.Character;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class PostfixOps
{
     static StackClass expression = new StackClass();
     
     /**
      * Reads in a specified file containing a mathematical
      * expression in postfix notation and evaluates it.
      * @param dataFile The name of the file containing the expression.
      **/
     public static void evaluate( String dataFile)
     {
          try
          {
               Scanner input = new Scanner(new File(dataFile));
               
               while(input.hasNext())
               {
                    String tmpStr = input.next(); //read in next lucky contestant!
                    
                    //if size >= 2 and this input in an operator - operate!
                    if((expression.count() >= 2) && !(Character.isDigit(tmpStr.charAt(0))))
                    {
                         expression.push(PostfixOps.operate(expression.pop(), expression.pop(), tmpStr.charAt(0)));
                         continue;
                    }
                    
                    //if size >= 2 check if is operator, if not then push()                    
                    if((expression.count() >= 2) && (Character.isDigit(tmpStr.charAt(0))))
                    {
                         expression.push(Character.digit(tmpStr.charAt(0), 10));
                         continue;
                    }
                    
                    //if size < 2 and you have an operator - FAIL
                    if((expression.count() < 2) && !(Character.isDigit(tmpStr.charAt(0))))
                    {
                         System.out.println("INVALID EXPRESSION - OPERATOR FOUND (" + tmpStr.charAt(0) + "). EXPECTED INTEGER");
                         break;
                    } else if ((expression.count() < 2) && (Character.isDigit(tmpStr.charAt(0)))) { //if size < 2 - read in more inputs
                         expression.push(Character.digit(tmpStr.charAt(0), 10));
                         continue;
                    }
               }
          } catch (FileNotFoundException e) {
               System.out.println(e);
          }
          
          System.out.println("\n\t Final Result: " + expression.pop());
     }
     
     /**
      * Preforms the indicated math operation
      * @param op1 Second value poped from the stack. 
      * First value in the expression being evaluated.
      * @param op2 First Value poped from the stack.
      * Second value in the expression being evaluated.
      * @return Value of evaluated expression.
      **/
     public static int operate( int op2, int op1, char operation)
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
                   return op1+op2;
                   
              case '-':
                   System.out.println("Subtracting " + op1 + " from " + op2);
                   return op1-op2;
         }
         return 0;
     }
}
