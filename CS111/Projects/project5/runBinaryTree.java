import java.util.Scanner;

public class runBinaryTree {

        static private BinaryTree myTree;
        public static void main(String[] args) 
        {
                boolean running = true;
                Scanner input = new Scanner(System.in);
                
                System.out.println("Binary tree program");
                System.out.print("Enter a value for the root node: ");
                myTree = new BinaryTree(input.nextInt());
                
                while(running)
                {
                        System.out.println("What do you want to do now?");
                        
                        System.out.println("(1) Add A node\n" +
                                "(2) Delete a Node\n" + 
                                "\n" + 
                                "(3) Print list in order\n" +
                                "(4) Print list pre Order\n" +
                                "(5) Print list post order\n" +
                                "\n" +
                                "(6) Search for a node\n" +
                                "(7) Show the height\n" +
                                "(8) Show node count\n" +
                                "(9) Print ancestors\n" +
                                "\n" +
                                "(0) Quit");
                        System.out.print("Choice: ");
                        
                        switch(input.nextInt())
                        {
                        case 1:
                                System.out.print("Add node with value: ");
                                myTree.addNode(input.nextInt());
                                break;
                        case 2:
                                System.out.print("Delete node with value:");
                                myTree.delete(input.nextInt());
                                break;
                        case 3:
                                System.out.println("In order list:");
                                myTree.printInOrder();
                                break;
                        case 4:
                                System.out.println("Pre order list:");
                                myTree.printPreOrder();
                                break;
                        case 5:
                                System.out.println("Post order list:");
                                myTree.printPostOrder();
                                break;
                        case 6:
                                System.out.print("Search for node with value: ");
                                if(myTree.search(input.nextInt()) != null)
                                {
                                        System.out.println("That node exists");
                                } else {
                                        System.out.println("That node does not exist");
                                }
                                break;
                        case 7:
                                System.out.println("Height of tree: " + myTree.getHeight());
                                break;
                        case 8:
                                System.out.println("Number of Nodes: ");
                                System.out.println(myTree.countNodes());
                                break;
                        case 9:
                                System.out.print("Print ancestors for node with value:");
                                myTree.ancestors(input.nextInt());
                                break;                                
                        case 0:
                                running = false;
                                break;
                        default:
                                System.out.println("Invalid option. Select an option from the list.");
                                break;
                        }
                }
        }
}