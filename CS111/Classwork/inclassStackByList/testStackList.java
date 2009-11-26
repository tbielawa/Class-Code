
class testStackList
{
     public static void main(String[] args)
     {
          StackByList stack = new StackByList();
          
          stack.push("data1");
          stack.push("data2");
          stack.push("data3");
          stack.push("data4");
          
          System.out.println(stack.peek());
          
          stack.pop();
          stack.pop();
          
          System.out.println(stack.peek());
          
          if(stack.isEmpty())
               System.out.println("Empty stack");
          else
               System.out.println("Non-empty stack");
          
     }
}