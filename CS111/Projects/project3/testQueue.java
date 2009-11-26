class testQueue
{
     
     public static void main(String[] args)
     {
          
          SQueue queue = new SQueue();
          queue.enqueue("one");
          queue.enqueue("two");
          queue.enqueue("three");
          queue.enqueue("four");
          System.out.println(queue.peek());
     }
     
}