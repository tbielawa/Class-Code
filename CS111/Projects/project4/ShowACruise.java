import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Vector;

/**
 * Graphical window to get information about a 
 * specific cruise and it's passenger list. The cruise
 * is passed by reference to the constructor to the class.
 * Data fields are then filled and the table of passeners
 * is populated from the cruise data.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class ShowACruise extends JFrame
{
     private static Cruise cruise;
     private static List allPassengers;
     private static JTable table;
     private static JFrame passengerList;
     private static JScrollPane leftScrollPane, rightScrollPane;
     private static Container leftPane;
     private static JSplitPane splitPane;
     
     /**
      * Shows all the information about a single
      * cruise.
      * @param inputCruise Reference to the Cruise Object
      **/
     public ShowACruise(Cruise inputCruise)
     {
          setDefaultLookAndFeelDecorated(true);
          setIconImage(new ImageIcon("images/ship.gif").getImage());
          this.cruise = inputCruise;
          this.allPassengers = cruise.getPassengerList();
          setTitle("Information for " + cruise.getShipName());
          
          //Menu the main data pane
          JLabel cid = new JLabel("Cruise ID: ");
          JLabel cidData = new JLabel(new Integer(cruise.getCruiseID()).toString());
          JLabel shipName = new JLabel("Ship Name: ");
          JLabel shipNameData = new JLabel(cruise.getShipName());
          JLabel dod = new JLabel("Date of Departure: ");
          JLabel dodData = new JLabel(cruise.getDateOfDeparture());
          JLabel pod = new JLabel("Port of Departure: ");
          JLabel podData = new JLabel(cruise.getPortOfDeparture());
          JLabel booked = new JLabel("Booked Passengers: ");
          JLabel bookedData = new JLabel(new Integer(cruise.getBookedPassengers()).toString());
          JLabel max = new JLabel("Maximum Passengers: ");
          JLabel maxData = new JLabel(new Integer(cruise.getMaxPassengers()).toString());
          
          JScrollPane leftScrollPane = new JScrollPane();

          Container leftPane = new Container();
          leftPane.setLayout(new GridLayout(6, 2));
          
          leftPane.add(cid); leftPane.add(cidData);
          leftPane.add(shipName); leftPane.add(shipNameData);
          leftPane.add(dod); leftPane.add(dodData);
          leftPane.add(pod); leftPane.add(podData);
          leftPane.add(booked); leftPane.add(bookedData);
          leftPane.add(max); leftPane.add(maxData);
          
          leftScrollPane.add(leftPane);
          
          // Make the Table Now
          
          Vector data;
          Vector columns;
          
          columns = new Vector(3);
          columns.add("Last Name");
          columns.add("First Name");
          columns.add("Tickets");
          
          if(cruise.getBookedPassengers() > 0)
          {
               Node tmpNode = allPassengers.getHead();
               columns = new Vector(3);
               columns.add("Last Name");
               columns.add("First Name");
               columns.add("Tickets");
               data = new Vector(allPassengers.size());
               
               while(tmpNode != null)
               {
                    Vector aRow = new Vector(6);
                    aRow.add(tmpNode.getItem().getLastName());
                    aRow.add(tmpNode.getItem().getFirstName());
                    aRow.add(tmpNode.getItem().getTickets());
                    data.add(aRow);
                    tmpNode = tmpNode.getNext();
               }
          } else {
               data = new Vector(0);
               data.add(new Vector(6));
          }
          
          table = new JTable(new MyTableModel(data, columns));
          table.setPreferredScrollableViewportSize(new Dimension(250, 250));
          
          //Create the scroll pane and add the table to it.
          rightScrollPane = new JScrollPane(table);
          
          //put it all together now
          splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,
                                    leftPane,
                                    rightScrollPane);
          
          getContentPane().add(splitPane);
          
          pack();
          this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
          setVisible(true);
     }
}