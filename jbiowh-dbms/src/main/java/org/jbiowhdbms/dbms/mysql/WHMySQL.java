package org.jbiowhdbms.dbms.mysql;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import org.jbiowhcore.basic.JBioWHUserData;
import org.jbiowhcore.logger.VerbLogger;
import org.jbiowhcore.utility.utils.ParseFiles;
import org.jbiowhdbms.dbms.WHDBMSFactory;

/**
 * This class handled the system connections using MySQL driver
 *
 * $Author: r78v10a07@gmail.com $ $LastChangedDate: 2013-03-19 09:38:47 +0100
 * (Tue, 19 Mar 2013) $ $LastChangedRevision: 630 $
 *
 * @since Jun 17, 2011
 */
public class WHMySQL extends JBioWHUserData implements WHDBMSFactory {

    private Connection conn = null;
    private final String MYSQLFLAG = "\tMySQL: ";

    /**
     * The class to handled the MySQL DBMS. This constructor set the needed
     * parameters
     *
     * @param driver the connection driver (com.mysql.jdbc.Driver)
     * @param url the connection URL (jdbc:mysql://<host>:3306/<database>)
     * @param dbuser the database user
     * @param dbpasswd the database password
     * @param jbiowhSchema
     */
    public WHMySQL(String driver, String url, String dbuser, String dbpasswd, boolean jbiowhSchema) {
        super(driver, url, dbuser, dbpasswd, jbiowhSchema);
    }

    /**
     * Open the connection using internal data
     *
     * @param createSchema true if the schema have to be created
     * @throws java.sql.SQLException
     */
    @Override
    public void openConnection(boolean createSchema) throws SQLException {
        if (createSchema) {
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Open MySQL schema and openning the connection");
        } else {
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Open the MySQL connection");
        }
        try {
            Class.forName(getDriver()).newInstance();
        } catch (ClassNotFoundException ex) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't find the driver class: " + getDriver());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
        } catch (InstantiationException ex) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't find the driver class: " + getDriver());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
        } catch (IllegalAccessException ex) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't find the driver class: " + getDriver());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
        }

        java.util.Properties conProperties = new java.util.Properties();
        conProperties.put("user", getUser());
        conProperties.put("password", getPasswd());
        conProperties.put("autoReconnect", "true");
        conProperties.put("maxReconnects", "2");
        if (createSchema) {
            conProperties.put("createDatabaseIfNotExist", "true");
        }
        conn = DriverManager.getConnection(getUrl(), conProperties);
        VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Connection '" + conn + "' successfully open");
    }

    /**
     * Close the connection wi
     *
     * @throws java.sql.SQLException
     */
    @Override
    public void closeConnection() throws SQLException {
        if (conn != null) {
            if (!conn.isClosed()) {
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Closing the MySQL connection '" + conn + "' ");
                conn.close();
                conn = null;
            }
        }
        setDriver(null);
        setUrl(null);
        setUser(null);
        setPasswd(null);
    }

    @Override
    public boolean isConnOpen() throws SQLException {
        return (conn != null && !conn.isClosed() && conn.isValid(15));
    }

    /**
     * Load TSV into the Table table
     *
     * @param file TSV filename
     * @param table the table name to get the WID
     */
    @Override
    public void loadTSVFile(String table, String file) {
        String sql = "LOAD DATA LOCAL INFILE \"" + file + "\" INTO TABLE " + table;

        try {
            Statement s = createStatement();
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Load TSV into the Table table
     *
     * @param table the table name to get the WID
     * @param file TSV filename
     * @param format the format add to the LOAD DATA INFILE command
     */
    @Override
    public void loadTSVFile(String table, String file, String format) {
        String sql = "LOAD DATA LOCAL  INFILE \"" + file + "\" INTO TABLE "
                + table
                + " "
                + format
                + " ";

        try {
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            Statement s = createStatement();
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Load TSV into the Table table
     *
     * @param file TSV File object
     * @param table the table name to get the WID
     */
    @Override
    public void loadTSVFile(String table, File file) {
        try {
            String sql = "LOAD DATA LOCAL  INFILE \"" + file.getCanonicalPath() + "\" INTO TABLE " + table;
            Statement s = createStatement();
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            if (e instanceof SQLException) {
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: "
                        + ((SQLException) e).getErrorCode());
            }
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        } catch (IOException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Load TSV into the Table table with the ignore option
     *
     * @param file TSV File object
     * @param table the table name to get the WID
     */
    @Override
    public void loadTSVFileIgnore(String table, File file) {
        try {
            String sql = "LOAD DATA LOCAL  INFILE \"" + file.getCanonicalPath() + "\" IGNORE INTO TABLE " + table;
            Statement s = createStatement();
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            if (e instanceof SQLException) {
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: "
                        + ((SQLException) e).getErrorCode());
            }
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        } catch (IOException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Load TSV into the Table table
     *
     * @param table the table name to get the WID
     * @param file TSV filename
     * @param format the format add to the LOAD DATA INFILE command
     */
    @Override
    public void loadTSVFile(String table, File file, String format) {
        String sql = null;

        try {
            sql = "LOAD DATA LOCAL  INFILE \"" + file.getCanonicalPath().replace("\\", "/") + "\" INTO TABLE "
                    + table
                    + " "
                    + format
                    + " ";
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            Statement s = createStatement();
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            if (e instanceof SQLException) {
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: "
                        + ((SQLException) e).getErrorCode());
            }
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        } catch (IOException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Load TSV into the Table table with the ignore option
     *
     * @param table the table name to get the WID
     * @param file TSV filename
     * @param format the format add to the LOAD DATA INFILE command
     */
    @Override
    public void loadTSVFileIgnore(String table, File file, String format) {
        String sql = null;

        try {
            sql = "LOAD DATA LOCAL  INFILE \"" + file.getCanonicalPath().replace("\\", "/") + "\" IGNORE INTO TABLE "
                    + table
                    + " "
                    + format
                    + " ";
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            Statement s = createStatement();
            s.executeQuery(sql);
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sql);
            if (e instanceof SQLException) {
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: "
                        + ((SQLException) e).getErrorCode());
            }
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        } catch (IOException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't load file: " + file + " into table: " + table);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * This method load all tables into the DBMS
     *
     * @param tables a List object with the tables manager
     */
    @Override
    public void loadTSVTables(List tables) {
        Iterator it;

        it = tables.iterator();
        while (it.hasNext()) {
            String table = (String) it.next();
            loadTSVFile(table, ParseFiles.getInstance().getFileAbsolutName(table));
        }
    }

    /**
     * Drop the table on the DBMS
     *
     * @param name the table name
     * @throws SQLException
     */
    @Override
    public void dropTable(String name) throws SQLException {
        executeUpdate("drop table `" + name + "`");
    }

    /**
     * Executes the given SQL statement, which may be an INSERT, UPDATE, or
     * DELETE statement or an SQL statement that returns nothing, such as an SQL
     * DDL statement.
     *
     * @param sql SQL sentence
     * @return the number of the number of rows affected by a query
     * @throws SQLException
     */
    @Override
    public int executeUpdate(String sql) throws SQLException {
        int count;
        Statement s = createStatement();
        VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + " Executing: " + sql);
        count = s.executeUpdate(sql);
        VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + count + " elements modified");
        return count;
    }

    /**
     * Get the integer columnLabel value returned by the SQL sentence
     *
     * @param sql The SQL sentence which return one Int columnLabel
     * @param columnLabel Column label which should be returned
     * @return the int columnLabel
     */
    @Override
    public long getLongColumnLabel(String sql, String columnLabel) {
        long longColumnLabel = 0;

        try {
            Statement s = createStatement();
            s.executeQuery(sql);
            ResultSet rs = s.getResultSet();
            while (rs.next()) {
                longColumnLabel = rs.getLong(columnLabel);
                break;
            }
            VerbLogger.getInstance().log(this.getClass(),
                    MYSQLFLAG + "Long value for column: " + columnLabel
                    + " is: " + longColumnLabel
                    + " from sentence: "
                    + sql);

        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't return the int columnLabel: "
                    + columnLabel
                    + " on the sentence: " + sql);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }

        return longColumnLabel;
    }

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
    @Override
    public void splitField(PrintWriter tofile,
            String sql, String field1header, String field2header, String separator) {
        try {
            Statement s = createStatement();
            s.executeQuery(sql);
            ResultSet rs = s.getResultSet();
            while (rs.next()) {
                String field1 = rs.getString(field1header);
                String field2[] = rs.getString(field2header).split(separator);
                for (String field21 : field2) {
                    tofile.print(field1.trim() + "\t" + field21.trim() + "\n");
                }
            }

            tofile.flush();
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't execute splitField method"
                    + " on the sentence: " + sql);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

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
    @Override
    public void splitField(PrintWriter tofile,
            String sql, String field1header, String field2header,
            String separator1, String separator2) {
        try {
            Statement s = createStatement();
            s.executeQuery(sql);
            ResultSet rs = s.getResultSet();
            while (rs.next()) {
                String field1 = rs.getString(field1header);
                String[] field2 = rs.getString(field2header).split(separator1);
                for (String field21 : field2) {
                    String[] field3 = field21.split(separator2);
                    if (field3.length == 2) {
                        tofile.print(field1.trim() + "\t" + field3[0].trim() + "\t" + field3[1].trim() + "\n");
                    }
                }
            }

            tofile.flush();
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't execute splitField method"
                    + " on the sentence: " + sql);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    /**
     * Return the MySQL connection
     *
     * @return A Connection object with the MySQL connection opened
     */
    @Override
    public Connection getConn() {
        return conn;
    }

    /**
     * Set the MySQL connection
     *
     * @param conn a Connection object with the MySQL connection
     */
    @Override
    public void setConn(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Map<String, List<String>> getTablesOnSchema() {
        Map<String, List<String>> tables = new TreeMap();
        try {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getTables(null, null, "%", null);
            while (rs.next()) {
                String tableName = rs.getString("TABLE_NAME");
                List<String> columns = new ArrayList();
                ResultSet rsColumn = meta.getColumns(null, null, tableName, null);
                while (rsColumn.next()) {
                    columns.add(rsColumn.getString("COLUMN_NAME"));
                }
                tables.put(tableName, columns);
            }
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }

        return tables;
    }

    /**
     * Return a list of all the data types supported by this database
     *
     * @return a list of all the data types supported by this database
     */
    @Override
    public List<String> getDBMSDataTypes() {
        List<String> datatypes = new ArrayList();
        try {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet rs = meta.getTypeInfo();
            while (rs.next()) {
                datatypes.add(rs.getString("TYPE_NAME"));
            }
            Collections.sort(datatypes);
        } catch (SQLException ex) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + ex.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + ex.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + ex.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
        return datatypes;
    }

    /**
     * Return a array of all the index types supported by this database
     *
     * @return a array of all the index types supported by this database
     */
    @Override
    public String[] getDBMSIndexTypes() {
        return new String[]{"INDEX", "UNIQUE", "FULLTEXT", "SPATIAL"};
    }

    @Override
    public List<List<Object>> countTablesRow(List<String> tables) {
        List<List<Object>> data = new ArrayList();
        for (String table : tables) {
            try {
                Statement s = createStatement();
                s.executeQuery("select count(*) from " + table);
                ResultSet rs = s.getResultSet();
                while (rs.next()) {
                    List inData = new ArrayList();
                    inData.add(table);
                    inData.add(rs.getInt(1));
                    data.add(inData);
                    break;
                }
            } catch (SQLException e) {
                VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Can't count the rows on the table " + table
                        + " on the sentence: " + "select count(*) from " + table);
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
                VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
                VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
                System.exit(1);
            }

        }

        return data;
    }

    @Override
    public void disableKeys(String tableName) {
        try {
            executeUpdate("ALTER TABLE " + tableName + " DISABLE KEYS");
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    @Override
    public void enableKeys(String tableName) {
        try {
            executeUpdate("ALTER TABLE " + tableName + " ENABLE KEYS");
        } catch (SQLException e) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Exception code for this SQLException object: " + e.getErrorCode());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + e.getMessage());
            VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + "Error: " + e.toString());
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            System.exit(1);
        }
    }

    @Override
    public List<List> execute(String sqlQuery) throws SQLException {
        List data = new ArrayList();
        VerbLogger.getInstance().log(this.getClass(), MYSQLFLAG + sqlQuery);

        if (sqlQuery.isEmpty()) {
            return data;
        }

        Statement cs = createStatement();
        int resultNum = 0;
        while (true) {
            boolean queryResult;
            int rowsAffected;
            if (1 == ++resultNum) {
                queryResult = cs.execute(sqlQuery);
            } else {
                queryResult = cs.getMoreResults();
            }
            if (queryResult) {
                ResultSet rs = cs.getResultSet();
                List inData = new ArrayList();

                for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
                    inData.add(rs.getMetaData().getColumnName(j));
                }

                data.add(inData);
                while (rs.next()) {
                    List inData1 = new ArrayList();
                    for (int j = 1; j <= rs.getMetaData().getColumnCount(); j++) {
                        inData1.add(rs.getObject(j));
                    }
                    data.add(inData1);
                }

            } else {
                rowsAffected = cs.getUpdateCount();
                if (-1 == rowsAffected) {
                    --resultNum;
                    break;
                }
            }
        }

        return data;
    }

    @Override
    public List<List> executeSingleSQLSelect(String sentence, int offset, int rowCount) throws SQLException {
        String limitedSQL;
        if (!sentence.toUpperCase().startsWith("SELECT")) {
            throw new SQLException("Only a SQL SELECT sentence can be executed on this enviroment");
        }
        if (!sentence.toUpperCase().contains(" LIMIT ")) {
            limitedSQL = sentence + " LIMIT " + offset + "," + rowCount;
        } else {
            limitedSQL = sentence;
        }
        return execute(limitedSQL);
    }

    @Override
    public List<List> executeMultipleSQLSelect(List<String> sentences) throws SQLException {
        List<List> multipleSQLResults = new ArrayList();
        for (String sentence : sentences) {
            multipleSQLResults.add(execute(sentence));
        }
        return multipleSQLResults;
    }

    @Override
    public List<List> executeMultipleSQLSelect(List<String> sentences, int offset, int rowCount) throws SQLException {
        List<List> multipleSQLResults = new ArrayList();
        for (String sentence : sentences) {
            multipleSQLResults.add(executeSingleSQLSelect(sentence, offset, rowCount));
        }
        return multipleSQLResults;
    }

    private Statement createStatement() throws SQLException {
        if (!isConnOpen()) {
            openConnection(false);
        }
        return conn.createStatement();
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 11 * hash + Objects.hashCode(this.conn);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final WHMySQL other = (WHMySQL) obj;
        return Objects.equals(this.conn, other.conn);
    }
}
