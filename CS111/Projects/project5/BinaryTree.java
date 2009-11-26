/**
 * Binary Tree ADT with methods for
 * manipulation and observation. 
 * 
 * Tim Bielawa
 * TBielawa@mix.wvu.edu
 * Due: 2007/12/07
 **/
public class BinaryTree
{
        private Node root;
        private int count;
        
        /**
         * Constructor, assigns count to 1 and creates root node
         * @param value Root node value
         */
        public BinaryTree(int value)
        {
                this.count = 1;
                this.root = new Node(value, null, null, null);
                System.out.println("Created new Binary Tree with " + value + " for root node value.");
        }
        
        /**
         * Resets the value of the root node
         * @param value New value to assign to root node
         */
        public void setRoot(int value)
        {
                this.root = new Node(value, null, null, null);
                count++;
        }
        
        /**
         * Get a reference to the root node.
         * @return Reference variable to root node of the list
         */
        public Node getRoot()
        {
                return this.root;
        }
        
        /**
         * Prints list in pre-order form. 
         * Friendly wrapper for the overloaded 
         * recursive method.
         */
        public void printPreOrder()
        {
                printPreOrder(this.root);
                System.out.println("");
        }
        
        /**
         * Recursive method to print the list in preorder
         * form.
         * @param point Starting point to recurse from
         */
        public void printPreOrder(Node point)
        {
                if(point != null)
                { 
                        System.out.print(point.getValue() + " "); //evaluate
                        printPreOrder(point.getLeft()); //move left
                        printPreOrder(point.getRight()); //move right
                } else {
                        return;
                }
        }
        
        /**
         * Friendly wrapper for recursive method
         * to print in inorder form
         */
        public void printInOrder()
        {
                printInOrder(this.root);
                System.out.println("");
        }
        
        /**
         * Recursive method to print tree in
         * inorder form.
         * @param point Node to recurse from
         */
        public void printInOrder(Node point)
        {
                if(point != null)
                {
                        printInOrder(point.getLeft());
                        System.out.print(point.getValue() + " ");
                        printInOrder(point.getRight());
                } else {
                        return;
                }
        }
        
        /**
         * Friendly wrapper to print list in
         * post order form
         */
        public void printPostOrder()
        {
                printPostOrder(this.root);
                System.out.println("");
        }
        
        /**
         * Recursive method to print the list
         * in post order form.
         * @param point Node to recurse from.
         */
        public void printPostOrder(Node point)
        {
                if(point != null)
                {
                        printInOrder(point.getLeft());
                        printInOrder(point.getRight());
                        System.out.print(point.getValue() + " ");
                } else {
                        return;
                }
        }
        
        /**
         * Friendly wrapper to call the recursive
         * method to return the height of the tree
         */
        public int getHeight()
        {
                return getHeight(this.root);
        }
        
        /**
         * Recursive method to get the height of 
         * the binary tree.
         * @param point Node from which to recurse.
         * @return Height of the list
         */
        public int getHeight(Node point)
        {
                if(point == null)
                {
                        return 0;
                } else {
                        int left = getHeight(point.getLeft());
                        int right = getHeight(point.getRight());
                        
                        if((left == 0) && (right == 0))
                        {
                                return 1;
                        } else if (left > right) {
                                return left + 1;
                        } else if(right > left) {
                                return right + 1;
                        } else {
                                return left + 1;
                        }
                }
        }
        
        /**
         * Friendly wrapper for the recursive add node method.
         * @param value Value to add to the tree
         */
        public void addNode(int value)
        {
                if(count > 0)
                {
                        addNode(value, this.root);
                } else {
                        root = new Node(value, null, null, null);
                }
        }
        
        /**
         * Recursive method to add nodes to
         * the binary tree.
         * @param value Value being inserted
         * @param point point from which the tree is currently 
         * recursing down.
         */
        public void addNode(int value, Node point)
        {
                if(value < point.getValue())
                {       //check if has left child
                        if(point.getLeft() == null) //if no, then add as left leaf to THIS node
                        {
                                point.setLeft(new Node(value, null, null, point));
                                System.out.println("Added new node with value:" + value);
//                                System.out.println("My Parent Node Is: " + point.getValue()); //uncomment for debugging
                                count++;
                                return;
                        } else  { //if yes then call addNode at that child
                                addNode(value, point.getLeft());
                        }
                }
                
                if(value > point.getValue())
                { //check if has right child
                        if(point.getRight() == null) 
                        {//if no, then add as right leaf to THIS node
                                point.setRight(new Node(value, null, null, point));
                                System.out.println("Added new node with value:" + value);
//                              System.out.println("My Parent Node Is: " + point.getValue()); //uncomment for debugging
                                count++;
                                return;
                        } else { //if yes, then call addNode at that child
                                addNode(value, point.getRight());
                        }
                }
                
                if(value == point.getValue())
                {
                        System.out.println("(!!) FAIL AT INSERTION: VALUE " + value + " ALREADY EXISTS IN TREE");
                        return;
                }
        }

        /**
         * Friendly wrapper for the recursive
         * ancestor printing method.
         * @param child Child whose ancestors are
         * being displayed
         */
        public void ancestors(int child)
        {
                if(this.count < 1) //is there enough?
                {
                        System.out.println("(!!) NO VALUES EXIST IN TREE");
                        return;
                } else if (child == this.root.getValue()) { //is root the node being searched for?
                        System.out.println(child);
                } else { //run the recursive method
                        System.out.println("Ancestors (-->> Older -->>) ");
                        ancestors(child, this.root);
                }
        }
        
        /**
         * Recursive method to print the list
         * of ancestors of a given child
         * @param search node being recursed down to initially
         * @param parent parent node currently being recursed at
         * @return boolean True when the child has been found,
         * false if the method is still recursing to it.
         */
        public boolean ancestors(int search, Node parent)
        {
                if(parent != null)
                {
                        if(search == parent.getValue()) //(1) Base Case: We are the child node in the search query
                        {
                                System.out.print(search + " ");
                                return true;
                        } else if (search > parent.getValue()) { //search value is greater than this one
                                if(ancestors(search, parent.getRight()))
                                {
                                        System.out.print(parent.getValue() + " ");
                                        return true;
                                } else {
                                        return false;
                                }
                        } else if (search < parent.getValue()) { //search value is less than this one
                                if(ancestors(search, parent.getLeft()))
                                {
                                        System.out.print(parent.getValue() + " ");
                                        return true;
                                } else {
                                        return false;
                                }
                        } else {
                                return false;
                        }
                }  else { //if we made it this far then that node does not exist
                        System.out.println("(!!) [" + search + "] NODE DOES NOT EXIST");
                        return false; 
                }
        }
        
        /**
         * Returns the number of nodes
         * in the tree.
         * @return number of nodes in the tree
         */
        public int countNodes()
        {
                return this.count;
        }
        
        /**Gets the right most child of a given node. Useful
         * when deleting nodes from a tree.
         * @param reference Node the search is stemming down from
         * @return Node Bottom right most node from a 
         * given branch
         */
        public Node getRightMostChild(Node reference)
        {
                if(reference.getRight() == null) //we are the right most node?
                {
                        System.out.println(reference.getValue());
                        return reference;
                } else { //not at the bottom
                        return getRightMostChild(reference.getRight());
                }
        }
        
        /**
         * Friendly wrapper class for the delete 
         * method. 
         * @param token Value of node to delete
         * @return true on successful deletion,
         * false if the node does not exist
         */
        public boolean delete(int token)
        {
                if(search(token) != null)
                {
                        delete(search(token));
                        return true;
                } else {
                        return false;
                }
        }
        
        /**
         * Guts of the delete method
         * @param token node to be deleted
         */
        public void delete(Node token)
        {
                // has two children
                if((token.getLeft() != null) && (token.getRight() != null))
                {       //get left childs right most child
                        Node rightMost = getRightMostChild(token.getLeft());
                        rightMost.setRight(token.getRight());
                        token.getRight().setParent(rightMost);
                        
                        if(root == token) //checks if root and 'token' point to the same place
                        {
                                root = token.getLeft();
                        } else { //have to deal with parent nodes now
                                //was token a right or left child?
                                //if left then point parents left child to token.getLeft()
                                if(token.getParent().getLeft() == token)
                                {
                                        token.getParent().setLeft(token.getLeft());
                                } else { //if right then point parents right child to token.Right()
                                        token.getParent().setRight(token.getLeft());
                                }
                                token.getLeft().setParent(token.getParent());
                        }
                } else if((token.getLeft() != null) && (token.getRight() == null)) {//has only left child
                        if(root == token) //checks if root and 'token' point to the same place
                        {
                                root = token.getLeft();
                        } else {
                                token.getParent().setLeft(token.getLeft());
                        }
                } else if ((token.getLeft() == null) && (token.getRight() != null)){ //has only right child
                        if(root == token) //checks if root and 'token' point to the same place
                        {
                                root = token.getRight();
                        } else {
                                token.getParent().setRight(token.getRight());
                        }
                } else { //has no children. replace with null
                        if(root == token)
                        {
                                root = null;
                        } else {
                                //was token a right or left child?
                                if(token.getParent().getLeft() == token) //left child
                                {
                                        token.getParent().setLeft(null);
                                } else { //if right then point parents right child to null
                                        token.getParent().setRight(null);
                                }
                        }
                }
                count--;
        }
        
        /**
         * Friendly wrapper class to recursive
         * search method. Used to check if a node
         * exists
         * @param token Value of node to check.
         * @return Returns the searched node if it existed.
         * Returns null if it does not.
         */
        public Node search(int token)
        {
                //make sure there is even content in the list before recursing
                if(this.count < 1)
                {
                        return null;
                } else {
                        return search(token, this.root);
                }
        }
        
        /**
         * Recursive method to check existance of a
         * node in the binary tree.
         * @param token value being checked for
         * @param point Current point in the tree the search is 
         * recursing from
         * @return Reference variable to the searched node
         * if it exists. NULL if it does not exist.
         */
        public Node search(int token, Node point)
        {
                //cases:
                //(1) we ARE the node you want
                if(token == point.getValue())
                {
                        return point;
                } else if(token > point.getValue()) { //(2) we arent, but we're less than it
                        if(point.getRight() != null)
                        {
                                return search(token, point.getRight());
                        } else {
                                return null;
                        }
                } else { //(3) we aren't, but we're greater than it
                        if(point.getLeft() != null)
                        {
                                return search(token, point.getLeft());
                        } else {
                                return null;
                        }
                }
        }
        
        /**
         * Anonymous class used to make 
         * nodes in the tree
         */
        private class Node
        {
                Node right;
                Node left;
                Node parent;
                int value;
                
                public Node()
                {
                        this.right = null;
                        this.left = null;
                        this.parent = null;
                }
                
                public Node(int value, Node left, Node right, Node parent)
                {
                        this.value = value;
                        this.left = left;
                        this.right = right;
                        this.parent = parent;
                }
                
                public Node getLeft()
                {
                        return this.left;
                }
                
                public Node getRight()
                {
                        return this.right;
                }
                
                public Node getParent()
                {
                        return this.parent;
                }
                
                public void setLeft(Node left)
                {
                        this.left = left;
                }
                
                public void setRight(Node right)
                {
                        this.right = right;
                }
                
                public void setParent(Node parent)
                {
                        this.parent = parent;
                }
                
                public int getValue()
                {
                        return this.value;
                }
        }
}