/**********************
  * Author: Tim Bielawa
  * Email: Tim_Bielawa@IEEE.org
  * Class: CS111-(001)
  * Due Date: 2007/09/21
  * Assignment: 1 - Solving a Maze
***********************/

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

class traverseMaze
{
     private static int [][] maze = new int[15][15];
     private static String mazeFile;

     public static void main(String[] args)
     {
          final int XINIT = 0; //starting points
          final int YINIT = 0;
          
          System.out.println("Maze traversal -- Final Release");
          
          if(mazeFilePrompt()) //does the maze load properly?
          {
               System.out.println("Below is the maze before recursing");
               printMaze(); // print before recursing
               
               if( traverse(XINIT,YINIT) ) //can the maze be traversed?
               {
                    System.out.println("Maze traversed successfully!");
                    printMaze(); //print after recursing
               } else {
                    System.out.println("Could not traverse maze.");
                    //Unable to finish, bad maze perhaps?
               } // end traverse(0,0)
          } // end mazeFilePrompt()
     }
     
     public static boolean traverse(int x, int y)
     {
          if(x == 14 && y == 14)
          {
               maze[14][14] = 7;
               return true;
          }
          if( x < 0 ) // failure
               return false;
          
          if( x > 14) // failure
               return false;
          
          if( y < 0 ) // failure
               return false;
          
          if( y > 14 ) // failure
               return false;
          
          if( maze[y][x] == 0 ) //failure
              return false;

          //uncomment this next line for debugging
          //System.out.println("Row: " + y + " Col: " + x);
          
          if( maze[y][x] == 3 ) // failure, kinda...
               return false;
          
          if( maze[y][x] == 1 ) // we entered a legit. space
               maze[y][x] = 3;

          if( traverse(x, y+1) ) // success going down
          {
               maze[y][x] = 7;
               return true;
          }
          
          if( traverse(x, y-1) ) // success going up
          {
               maze[y][x] = 7;
               return true;
          }
          
          if( traverse(x+1, y) ) //success going right
          {
               maze[y][x] = 7;
               return true;
          }
          
          if( traverse(x-1, y) ) // success going left
          {
               maze[y][x] = 7;
               return true;
          }

          return false;
     }
     
     public static boolean mazeFilePrompt()
     {
          Scanner input = new Scanner(System.in); //read from keyboard
          
          //Prompt
          System.out.println("Enter the name of the data file containing the maze");
          System.out.print("Maze: ");
          
          mazeFile = input.next();
          
          //read into 15x15 static array
          if(readMaze())
               return true;
          else
               return false;
     }
     
     public static boolean readMaze()
     {
          try
          {
               Scanner inputFile = new Scanner(new File(mazeFile));
               
               for(int i = 0; i < 15; i++)
               {
                    for(int j = 0; j < 15; j++)
                    {
                         maze[i][j] = inputFile.nextInt();
                    }
               }
          } catch (FileNotFoundException e) {
               System.out.println("Invalid file entered. Make sure you are running this from the directory your maze file is in and try again.");
               return false;
          }
          return true;
     }
     
     public static void printMaze()
     {
          for(int i = 0; i < 15; i++)
          {
               for(int j = 0; j < 15; j++)
               {
                    if(j == 14)
                    {
                         System.out.println(" " + maze[i][j] + " ");
                    } else {
                         System.out.print(" " + maze[i][j] + " ");
                    }
               }
          }
     }
}