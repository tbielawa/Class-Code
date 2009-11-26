public class testMaze
{
     
     public static void main(String[] args)
     {
          //rows, cols, wall, path
          Maze testMaze = new Maze( 4, 5, 'N', 'V');
          
          testMaze.fillMaze();
          System.out.println("Pre Traversal");
          testMaze.printMaze();
           
          testMaze.traverseMaze(0, 0);
          
          System.out.println("Post Traversal");
          
          testMaze.printMaze();
     }
}