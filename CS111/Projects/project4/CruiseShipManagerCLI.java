import java.util.Scanner;
import java.util.Collections;
import java.util.Vector;

/**
 * CruiseShipManagerCLI perform the same operations 
 * it's graphical counterpart does except it does them 
 * all through the command line. All actions in CruiseShipManagerCLI
 * are directed to the CruiseManager class and routed properly
 * from there.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class CruiseShipManagerCLI
{
     public static void main(String args[])
     {
          CruiseManager cruiseLines = new CruiseManager();
          System.out.print("Enter the title of your cruise data file: ");
          Scanner input = new Scanner(System.in);
          
          if(cruiseLines.importCruiseData(input.next()))
          {
               System.out.println("Loaded data successfully\n\n");
          } else {
               System.out.println("Did not load successfully :(\nCheck your file name and try again\n");
               return;
          }
          
          while(true)
          {
               System.out.println("\n\nWhat do you want?\n\n");
               System.out.println("\tCruise Functions"); //MENU
               System.out.println("(1) Add A Cruise"); //IMPLEMENTED
               System.out.println("(2) Cancel A Cruise\n\n"); //IMPLEMENTED
               System.out.println("\t Cruise Observation"); //MENU
               System.out.println("(3) Print All Cruises"); //IMPLEMENTED
               System.out.println("(4) Print All Cruises In Reverse"); //IMPLEMENTED
               System.out.println("(5) Print A Cruise\n\n"); //IMPLEMENTED
               System.out.println("\tPassenger Functions"); //MENU
               System.out.println("(6) Add Passenger"); //IMPLEMENTED
               System.out.println("(7) Delete Passenger\n\n"); //IMPLEMENTED
               System.out.println("(0) Quit"); //IMPLEMENTED
               System.out.print("Choice: ");
               int choice = input.nextInt();
               
               if(choice == 0)
               {
                    break;
               }
               
               switch (choice)
               {
                    case 1:
                         System.out.println("Add a new Cruise\n\n");
                         
                         System.out.print("Cruise ID: ");
                         int cid = input.nextInt();
                         
                         System.out.print("Ship Name: ");
                         String sname = input.next();
                         
                         System.out.print("Date of Departure: ");
                         String dod = input.next();
                         
                         System.out.print("Port of Departure: ");
                         String pod = input.next();
                         
                         System.out.print("Maximum Passengers: ");
                         int max = input.nextInt();
                         
                         if(!cruiseLines.cruiseExists(cid))
                         {
                              cruiseLines.addCruise(cid, sname, dod, pod, max);
                              System.out.println("Added Cruise with id: " + cid + " successfully.");
                         } else {
                              System.out.println("A cruise with that ID already exists");
                         }
                         break;
                    case 2:
                         System.out.println("Cancel a Cruise\n\n");
                         
                         System.out.print("Cruise ID: ");
                         int cancleCruise = input.nextInt();
                         
                         if(cruiseLines.cruiseExists(cancleCruise))
                         {
                              Cruise canceledCruise = cruiseLines.cancelCruise(cancleCruise);
                              System.out.println(canceledCruise.getBookedPassengers() + " passengers were affected.");
                         } else {
                              System.out.println("That Cruise does not exist. Check your Cruise ID number and try again.");
                         }
                         break;
                    case 3:
                         System.out.println("\n\nShow all Cruises\n\n");
                         if(cruiseLines.count() > 0)
                         {
                              Vector<Cruise> allTheCruises;
                              allTheCruises = cruiseLines.getCruises();
                              Collections.sort(allTheCruises);
                              for(int i = 0; i < allTheCruises.size(); i++)
                              {
                                   Cruise tmpCruise = allTheCruises.get(i);
                                   System.out.println("Cruise ID: " + tmpCruise.getCruiseID());
                                   System.out.println("Cruise Name: " + tmpCruise.getShipName());
                                   System.out.println("Date of Departure: " + tmpCruise.getDateOfDeparture());
                                   System.out.println("Port of Departure: " + tmpCruise.getPortOfDeparture());
                                   System.out.println("Maximum Passengers: " + tmpCruise.getMaxPassengers() + "\n\n");
                              }
                         } else {
                              System.out.println("There are no cruises to show currently. Press 1 to schedule a new cruise.");
                         }
                         break;
                    case 4:
                         System.out.println("\n\nShow all Cruises in Reverse Order\n\n");
                         if(cruiseLines.count() > 0)
                         {
                              Vector<Cruise> allTheCruisesReverse;
                              allTheCruisesReverse = cruiseLines.getCruises();
                              Collections.sort(allTheCruisesReverse);
                              Collections.reverse(allTheCruisesReverse);
                              for(int i = 0; i < allTheCruisesReverse.size(); i++)
                              {
                                   Cruise tmpCruise = allTheCruisesReverse.get(i);
                                   System.out.println("Cruise ID: " + tmpCruise.getCruiseID());
                                   System.out.println("Cruise Name: " + tmpCruise.getShipName());
                                   System.out.println("Date of Departure: " + tmpCruise.getDateOfDeparture());
                                   System.out.println("Port of Departure: " + tmpCruise.getPortOfDeparture());
                                   System.out.println("Maximum Passengers: " + tmpCruise.getMaxPassengers() + "\n\n");
                              }
                         } else { 
                              System.out.println("There are no cruises to show currently. Press 1 to schedule a new cruise.");
                         }
                         break;
                    case 5:
                         System.out.println("Show A Single Cruise and Passengers\n\n");
                         System.out.println("Which Cruise do you want to Show Information For?\n\n");
                         System.out.print("Cruise ID: ");
                         int cruiseIDToGet = input.nextInt();
                         
                         if(!cruiseLines.cruiseExists(cruiseIDToGet))
                         {
                              System.out.println("Cruise does not exist. Check your cruise ID number.");
                              break;
                         }
                         
                         Cruise singleCruise;
                         singleCruise = cruiseLines.getCruise(cruiseIDToGet);
                         List passengerList;
                         passengerList = singleCruise.getPassengerList();
                         System.out.println("\n\t\t\tInformation for Cruise with ID: " + singleCruise.getCruiseID());
                         System.out.println("Cruise Name: " + singleCruise.getShipName());
                         System.out.println("Date of Departure: " + singleCruise.getDateOfDeparture());
                         System.out.println("Port of Departure: " + singleCruise.getPortOfDeparture());
                         System.out.println("Maximum Passengers: " + singleCruise.getMaxPassengers() + "\n\n");
                         System.out.println("Booked Passengers: " + singleCruise.getBookedPassengers() + "\n\n");
                         
                         if(passengerList.size() > 0)
                         {
                              passengerList.printList();
                         } else {
                              System.out.println("No passengers currently are booked for this cruise");
                         }    
                              
                         break;
                    case 6:
                         System.out.println("Add A Passenger\n\n");
                         
                         System.out.print("To Cruise With ID: ");
                         int toCruise = input.nextInt();
                         
                         System.out.print("Passenger Last Name: ");
                         String lastName = input.next();
                         
                         System.out.print("Passenger First Name: ");
                         String firstName = input.next();
                         
                         System.out.print("Number of Tickets Requested: ");
                         int tickets = input.nextInt();
                         
                         if(cruiseLines.cruiseExists(toCruise)) //make sure the cruise doesn't already exist!
                         {
                              int result = cruiseLines.addPassenger( toCruise, lastName, firstName, tickets);
                              if(result == 1)
                              {
                                   System.out.println("Added Passenger " + lastName + ", " + firstName + " successfully.");
                              } 
                              else if (result == 0)
                              {
                                   System.out.println("Can not add passenger. That would overbook the Cruise.");
                              }
                              else if(result == -1)
                              {
                                   System.out.println("That passenger name already exists on that cruise.");
                              }
                         } else {
                              System.out.println("That specified Cruise ID does not exist in the system.");
                         }
                         break;
                    case 7:
                         System.out.println("Delete a Passenger\n\n");
                         
                         System.out.print("Last Name: ");
                         String lname = input.next();
                         
                         System.out.print("First Name: ");
                         String fname = input.next();
                         
                         System.out.print("On Cruise: ");
                         int cruiseid = input.nextInt();
                         
                         if(cruiseLines.removePassenger( lname, fname, cruiseid))
                         {
                              System.out.println("Removed passenger from Cruise");
                         } else {
                              System.out.println("Error removing passenger from cruise. Check you Cruise ID and name spelling");
                         }
                         break;
               }
          }
     }
}