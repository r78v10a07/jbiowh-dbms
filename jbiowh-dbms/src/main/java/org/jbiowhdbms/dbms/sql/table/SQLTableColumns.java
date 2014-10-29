package org.jbiowhdbms.dbms.sql.table;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Observable;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.jbiowhcore.logger.VerbLogger;
import org.jbiowhdbms.dbms.sql.exception.SQLTableException;

/**
 * This Class is the columns handler in a SQLTable
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2013-03-19 09:38:47 +0100 (Tue, 19 Mar 2013) $
 * $LastChangedRevision: 396 $
 * @since Aug 8, 2012
 */
public class SQLTableColumns extends Observable {

    private final ConcurrentHashMap<String, SQLTableColumn> columns;

    /**
     * Creates the columns handler in a SQLTable
     */
    public SQLTableColumns() {
        columns = new ConcurrentHashMap();
    }

    /**
     * Return the number of columns in the table
     *
     * @return the number of columns in the table
     */
    public int getColumnCount() {
        return columns.size();
    }

    /**
     * Is true if there is not columns in the table
     *
     * @return true if there is not columns in the table
     */
    public boolean isEmpty() {
        return columns.isEmpty();
    }

    /**
     * Maps the specified key to the specified SQLTableColumn column in this
     * table.
     *
     * @param key the column key
     * @param column the SQLTableColumn object
     */
    public void put(String key, SQLTableColumn column) {
        columns.put(key, column);
    }

    /**
     * Removes the key (and its corresponding value) from this map
     *
     * @param key the columns key
     */
    public void remove(String key) {
        setChanged();
        notifyObservers(columns.get(key).getName());
        columns.remove(key);
        reNumColumn();
    }

    /**
     * Add a column to the handler. If the column name variable is null or empty
     * the column key will be column size
     *
     * @param name the column's name
     * @param type the column's data type
     * @param PK true is this column is PK
     * @param NN true is this column is NN
     * @param UQ true is this column is UQ
     * @param AI true is this column is AI
     * @param def the column's default value
     */
    public void addColumn(String name, String type, boolean PK, boolean NN, boolean UQ, boolean AI, Object def) {
        String key;
        if (name == null || name.isEmpty()) {
            key = Integer.toString(columns.size());
        } else {
            key = name;
        }
        columns.put(key, new SQLTableColumn(name, columns.size(), type, PK, NN, UQ, AI, def));
    }

    /**
     * Remove the column by its number
     *
     * @param number the column's number
     */
    public void rmColumn(int number) {
        if (number >= 0 && number < columns.size()) {
            remove(getColumnKey(number));
        }
    }

    /**
     * Return true if the handler contains a column with name: name
     *
     * @param name the column's name
     * @return true if the handler contains a column with name: name
     */
    public boolean containsColumnName(String name) {
        if (!columns.isEmpty() && name != null && !name.isEmpty()) {
            for (SQLTableColumn col : columns.values()) {
                if (col.getName() != null && col.getName().equals(name)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Return the column from its key in the handler
     *
     * @param key the column's key in the handler
     * @return the column from its key in the handler
     */
    public SQLTableColumn getColumn(String key) {
        return columns.get(key);
    }

    /**
     * Return the column from its number in the handler
     *
     * @param number the column's number in the handler
     * @return the column from its number in the handler
     */
    public SQLTableColumn getColumn(int number) {
        if (!columns.isEmpty()) {
            for (SQLTableColumn col : columns.values()) {
                if (col.getNumber() == number) {
                    return col;
                }
            }
        }
        return null;
    }

    /**
     * Return the columns key in the handler. Null if the handler does not
     * contains the column
     *
     * @param col the column SQLTableColumn object
     * @return the columns key in the handler
     */
    public String getColumnKey(SQLTableColumn col) {
        Set<Map.Entry<String, SQLTableColumn>> setKey = columns.entrySet();
        for (Map.Entry me : setKey) {
            if (col.equals(me.getValue())) {
                return (String) me.getKey();
            }
        }
        return null;
    }

    /**
     * Return the columns key in the handler. Null if the handler does not
     * contains the column
     *
     * @param number the column's number in the handler
     * @return the columns key in the handler
     */
    public String getColumnKey(int number) {
        SQLTableColumn col = getColumn(number);
        if (col != null) {
            Set<Map.Entry<String, SQLTableColumn>> setKey = columns.entrySet();
            for (Map.Entry me : setKey) {
                if (col.equals(me.getValue())) {
                    return (String) me.getKey();
                }
            }
        }
        return null;
    }

    /**
     * Return the SQL syntax to create the columns in the table
     *
     * @param indexes the table indexes
     * @return the SQL syntax to create the columns in the table
     * @throws SQLTableException
     */
    public String toSQLFormat(SQLTableIndexes indexes) throws SQLTableException {
        StringBuilder s = new StringBuilder();

        if (columns.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Table needs columns");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Table needs columns");
        }

        List<SQLTableColumn> colList = new ArrayList(columns.values());
        Collections.sort(colList, new ColumnComparator());
        for (Iterator col = colList.iterator(); col.hasNext();) {
            s.append(((SQLTableColumn) col.next()).toSQLFormat());
            if (col.hasNext() || !indexes.isEmpty()) {
                s.append(",");
            }
            s.append("\n");
        }
        return s.toString();
    }

    /**
     * Return a list of the columns sorted by its internal number
     *
     * @return a list of the columns sorted by its internal number
     */
    public List<SQLTableColumn> getColumnSet() {
        List<SQLTableColumn> colList = new ArrayList(columns.values());
        Collections.sort(colList, new SQLTableColumns.ColumnComparator());
        return colList;
    }

    /**
     * Renumbering the column's internal number. This method should be executed
     * after remove or add a columns to the handler
     */
    public void reNumColumn() {
        List<SQLTableColumn> colList = new ArrayList(columns.values());
        Collections.sort(colList, new ColumnComparator());
        int i = 0;
        for (Iterator col = colList.iterator(); col.hasNext();) {
            ((SQLTableColumn) col.next()).setNumber(i++);
        }
    }

    private class ColumnComparator implements Comparator<SQLTableColumn> {

        @Override
        public int compare(SQLTableColumn o1, SQLTableColumn o2) {
            return (o1.getNumber() < o2.getNumber() ? -1 : (o1.equals(o2) ? 0 : 1));
        }
    }
}
