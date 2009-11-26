/**
 * The Passengers class is used to create Passenger objects.
 * It holds the unique characteristics of each passenger
 * and contains accessor methods to retrieve their information.
 * <BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class Passengers
{
     private String lastName;
     private String firstName;
     private int tickets;
     
     /**
      * Initializes this Passenger Objects internal fields
      * @param lname Passenger last name
      * @param fname Passenger first name
      * @param tickets Tickets bought by this custmer
      **/
     public Passengers( String lname, String fname, int tickets)
     {
          this.lastName = lname;
          this.firstName = fname;
          this.tickets = tickets;
     }
     
     /**
      * Accessor to return number of tickets
      * @return Integer equal to the number 
      * of tickets this person has
      **/
     public int getTickets()
     {
          return this.tickets;
     }
     
     /**
      * Accessor to return the last name
      * @return String of this passengers
      * last name.
      **/     
     public String getLastName()
     {
          return this.lastName;
     }
 
     /**
      * Accessor to return the first name
      * @return String of this passengers
      * first name.
      **/
     public String getFirstName()
     {
          return this.firstName;
     }
}