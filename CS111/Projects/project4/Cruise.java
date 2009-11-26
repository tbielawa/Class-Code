/**
 * This class represents a generic cruise. It
 * stores a unique integer identifier, the ship name, 
 * date of departure, port of departure, maximum 
 * passengers, total booked passengers, a list
 * of the current passenger list, and holds methods
 * for setting and getting it's internal fields. 
 * Cruise uses a singly linked list to keep track
 * of all passengers on that cruise.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class Cruise implements Comparable
{
     private int cruiseID;
     private String shipName;
     private String dateOfDeparture;
     private String portOfDeparture;
     private int maxPassengers;
     private int bookedPassengers;
     private List passengerList = new List();
     
     /**
      * Initialize a new instance of the
      * Cruise class.
      * @param cid Unique Cruise Ship ID
      * @param sname Ship Name
      * @param dod Date of Departure
      * @param pod Port of Departure
      * @param max Maximum number of Passengers
      **/
     public Cruise(int cid, String sname, String dod, String pod, int max)
     {
          this.cruiseID = cid;
          this.shipName = sname;
          this.dateOfDeparture = dod;
          this.portOfDeparture = pod;
          this.maxPassengers = max;
          this.bookedPassengers = 0;
     }

     /**
      * Adds a passenger ticket to the passenger list
      * @param lname Last Name
      * @param fname First Name
      * @param tickets Number of tickets in this party
      * @return 0 if unable to add to passenger list. Return 
      * 1 on success. Return -1 if passenger already exists.
      **/
     public int addPassenger(String lname, String fname, int tickets)
     {
          if(this.passengerExists(lname, fname))
          {
               return -1;
          }
          if((tickets + bookedPassengers) > maxPassengers)
          {
               return 0;
          } else {
               passengerList.add( new Passengers(lname, fname, tickets));
               bookedPassengers += tickets;
               return 1;
          }
     }
     
     /**
      * Removes a passenger and their associated tickets 
      * from the passenger list.
      * @return True on success. False on failure.
      **/
     public boolean removePassenger(String lname, String fname)
     {
          if(bookedPassengers == 0)
          {
               return false; //can not remove people from an empty cruise
          }
          
          int removed = passengerList.deletePassenger(lname, fname);
          
          if(removed > 0)
          {
               bookedPassengers -= removed;
               return true;
          } else {
               return false; //passenger does not exist
          }
     }
     
     /**
      * Checks if a Passenger exists on the cruise
      * @param lname Last Name of Passenger
      * @param fname First Name of Pasenger
      * @return TRUE if they exist. FALSE if they do not
      **/
     public boolean passengerExists( String lname, String fname)
     {
          //checking for ASSUREDLY false matches
          if(passengerList.size() <= 0)
          {
               return false;
          }
          
          Node tmpNode;
          tmpNode = passengerList.getHead();
          Passengers tmpPsgr;
          tmpPsgr = tmpNode.getItem();
          
          //checking for a unique match
          if(passengerList.size() == 1)
          {
               if((tmpPsgr.getLastName().equals(lname)) && (tmpPsgr.getFirstName().equals(fname)))
               {
                    return true;
               }
          }
          
          //check through rest of list for match
          while (tmpNode.getNext() != null)
          {
               tmpNode = tmpNode.getNext();
               tmpPsgr = tmpNode.getItem();
               if((tmpPsgr.getLastName().equals(lname)) && (tmpPsgr.getFirstName().equals(fname)))
               {
                    return true;
               }
          }
          
          //if this executes then the passenger does not exist
          return false;
     }
     
     /**
      * Accessors
      **/
     public void showPassengers()
     {
          passengerList.printList();
     }
     
     public List getPassengerList()
     {
          return passengerList;
     }
     
     public int getMaxPassengers()
     {
          return maxPassengers;
     }
     
     public int getBookedPassengers()
     {
          return bookedPassengers;
     }
     
     public int getCruiseID()
     {
          return cruiseID;
     }
     
     public String getShipName()
     {
          return shipName;
     }
     
     public String getDateOfDeparture()
     {
          return dateOfDeparture;
     }
     
     public String getPortOfDeparture()
     {
          return portOfDeparture;
     }
     
     /**
      * Comparability function. 
      * Orders by Cruise ID
      * @param o Cruise Object used for Comparison
      * @return -1 if the natural order of this is before 
      * it's comparison object. 0 if they have the same 
      * natural order. 1 if this comes after the
      * it's comparison object.
      **/
     public int compareTo(Object o)
     {
          Cruise tmp = (Cruise) o;
          
          if(this.getCruiseID() < tmp.getCruiseID())
          {
               return -1;
          } else if (this.getCruiseID() == tmp.getCruiseID()) {
               return 0;
          } else {
               return 1;
          }
     }
}