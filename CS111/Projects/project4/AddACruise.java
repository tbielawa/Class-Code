import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

/**
 * Creates a graphical interface to add a cruise
 * to the cruise manager system. A successful
 * addition will prompt the user to add another or
 * return to the main window<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class AddACruise extends JFrame implements ActionListener
{
     private static CruiseManager cruiseLines;
     protected static JTextField cruiseIDTF, shipNameTF, dodTF, podTF, maxTF;
     protected static JButton cancelBtn, addBtn;
     
     /**
      * The Graphical way to add a passenger
      * onto a cruise.
      * @param inputCruise Reference to the cruise
      * manager class that handles adding passengers
      **/
     public AddACruise(CruiseManager inputCruise)
     {
          setDefaultLookAndFeelDecorated(true);
          setIconImage(new ImageIcon("images/ship.gif").getImage());
          this.cruiseLines = inputCruise;
          setTitle("Add A New Cruise");
          
          Container pane = getContentPane();
          pane.setLayout(new GridLayout(6, 2));
          
          //Labels
          JLabel cid = new JLabel("Cruise ID: ");
          JLabel shipName = new JLabel("Ship Name: ");
          JLabel dod = new JLabel("Date of Departure: ");
          JLabel pod = new JLabel("Port of Departure: ");
          JLabel max = new JLabel("Maximum Passengers: ");
          
          //Text Fields
          cruiseIDTF = new JTextField(10);
          shipNameTF = new JTextField(10);
          dodTF = new JTextField(10);
          podTF = new JTextField(10);
          maxTF = new JTextField(10);
          
          cancelBtn = new JButton("Cancel");
          //cancleHandler = new CancelHandler();
          cancelBtn.addActionListener(this);
          cancelBtn.setActionCommand("cancelMenu");
          
          addBtn = new JButton("Add Cruise");
          //acHandler = new AddHandler();
          addBtn.addActionListener(this);
          addBtn.setActionCommand("addCruise");
          
          add(cid); add(cruiseIDTF);
          add(shipName); add(shipNameTF);
          add(dod); add(dodTF);
          add(pod); add(podTF);
          add(max); add(maxTF);
          add(cancelBtn); add(addBtn);
          
          pack();
          this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
          setVisible(true);
     }
     
     /**
      * Action listener for the buttons add cruise
      * and cancel.
      * @param e Action Event that called this listener.
      **/
     public void actionPerformed(ActionEvent e)
     {
          if("addCruise".equals(e.getActionCommand()))
          {
               int cid, max;
               String shipName, dod, pod;
               try
               {
                    cid = Integer.parseInt(cruiseIDTF.getText());
                    if(!cruiseLines.cruiseExists(cid))
                    { 
                         max = Integer.parseInt(maxTF.getText());
                         shipName = shipNameTF.getText();
                         dod = dodTF.getText();
                         pod = podTF.getText();
                         cruiseLines.addCruise(cid, shipName, dod, pod, max);
                         CruiseShipManagerGUI.updateTableRows("asc");
                         int next = JOptionPane.showConfirmDialog(null, "Cruise Added Successfully, add another?", "Success. Add another?", JOptionPane.YES_NO_OPTION);
                         if(next == 0) //next is either 0, or 1. 0 if you press "YES", 1 if you press "NO"
                         {
                              maxTF.setText(null); //reset the fields to blank for another round
                              shipNameTF.setText(null);
                              cruiseIDTF.setText(null);
                              dodTF.setText(null);
                              podTF.setText(null);
                         } else {
                              dispose(); //done with this window
                         }
                    } else {
                         JOptionPane.showMessageDialog( null, "A Cruise with that ID already exists", "Add A Cruise", JOptionPane.WARNING_MESSAGE);
                    }
               } catch (NumberFormatException f) { //invalid entry
                    String outMsg = "Invalid entry \n" +
                         "Try Again Using an Integer.";
                    JOptionPane.showMessageDialog( null, outMsg, "Add A Cruise", JOptionPane.WARNING_MESSAGE);
               }
          } else if ("cancelMenu".equals(e.getActionCommand())) {
               dispose(); //I RELEASE YOU!!!
          }
     }
}