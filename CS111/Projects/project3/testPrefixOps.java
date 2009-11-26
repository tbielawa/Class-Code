import java.util.Scanner;

public class testPrefixOps
{
     public static void main(String[] args)
     {
          Scanner input = new Scanner(System.in);
          System.out.println("\n\n\t\tPrefix Expression Evaluator.\n");
          System.out.println("Enter the ASCII file containing your expressions to evaluate.\n");
          System.out.print("File: ");
          
          int result = PrefixOps.calcPre(PrefixOps.queueUpExp(input.next()));
          
          System.out.println(result);
          
     }
}
