package org.jbiowhdbms.dbms;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * This interface is to handled the DBMS connections
 *
 * $Author: r78v10a07@gmail.com $ $LastChangedDate: 2013-03-19 09:38:47 +0100
 * (Tue, 19 Mar 2013) $ $LastChangedRevision: 630 $
 * @since Jun 17, 2011
 */
public interface WHDBMSFactory {
    
    /**
     * Get the driver
     *
     * @return the driver
     */
    public String getDriver();

    /**
     * Set the driver
     *
     * @param driver the driver
     */
    public void setDriver(String driver);

    /**
     * Get the URL
     *
     * @return the URL
     */
    public String getUrl();

    /**
     * Set the URL
     *
     * @param url the URL
     */
    public void setUrl(String url);

    /**
     * Get the user
     *
     * @return the user
     */
    public String getUser();

    /**
     * Set the user
     *
     * @param user the user
     */
    public void setUser(String user);

    /**
     * Get the password
     *
     * @return the password
     */
    public String getPasswd();

    /**
     * Set the password
     *
     * @param passwd the password
     */
    public void setPasswd(String passwd);
    
    /**
     * Return the URL without the jdbc:// prefix
     *
     * @return the URL without the jdbc:// prefix
     */
    public String getMainURLParsed();

    /**
     * Open the connection using internal data
     *
     * @param createSchema true to create the schema and open de connection
     * @throws SQLException
     */
    public void openConnection(boolean createSchema) throws SQLException;   

    /**
     * Close the connection with the DBMS database
     *
     * @throws SQLException
     */
    public void closeConnection() throws SQLException;

    /**
     * True if the connection is open, false other wise.
     *
     * @return boolean
     * @throws SQLException
     */
    public boolean isConnOpen() throws SQLException;

    /**
     * Return the MySQL connection
     *
     * @return A Connection object with the MySQL connection opened
     */
    public Connection getConn();

    /**
     * Set the MySQL connection
     *
     * @param conn a Connection object with the MySQL connection
     */
    public void setConn(Connection conn);
    
    /**
     * Is a JBioWH main schema
     *
     * @return true if it is a JBioWH main schema
     */
    public boolean isJbiowhSchema();
    
    /**
     * Set as a JBioWH main schema
     *
     * @param jbiowhSchema true if it is a JBioWH main schema
     */
    public void setJbiowhSchema(boolean jbiowhSchema);
    
    /**
     * Load TSV into the Table table
     *
     * @param file TSV filename
     * @param table the table name to get the WID
     */
    public void loadTSVFile(String table, String file);

    /**
     * Load TSV into the Table table
     *
     * @param table the table name to get the WID
     * @param file TSV filename
     * @param format the format add to the LOAD DATA INFILE command
     */
    public void loadTSVFile(String table, String file, String format);

    /**
     * Load TSV into the Table table
     *
     * @param file TSV File object
     * @param table the table name to get the WID
     */
    public void loadTSVFile(String table, File file);

    /**
     * Load TSV into the Table table with the ignore option
     *
     * @param file TSV File object
     * @param table the table name to get the WID
     */
    public void loadTSVFileIgnore(String table, File file);

    /**
     * Load TSV into the Table table
     *
     * @param table the table name to get the WID
     * @param file TSV File object
     * @param format the format add to the LOAD DATA INFILE command
     */
    public void loadTSVFile(String table, File file, String format);

    /**
     * Load TSV into the Table table with the ignore option
     *
     * @param table the table name to get the WID
     * @param file TSV File object
     * @param format the format add to the LOAD DATA INFILE command
     */
    public void loadTSVFileIgnore(String table, File file, String format);

    /**
     * This method load all tables into the DBMS
     *
     * @param tables a List object with the tables manager
     */
    public void loadTSVTables(List tables);

    /**
     * Drop the table on the DBMS
     *
     * @param name the table name
     * @throws SQLException
     */
    public void dropTable(String name) throws SQLException;

    /**
     * Executes the given SQL statement, which may be an INSERT, UPDATE, or
     * DELETE statement or an SQL statement that returns nothing, such as an SQL
     * DDL statement.
     *
     * @param sql SQL sentence
     * @return the number of the number of rows affected by a query
     * @throws SQLException
     */
    public int executeUpdate(String sql) throws SQLException;

    /**
     * Get the integer columnLabel value returned by the SQL sentence
     *
     * @param sql The SQL sentence which return one Int columnLabel
     * @param columnLabel Column label which should be returned
     * @return the int columnLabel
     */
    public long getLongColumnLabel(String sql, String columnLabel);

    /**
     * This metho split the field2header field returned on the sql sentence into
     * a string array repeating the field1header
     *
     * @param tofile File to print the split result
     * @param sql SQL sentence with return two field
     * @param field1header Field name
     * @param field2header Field name
     * @param separator Separator of data into field2header
     *
     */
    public void splitField(PrintWriter tofile,
            String sql, String field1header, String field2header, String separator);

    /**
     * This metho split the field2header field returned on the sql sentence into
     * a string array repeating the field1header. Each array element is split
     * again into two fields using the separator2
     *
     * @param tofile File to print the split result
     * @param sql SQL sentence with return two field
     * @param field1header Field name
     * @param field2header Field name
     * @param separator1 Separator of data into field2header
     * @param separator2 Internal data separator into two fields
     *
     */
    public void splitField(PrintWriter tofile,
            String sql, String field1header, String field2header,
            String separator1, String separator2);

    /**
     * Return the tables with its fields
     *
     * @return the tables with its fields
     */
    public Map<String, List<String>> getTablesOnSchema();

    /**
     * Return a list of all the data types supported by this database
     *
     * @return a list of all the data types supported by this database
     */
    public List<String> getDBMSDataTypes();

    /**
     * Return a array of all the index types supported by this database
     *
     * @return a array of all the index types supported by this database
     */
    public String[] getDBMSIndexTypes();

    /**
     * This method return in a String format the table's number of rows
     *
     * @param tables A list object with the tables names
     * @return a List<List<Object>> object with the table's number of rows
     */
    public List<List<Object>> countTablesRow(List<String> tables);

    /**
     * Disable the nonunique indexes for a MyISAM table
     *
     * @param tableName the table name
     */
    public void disableKeys(String tableName);

    /**
     * Enable the nonunique indexes for a MyISAM table
     *
     * @param tableName the table name
     */
    public void enableKeys(String tableName);

    /**
     * This method execute the SQL sentence. The first row is the columns names
     *
     * @param sqlQuery The SQL sentence
     * @return A List Object with the result
     * @throws SQLException
     */
    public List<List> execute(String sqlQuery) throws SQLException;

    /**
     * Execute the SQL select sentence with the desired limits
     *
     * @param sentence the SQL select sentence
     * @param offset the offset of the first row to return
     * @param rowCount the number of rows returned
     * @return a List object with the SQL result
     * @throws SQLException if a database access error occurs, this method is
     * called on a closed Statement, the method is called on a PreparedStatement
     * or CallableStatement
     */
    public List<List> executeSingleSQLSelect(String sentence, int offset, int rowCount) throws SQLException;

    /**
     * Execute multiples SQL select sentences
     *
     * @param sentences a list with the SQL sentences
     * @return a List<List> object with the SQL results
     * @throws SQLException if a database access error occurs, this method is
     * called on a closed Statement, the method is called on a PreparedStatement
     * or CallableStatement
     */
    public List<List> executeMultipleSQLSelect(List<String> sentences) throws SQLException;

    /**
     * Execute multiples SQL select sentences with the desired limits
     *
     * @param sentences a list with the SQL sentences
     * @param offset the offset of the first row to return
     * @param rowCount the number of rows returned
     * @return
     * @throws SQLException if a database access error occurs, this method is
     * called on a closed Statement, the method is called on a PreparedStatement
     * or CallableStatement
     */
    public List<List> executeMultipleSQLSelect(List<String> sentences, int offset, int rowCount) throws SQLException;

    /**
     * Compares this WHDBMSFactory to the specified object.
     *
     * @param obj The object to compare this WHDBMSFactory against
     * @return true if the given object represents a WHDBMSFacotry equivalent to
     * this WHDBMSFacotry, false otherwise
     */
    @Override
    public boolean equals(Object obj);
}
