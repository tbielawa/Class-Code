import javax.swing.table.DefaultTableModel;
import java.util.Vector;

/**
 * MyTableModel is an extended TableModel class.
 * It's only real difference from the DefaulyTableModel
 * is that is explicitly assigns the isEditable attribute
 * of all cells in the Model to false.<BR><BR>
 * Assignment: Project 4 - Cruise Ship Manager<BR>
 * Due Date: 2007/11/26<BR>
 * E-Mail: TBielawa@mix.wvu.edu
 * @author Tim 'Shaggy' Bielawa
 * @version 1.0
 **/
public class MyTableModel extends DefaultTableModel
{
     /**
      * Constructor to initialize the parent classes
      * internal fields.
      * @param data Vector of Vectors containing the 
      * tables data.
      * @param columns Vector of strings containing
      * the tables column names.
      **/
     public MyTableModel(Vector data, Vector columns)
     {
          super(data, columns);
     }
     
     /**
      * No cells are editable
      * @param row Row to check;
      * @param col Column to check
      * @return Always false;
      **/
     public boolean isCellEditable(int row, int col)
     {
          return false;
     }
}