import java.util.Scanner;

class testPostFix
{
     
     public static void main(String[] args)
     {
          Scanner input = new Scanner(System.in);
          System.out.println("\n\n\t\tPostfix Expression Evaluator.\n");
          System.out.println("Enter the ASCII file containing your expressions to evaluate.\n");
          System.out.print("File: ");
          
          PostfixOps.evaluate(input.next());
          
     }
}