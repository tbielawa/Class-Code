import java.util.Scanner;
import java.util.Vector;
import java.io.File;
import java.io.FileNotFoundException;

/**
 * CruiseManager is the central piece of this collection.
 * Both CruiseShipManagerCLI and CruiseShipManagerGUI run all
 * actions through this class. From here commands get routed 
 * to the correct sub class. Actions like passenger removal 
 * start here and then are directed to the Cruise class, then 
 * the passengers class, and eventully down to the list containing
 * the passengers themselves. CruiseManager utilizes a double
 * linked list to keep track of all cruises in the system.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class CruiseManager
{
     private DLinkedList cruises;
     int count;

     /**
      * Initializes the Cruise list. Initializes
      * the cruise count to zero.
      **/
     public CruiseManager()
     {
          this.cruises = new DLinkedList();
          this.count = 0;
     }

     /**
      * This removes a cruise from the cruise list
      * @param cid ID of cruise being removed
      * @return Canceled cruise object
      **/
     public Cruise cancelCruise(int cid)
     {
          Cruise returnCruise = this.getCruise(cid);
          cruises.delete(cid);
          count--;
          return returnCruise;
     }
     
     
     /**
      * Imports initial cruise ship information from
      * provided data file
      * @param fileName Name of Data File
      * @return Returns TRUE if Cruise Manager loads the
     * data successfully. FAIL on error.
      **/
     public boolean importCruiseData( String fileName)
     {
          try{
               Scanner input = new Scanner( new File(fileName));

               //read in for as long as there is something to read in
               while(input.hasNext())
               {
                    int cid = input.nextInt();
                    String cruiseName = input.next();
                    String dod = input.next();
                    String pod = input.next();
                    int maxpass = input.nextInt();
                    
                    cruises.add( new Cruise(
                                            cid, //Cruise ID
                                            cruiseName, //Ship Name
                                            dod, //Date of Departure
                                            pod, //Port of Departure
                                            maxpass)); //Maximum Passengers
               }
               
               return true;
          } catch (FileNotFoundException e) { //YOU FAIL AT IDENTIFYING FILE!
               return false;
          }
     }
     
     /**
      * Remove a passenger from the Cruise
      * @param lname Last Name of Passenger
      * @param fname First Name of Passenger
      * @param cid Cruise ID the passenger is on
      * @return TRUE on successful removal, FALSE if fails.
      **/
     public boolean removePassenger( String lname, String fname, int cid)
     {
          if(!this.cruiseExists(cid))
          {
               return false;
          } else {
               Cruise tmpCruise = this.getCruise(cid);
               if(tmpCruise.removePassenger(lname, fname))
               {
                    return true;
               } else {
                    return false;
               }
          }
     }
     
     /**
      * Add a cruise to the Cruise Manager
      * @param cid Unique Cruise ID number
      * @param sname Ship Name
      * @param dod Date of Departure
      * @param pod Port of Departure
      * @param max Maximum passengers
      **/
     public void addCruise( int cid, String sname, String dod, String pod, int max)
     {
          cruises.add( new Cruise(
                                  cid,
                                  sname,
                                  dod,
                                  pod,
                                  max));
     }
     
     /**
      * Adds a passenger to a specified cruise line.
      * @param cid Unique ID of Cruise to Add to
      * @param lname Last name of Passenger being added
      * @param fname First name of passenger being added
      * @param tickets Number of tickets requested
      * @return 1 on success. 0 if that would overbook. -1 
      * if that would duplicate a passenger name
      **/
     public int addPassenger( int cid, String lname, String fname, int tickets)
     {
          Cruise theCruise;
          theCruise = this.getCruise(cid);
          return theCruise.addPassenger(lname, fname, tickets);
          //returns 1 on success
          //returns 0 on overbooking
          //returns -1 on duplicate passenger name
     }
     
     /**
      * Return Reference Variable to a specified Cruise object
      * @param cid Unique Cruise ID
      * @return Reference Variable to Specified Cruise object
      **/
     public Cruise getCruise(int cid)
     {
          DLinkedList.Node tmpNode = cruises.getHead(); //start at the start of things :)
          if(tmpNode.getItem().getCruiseID() == cid)
          {
               return tmpNode.getItem();
          }
          
          while(tmpNode.getNext() != null)
          {
               if(tmpNode.getItem().getCruiseID() == cid)
               {
                    return tmpNode.getItem();
               } else {
                    tmpNode = tmpNode.getNext();
               }
          }
          return tmpNode.getItem();
     }
     
     /**
      * Check if a certain cruise exists
      * @param cruiseID Unique ID of cruise searched for
      * @return TRUE if cruise exists. FALSE if cruise does not exist
      **/
     public boolean cruiseExists( int cruiseID)
     {
          if(this.count() == 0) //make sure you can even call this function
               return false;
          
          DLinkedList.Node tmpNode = cruises.getHead(); //start at first node in the DLinkedList
          do
          {
               if(tmpNode.getItem().getCruiseID() == cruiseID)
               {
                    return true;
               } else {
                    tmpNode = tmpNode.getNext();
               }
          } while(tmpNode != null);
          
          if((tmpNode != null) && (tmpNode.getItem().getCruiseID() == cruiseID))
          {
               return true;
          } else {
               return false;
          }
     }
     
     /**
      * Get ArrayList<Cruise> of the cruises
      * @return An ArrayList<Cruise> of all the 
      * currently stored Cruises.
      **/
     public Vector<Cruise> getCruises()
     {
          Vector<Cruise> allCruises = new Vector<Cruise>();
          DLinkedList.Node tmpNode;
          
          if(this.count() == 1)
          {
               allCruises.add(cruises.getHead().getItem());
               return allCruises;
          }
          
          tmpNode = cruises.getHead();
          while(tmpNode.getNext() != null)
          {
               allCruises.add(tmpNode.getItem());
               tmpNode = tmpNode.getNext();
          }
          allCruises.add(tmpNode.getItem());
          return allCruises;
     }
     
     /**
      * Returns number of queued cruises
      * @return Number of queued cruises
      **/
     public int count()
     {
          return this.cruises.size();
     }
}