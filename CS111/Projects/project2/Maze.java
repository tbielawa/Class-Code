/**
  * @author: Tim Bielawa
  * Email: Tim_Bielawa@IEEE.org
  * Class: CS111-(001)
  * Due Date: 2007/10/05
  * Assignment: 2 - Maze, The ADT
***********************/

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

class Maze
{
     private char [][] maze;
     private String mazeFile;
     private char wall;
     private char path;
     private int rows;
     private int cols;
     
     /**
      * The maze constructor initializes the private maze character array
      *  to the specified dimensions indicated in its parameters.
      * 
      * @param rows the height of your maze counting from 1
      * @param cols the width of your maze counting from 1
      * @param wall the character used to indicate a wall in a maze file
      * @param path the character used to indicate the path in a maze file
      **/
     public Maze(int rows, int cols, char wall, char path)
     {
          this.wall = wall;
          this.path = path;
          this.rows = rows;
          this.cols = cols;
          this.maze = new char[this.rows][this.cols];
     }
     
     /**
      * traverseMaze goes through the character array if possible.
      * If given an invalid position traverseMaze returns false
      * 
      * @param x column position
      * @param y row position
      * @return TRUE if valid position. FALSE if invalid position.
      */
     public boolean traverseMaze(int x, int y)
     {
          try
          {
               if(x == this.cols-1 && y == this.rows-1)
               {
                    maze[this.rows-1][this.cols-1] = '7';
                    return true;
               }
               
               //uncomment this next line for debugging
               //System.out.println("Row: " + y + " Col: " + x + " This Rows Length (x): " + maze[y].length);
               
               if( x < 0 ) // failure
                    return false;
               
               if( x >= this.cols) // failure
                    return false;
               
               if( y < 0 ) // failure
                    return false;
               
               if( y >= this.rows ) // failure
                    return false;
               
               if( maze[y][x] == this.wall ) //failure -- we aren't in the matrix (Can't walk through walls)
                    return false;
               
               if( maze[y][x] == '3' ) // failure, kinda... -- we don't walk the same path twice
                    return false;
               
               if( maze[y][x] == this.path ) // we entered a legit. space
                    maze[y][x] = '3';
               
               if( traverseMaze(x, y+1) ) // success going down
               {
                    maze[y][x] = '7';
                    return true;
               }
               
               if( traverseMaze(x, y-1) ) // success going up
               {
                    maze[y][x] = '7';
                    return true;
               }
               
               if( traverseMaze(x+1, y) ) //success going right
               {
                    maze[y][x] = '7';
                    return true;
               }
               
               if( traverseMaze(x-1, y) ) // success going left
               {
                    maze[y][x] = '7';
                    return true;
               }
               
          } catch (StackOverflowError e) { //I catch the StackOverFlowError which is thrown when an invalid maze file is entered.
          } //without this catch you would see a huge screen barf. This is 'exiting gracefully'
          
          return false;
     }
     
     
     /**
      * fillMaze is used to read the data file containing the character maze into the 
      * character array that is traversed in the method traverseMaze(int, int)
      */
     public void fillMaze()
     {
          Scanner input = new Scanner(System.in); //read from keyboard

          //Prompt
          System.out.println("\nMaze initialized as a " + this.rows + " row by " + this.cols + " column block with '" + this.wall + "' as walls and '" + this.path + "' as the path.\n");
          System.out.println("Enter the name of the data file containing the maze");
          System.out.print("Maze: ");
          
          mazeFile = input.next();
          
          try
          {
               Scanner inputFile = new Scanner(new File(mazeFile));
               
               for(int i = 0; i < this.rows; i++)
               {
                    for(int j = 0; j < this.cols; j++)
                    {
                         maze[i][j] = inputFile.next().charAt(0);
                    }
               }
          } catch (FileNotFoundException e) {
               System.out.println("Invalid file entered. Make sure you are running this from the directory your maze file is in and try again.");
          }
     }
     
     /**
      * printMaze prints the maze in a readable block format
      */
     public void printMaze()
     {
          for(int i = 0; i < this.rows; i++)
          {
               for(int j = 0; j < this.cols; j++)
               {
                    if(j == this.cols-1)
                    {
                         System.out.println(" " + maze[i][j] + " ");
                    } else {
                         System.out.print(" " + maze[i][j] + " ");
                    }
               }
          }
     }
}