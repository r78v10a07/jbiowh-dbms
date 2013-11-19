package org.jbiowhdbms.dbms.sql.table;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import org.jbiowhcore.logger.VerbLogger;
import org.jbiowhdbms.dbms.sql.exception.SQLTableException;

/**
 * This Class is the SQL Table
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2013-03-19 09:38:47 +0100 (Tue, 19 Mar 2013) $
 * $LastChangedRevision: 396 $
 * @since Aug 6, 2012
 */
public class SQLTable {

    private String name;
    private String engine;
    private SQLTableColumns columns;
    private SQLTableIndexes indexes;

    /**
     * Creates a SQL Table object
     *
     */
    public SQLTable() {
        columns = new SQLTableColumns();
        indexes = new SQLTableIndexes();
        columns.addObserver(indexes);
    }

    /**
     * Creates a SQL Table object
     *
     * @param name the SQL table name
     */
    public SQLTable(String name) {
        this.name = name;
        columns = new SQLTableColumns();
        indexes = new SQLTableIndexes();
        columns.addObserver(indexes);
    }

    /**
     * Creates a SQL Table object
     *
     * @param name the SQL table name
     * @param engine the SQL table engine
     */
    public SQLTable(String name, String engine) {
        this.name = name;
        this.engine = engine;
        columns = new SQLTableColumns();
        indexes = new SQLTableIndexes();
        columns.addObserver(indexes);
    }

    /**
     * Creates a SQL Table object
     *
     * @param name the SQL table name
     * @param engine the SQL table engine
     * @param columns the SQL table columns
     */
    public SQLTable(String name, String engine, SQLTableColumns columns) {
        this.name = name;
        this.engine = engine;
        this.columns = columns;
        indexes = new SQLTableIndexes();
        columns.addObserver(indexes);
    }

    /**
     * Creates a SQL Table object
     *
     * @param name the SQL table name
     * @param engine the SQL table engine
     * @param columns the SQL table columns
     * @param indexes the SQL table indexes
     */
    public SQLTable(String name, String engine, SQLTableColumns columns, SQLTableIndexes indexes) {
        this.name = name;
        this.engine = engine;
        this.columns = columns;
        this.indexes = indexes;
        columns.addObserver(indexes);
    }

    /**
     * Return the table's name
     *
     * @return the table's name
     */
    public String getName() {
        return name;
    }

    /**
     * Set the table's name
     *
     * @param name the table's name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Return the table's engine
     *
     * @return the table's engine
     */
    public String getEngine() {
        return engine;
    }

    /**
     * Set the table's engine
     *
     * @param engine the table's engine
     */
    public void setEngine(String engine) {
        this.engine = engine;
    }

    /**
     * Return the table's columns
     *
     * @return the table's columns
     */
    public SQLTableColumns getColumns() {
        return columns;
    }

    /**
     * Set the table's columns
     *
     * @param columns the table's columns
     */
    public void setColumns(SQLTableColumns columns) {
        this.columns = columns;
    }

    /**
     * Return the table's indexes
     *
     * @return the table's indexes
     */
    public SQLTableIndexes getIndexes() {
        return indexes;
    }

    /**
     * Set the table's indexes
     *
     * @param indexes the table's indexes
     */
    public void setIndexes(SQLTableIndexes indexes) {
        this.indexes = indexes;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 13 * hash + Objects.hashCode(this.name);
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
        final SQLTable other = (SQLTable) obj;
        return Objects.equals(this.name, other.name);
    }

    /**
     * Creates the Primary Key from the columns
     *
     * @return the SQLTableIndex object with the PK
     */
    public SQLTableIndex createPrimaryKey() {
        List<String> names = new ArrayList();
        List<SQLTableColumn> colList = columns.getColumnSet();
        for (SQLTableColumn col : colList) {
            if (col.isPK()) {
                names.add(col.getName());
            }
        }
        if (!names.isEmpty()) {
            ConcurrentHashMap<String, SQLTableIndexColumn> indexColumn = new ConcurrentHashMap();
            int i = 0;
            for (String n : names) {
                indexColumn.put(n, new SQLTableIndexColumn(n, i++, "ASC", ""));
            }
            return new SQLTableIndex("PRIMARY", -1, "PRIMARY", indexColumn);
        }
        return null;
    }
    
    /**
     * Creates the Unique Key from the columns
     *
     * @return the SQLTableIndex object with the PK
     */
    public SQLTableIndex createUniqueKey() {
        List<String> names = new ArrayList();
        List<SQLTableColumn> colList = columns.getColumnSet();
        for (SQLTableColumn col : colList) {
            if (col.isUQ()) {
                names.add(col.getName());
            }
        }
        if (!names.isEmpty()) {
            ConcurrentHashMap<String, SQLTableIndexColumn> indexColumn = new ConcurrentHashMap();
            int i = 0;
            for (String n : names) {
                indexColumn.put(n, new SQLTableIndexColumn(n, i++, "ASC", ""));
            }
            return new SQLTableIndex("pk_UNIQUE", -1, "UNIQUE", indexColumn);
        }
        return null;
    }

    /**
     * Return the SQL syntax to create the table
     *
     * @return the SQL syntax to create the table
     * @throws SQLTableException
     */
    public String toSQLFormat() throws SQLTableException {
        StringBuilder s = new StringBuilder();

        if (name == null || name.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Table's name can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException(" Table's name can not be empty");
        }

        s.append("CREATE  TABLE IF NOT EXISTS `").append(name).append("` (\n");
        s.append(columns.toSQLFormat(indexes));
        s.append(indexes.toSQLFormat());
        if (engine == null || engine.isEmpty()) {
            s.append(")ENGINE = MyISAM;\n");
        } else {
            s.append(")ENGINE = ").append(engine).append(";\n\n");
        }
        return s.toString();
    }
}