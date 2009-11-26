import java.util.Vector;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

/**
 * PassengerTable is used to create a Frame with only
 * a Table inside it. The Table is populated from a 
 * referenced list of passengers. It's somewhat generic
 * in that the way to identify why it's displaying these 
 * passengers in particular is through passing a string to
 * the constructor which is then displayed in the Frame
 * title bar.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class PassengerTable
{
     private static List allPassengers;
     private static Cruise cruise;
     private static JTable table;
     private static JFrame passengerList;
     private static JScrollPane scrollPane;
     private static Container passengerPane;

     /**
      * Creates a new Frame with a Table listing
      * the information about a list of passengers
      * @param inList Reference to Cruise object 
      * that contains the passenger list
      * @param title Title to display in the frame
      **/
     public PassengerTable(Cruise inList, String title)
     {
          JFrame.setDefaultLookAndFeelDecorated(true);
          
          this.cruise = inList;
          this.allPassengers = cruise.getPassengerList();
          passengerList = new JFrame(title);
          passengerList.setIconImage(new ImageIcon("images/ship.gif").getImage());
          passengerList.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
          
          passengerPane = passengerList.getContentPane();
          passengerPane.setLayout(new GridLayout(1,1));
          
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
          table.setPreferredScrollableViewportSize(new Dimension(250, 370));
          
          //Create the scroll pane and add the table to it.
          scrollPane = new JScrollPane(table);
          
          //Add the scroll pane to this panel.
          passengerPane.add(scrollPane);
          
          passengerList.pack();
          passengerList.setVisible(true);
     }
}