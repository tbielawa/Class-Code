import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Vector;
import java.util.Collections;
import javax.swing.table.DefaultTableModel;

/**
 * Graphical user interface used for managing
 * a cruise line. Contains methods to add and remove
 * cruises. Also allows for various ways of viewing 
 * cruises.Also has tools for adding and 
 * removing passengers. CruiseShipManagerGUI has all the
 * same functionality that the CLI version does.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class CruiseShipManagerGUI extends JFrame
{
     private static CruiseManager cruiseLines;
     protected static Vector data;
     protected static Vector columnNames;
     protected static DefaultTableModel thisTableModel;
     JTable table;
     
     /**
      * The constructor. This takes care of making the
      * inital window, decorations, menus, tableModel, and empty table
      **/
     public CruiseShipManagerGUI(CruiseManager cruiseLines)
     {
          setIconImage(new ImageIcon("images/ship.gif").getImage());
          this.cruiseLines = cruiseLines;
          setTitle("Manage Cruise Ships");

          setJMenuBar(makeMenus());
          Container pane;
          pane = getContentPane();
          
          GridBagLayout glb = new GridBagLayout();
          pane.setLayout(glb);
          
          JLabel mainMenuLabel = new JLabel("Current Cruises");
          //set up for some fancy drawing!
          GridBagConstraints labelConstraints = new GridBagConstraints();
          //labelConstraints.fill = GridBagConstraints.HORIZONTAL;
          labelConstraints.gridwidth = 1;
          labelConstraints.gridheight = 1;
          labelConstraints.gridx = 0;
          labelConstraints.gridy = 0;
          labelConstraints.anchor = GridBagConstraints.CENTER;
          glb.setConstraints(mainMenuLabel, labelConstraints);
          pane.add(mainMenuLabel);

          //sets up the inital table column names
          columnNames = new Vector(0);
          columnNames.add("CID");
          columnNames.add("Ship Name");
          columnNames.add("Port");
          columnNames.add("Date");
          columnNames.add("Booked Psrgs.");
          columnNames.add("Max. Psgrs.");
          
          //set up the initial table values
          data = new Vector(0);
          Vector aRow;
          aRow = new Vector(0);
          data.add(aRow);
          
          if(cruiseLines.count() > 0)
          {
               data = makeDataVector("asc");
          } else {
               data = new Vector(0);
               data.add(new Vector(6));
          }
          
          //Make the table
          table = new JTable(new MyTableModel(data, columnNames));
          thisTableModel = (DefaultTableModel)table.getModel(); //get our model
          table.setPreferredScrollableViewportSize(new Dimension(500, 270));
          
          //Create the scroll pane and add the table to it.
          JScrollPane scrollPane = new JScrollPane(table);
        
          GridBagConstraints tableConstraints = new GridBagConstraints();
          tableConstraints.fill = GridBagConstraints.HORIZONTAL;
          tableConstraints.gridwidth = 1;
          tableConstraints.gridheight = 1;
          tableConstraints.gridx = 0;
          tableConstraints.gridy = 1;
          glb.setConstraints(scrollPane, tableConstraints);
          pane.add(scrollPane);

          //size, show, and close
          pack();
          setVisible(true);
          setDefaultCloseOperation(EXIT_ON_CLOSE);
     }

     /**
      * Generates JMenuBar for the Window
      * @return Compiled Menu Bar Object Reference
      **/
     public JMenuBar makeMenus()
     {
          JMenuBar menuBar;
          JMenu menu;
          JMenuItem menuItem;
          
          //all JMenus are stored into the JMenuBar
          menuBar = new JMenuBar();
          
          menu = new JMenu("Cruise Functions");
          menu.setMnemonic(KeyEvent.VK_C);
          menuBar.add(menu);
          //Let the menuBar object hold onto this menu object
          
          menuItem = new JMenuItem("Add a Cruise", KeyEvent.VK_A);
          menuItem.addActionListener(new AddCruiseHandler());
          menu.add(menuItem);
          menuItem = new JMenuItem("Cancel a Cruise", KeyEvent.VK_C);
          menuItem.addActionListener(new CancelCruiseHandler());
          menu.add(menuItem);
          //Seperator Here
          menu.addSeparator();
          menuItem = new JMenuItem("Exit Cruise Manager", KeyEvent.VK_X);
          menuItem.addActionListener(new ExitProgramHandler());
          menu.add(menuItem);
          //we can see here that the Menu holds the MenuItems.
          //in turn the MenuBar holds the Menus.
          
          menu = new JMenu("Cruise Observations");
          menu.setMnemonic(KeyEvent.VK_O);
          menuBar.add(menu);
          //add the second Menu to the MenuBar
          
          //now we add MenuItems to the Menu
          menuItem = new JMenuItem("Show All Cruises", KeyEvent.VK_A);
          menuItem.addActionListener(new ShowAllCruisesHandler());
          menu.add(menuItem);
          menuItem = new JMenuItem("Show All Cruises (Reverse)", KeyEvent.VK_R);
          menuItem.addActionListener(new ShowAllCruisesReverseHandler());
          menu.add(menuItem);
          menuItem = new JMenuItem("Show a Single Cruise", KeyEvent.VK_S);
          menuItem.addActionListener(new ShowACruiseHandler());
          menu.add(menuItem);
          
          menu = new JMenu("Passenger Functions");
          menu.setMnemonic(KeyEvent.VK_P);
          menuBar.add(menu);
          //add the third Menu to the MenuBar
          
          menuItem = new JMenuItem("Add Passenger", KeyEvent.VK_A);
          menuItem.addActionListener(new AddPassengerHandler());
          menu.add(menuItem);
          menuItem = new JMenuItem("Remove Passenger", KeyEvent.VK_R);
          menuItem.addActionListener(new RemovePassengerHandler());
          menu.add(menuItem);
          
          return menuBar;
     }
     
     //main method, basically makes sure everything is cool before proceeding
     public static void main(String args[])
     {
          String pathToData = JOptionPane.showInputDialog(null, "Enter the name of your data file\nPress accept to use the default (cruises.txt).", "Starting Cruise Ship Manager...", JOptionPane.QUESTION_MESSAGE);
          if(pathToData == null)
          {
               System.exit(0);
          }
          if(pathToData.equals(""))
          {
               pathToData = "cruises.txt";
          }
          //Call the Backend manager to this program
          CruiseManager cruiseLines = new CruiseManager();
          
          if(!cruiseLines.importCruiseData(pathToData))
          {
               String outputMsg = "Invalid file name, `" + pathToData + "`, check it and try again.\n" +
                    "Remember that you must be in the directory \n" + 
                    "that file is in for it to be located.";
               JOptionPane.showMessageDialog(null, outputMsg, "Cruise Manager", JOptionPane.INFORMATION_MESSAGE);
               System.exit(0);
          }
          
          //launch the program!
          JFrame.setDefaultLookAndFeelDecorated(true);
          CruiseShipManagerGUI manager = new CruiseShipManagerGUI(cruiseLines);
     }
     
     /*
      * Event handlers follow. Should be one for each menu item
      * Add Cruise, Cancel Cruise
      * Show All Cruises, Show All Cruises (Reverse), Show A Cruise
      * Add Passenger, Remove Passenger
      */
     private class AddCruiseHandler implements ActionListener
     {
          /**
           * Adds a cruise to the cruise list
           **/
          public void actionPerformed(ActionEvent e)
          {
               AddACruise cruiseAdder = new AddACruise(cruiseLines);
          }
     }
     
     private class CancelCruiseHandler implements ActionListener
     {
          /**
           * Cancels a cruise
           **/
          public void actionPerformed(ActionEvent e)
          {
               int cid;
               try
               {
                    cid = Integer.parseInt(JOptionPane.showInputDialog(null, "Enter Cruise ID for the cruise to cancel", "Cancel a Cruise", JOptionPane.QUESTION_MESSAGE));
                    if(cruiseLines.cruiseExists(cid))
                    {
                         Cruise tmpCruise = cruiseLines.getCruise(cid);
                         List passengers = cruiseLines.getCruise(cid).getPassengerList();
                         int affected = cruiseLines.getCruise(cid).getBookedPassengers();
                         cruiseLines.cancelCruise(cid);
                         PassengerTable affectedPassengers = new PassengerTable(tmpCruise, "Affected Passengers");
                         popupMessage("Cruise `" + cid + "` canceled. " + affected + " passengers affected.", "Cancel Cruise");
                         updateTableRows("asc");
                    } else {
                         popupWarning("That Cruise Does Not Exist.", "Cancel Cruise");
                    }    
               } catch (NumberFormatException f) { //invalid entry!!!!!!111oneoneone!!!11
                    String outMsg = "Invalid entry \n" +
                         "Try Again Using an Integer.";
                    popupWarning(outMsg, "Cancel Cruise");
               }
          }
     }
     
     private class ShowAllCruisesHandler implements ActionListener
     {
          /**
           * Shows All Cruises in Ascending order by ID
           **/
          public void actionPerformed(ActionEvent e)
          {
               updateTableRows("asc");
          }
     }
     
     private class ShowAllCruisesReverseHandler implements ActionListener
     {
          /**
           * Shows All Cruises in Descending order by ID
           **/
          public void actionPerformed(ActionEvent e)
          {
               updateTableRows("desc");
          }
     }
     
     private class ShowACruiseHandler implements ActionListener
     {
          /**
           * Show information about a single cruise
           **/
          public void actionPerformed(ActionEvent e)
          {
               try
               {
                    int cid = Integer.parseInt(JOptionPane.showInputDialog(null, "Enter Cruise ID: ", "Show A Single Cruise", JOptionPane.QUESTION_MESSAGE));
                    if(cruiseLines.cruiseExists(cid))
                    {
                         ShowACruise cruiseDetails = new ShowACruise(cruiseLines.getCruise(cid));
                    } else {
                         popupWarning("That Cruise Does Not Exist.", "Show A Cruise");
                    } 
               } catch (NumberFormatException f) { //invalid entry!!!!!!111oneoneone!!!11
                    String outMsg = "Invalid entry \n" +
                         "Try Again Using an Integer.";
                    popupWarning(outMsg, "Show A Cruise");
               }
          }
     }
     
     private class AddPassengerHandler implements ActionListener
     {
          /**
           * Adds a passenger to a cruise if possible
           **/
          public void actionPerformed(ActionEvent e)
          {
               String lname, fname;
               int cid, tickets;
               try
               {
                    cid = Integer.parseInt(JOptionPane.showInputDialog(null, "Enter Cruise ID to add this passenger to: ", "Add A Passenger", JOptionPane.QUESTION_MESSAGE));
                    if(cruiseLines.cruiseExists(cid))
                    {
                         tickets = Integer.parseInt(JOptionPane.showInputDialog(null, "Number of Tickets Requested: ", "Add A Passenger", JOptionPane.QUESTION_MESSAGE));
                         lname = JOptionPane.showInputDialog(null, "Enter Passengers Last Name: ", "Add A Passenger", JOptionPane.QUESTION_MESSAGE);
                         fname = JOptionPane.showInputDialog(null, "Enter Passengers First Name: ", "Add A Passenger", JOptionPane.QUESTION_MESSAGE);
                         
                         int result = cruiseLines.addPassenger(cid, lname, fname, tickets);
                         if(result == 1)
                         {
                              popupMessage("Added passenger successfully!", "Add Passenger");
                              updateTableRows("asc");
                         } else if (result == 0) {
                              popupWarning("Unable to add passenger\n That would overbook the cruise.", "Add Passenger");
                         } else if( result == -1) {
                              popupWarning("Unable to add passenger\n That passenger already exists", "Add Passenger");
                         }
                    } else {
                         popupWarning("That Cruise Does Not Exist", "Add Passenger");
                    }
               } catch (NumberFormatException f) { //invalid entry!!!!!!111oneoneone!!!11
                    String outMsg = "Invalid entry \n" +
                         "Try Again Using an Integer.";
                    popupWarning(outMsg, "Add Passenger");
               }
          }
     }
     
     private class RemovePassengerHandler implements ActionListener
     {
          /**
           * Removes a passenger from a Cruise if Possible
           **/
          public void actionPerformed(ActionEvent e)
          {
               String lname, fname;
               int cid;
               try
               {
                    cid = Integer.parseInt(JOptionPane.showInputDialog(null, "Enter Cruise ID to remove passenger from: ", "Remove A Passenger", JOptionPane.QUESTION_MESSAGE));
                    if(cruiseLines.cruiseExists(cid))
                    {
                         lname = JOptionPane.showInputDialog(null, "Enter Passengers Last Name: ", "Remove A Passenger", JOptionPane.QUESTION_MESSAGE);
                         fname = JOptionPane.showInputDialog(null, "Enter Passengers First Name: ", "Remove A Passenger", JOptionPane.QUESTION_MESSAGE);
                         
                         if(cruiseLines.removePassenger(lname, fname, cid))
                         {
                              popupMessage("Removed Passenger Successfully", "Remove Passenger");
                              updateTableRows("asc");
                         } else {
                              popupWarning("Could not Remove Passenger.\n May not exist, check Name Spelling", "Remove Passenger");
                         }

                    } else {
                         popupWarning("That Cruise Does Not Exist", "Remove Passenger");
                    }
               } catch (NumberFormatException f) { //invalid entry!!!!!!111oneoneone!!!11
                    String outMsg = "Invalid entry \n" +
                         "Try Again Using an Integer.";
                    popupWarning(outMsg, "Remove Passenger");
               }
          }
     }
     
     private class ExitProgramHandler implements ActionListener
     {
          /**
           * Removes a passenger from a Cruise if Possible
           **/
          public void actionPerformed(ActionEvent e)
          {
               System.exit(0);
          }
     }
     
     /**
      * Shortcut function to make a message box
      * @param message Message to show
      * @param title Title of message box
      **/
     public static void popupMessage(String message, String title)
     {
          JOptionPane.showMessageDialog( null, message, title, JOptionPane.INFORMATION_MESSAGE);
     }
     
     /**
      * Shortcut function to make a popup warning box
      * @param error Error to show
      * @param title Title of warning box
      **/
     public static void popupWarning(String error, String title)
     {
          JOptionPane.showMessageDialog( null, error, title, JOptionPane.WARNING_MESSAGE);
     }
     
     /**
      * Goes through the cruise object and creates 
      * a vector of vectors containing information
      * about passengers.
      * @param order Call with "asc" for ascending order"
      * and call with "desc" for descending order"
      * @return The Vectors of Vectors with all the
      * passenger data in it.
      **/
     public static Vector makeDataVector(String order)
     {
          Vector<Cruise> allCruises = cruiseLines.getCruises();
          Collections.sort(allCruises);
          
          if(order.equals("desc"))
               Collections.reverse(allCruises);
          
          Vector tmpData = new Vector(allCruises.size());
          for(int i = 0; i < allCruises.size(); i++)
          {
               Vector aRow = new Vector(6);
               Cruise tmpCruise = allCruises.get(i);
               aRow.add(tmpCruise.getCruiseID());
               aRow.add(tmpCruise.getShipName());
               aRow.add(tmpCruise.getPortOfDeparture());
               aRow.add(tmpCruise.getDateOfDeparture());
               aRow.add(tmpCruise.getBookedPassengers());
               aRow.add(tmpCruise.getMaxPassengers());
               tmpData.add(aRow);
          }
          return tmpData;
     }
     
     public static void updateTableRows(String order)
     {
          thisTableModel.setDataVector(makeDataVector(order), columnNames);
     }
}
