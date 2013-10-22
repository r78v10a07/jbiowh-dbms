package org.jbiowhdbms.dbms.sql.table;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.jbiowhcore.logger.VerbLogger;
import org.jbiowhdbms.dbms.sql.exception.SQLTableException;

/**
 * This Class is the SQL Table Index
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2013-03-19 09:38:47 +0100 (Tue, 19 Mar 2013) $
 * $LastChangedRevision: 396 $
 * @since Aug 6, 2012
 */
public class SQLTableIndex {

    private String name;
    private int number;
    private String type;
    private ConcurrentHashMap<String, SQLTableIndexColumn> columns;

    /**
     * Create a SQL index for a table
     *
     * @param name the index's name
     * @param number the index's number
     * @param type the index's type
     */
    public SQLTableIndex(String name, int number, String type) {
        this.name = name;
        this.number = number;
        this.type = type;
        columns = new ConcurrentHashMap<>();
    }

    /**
     * Create a SQL index for a table
     *
     * @param name the index's name
     * @param number the index's number
     * @param type the index's type
     * @param columns the columns included in this index
     */
    public SQLTableIndex(String name, int number, String type, ConcurrentHashMap<String, SQLTableIndexColumn> columns) {
        this.name = name;
        this.number = number;
        this.type = type;
        this.columns = columns;
    }

    /**
     * Return the number of columns included in the index
     *
     * @return the number of columns included in the index
     */
    public int getIndexColumnCount() {
        return columns.size();
    }

    /**
     * Maps the specified key to the specified SQLTableIndexColumn index in this
     * table.
     *
     * @param key the column key
     * @param column the SQLTableIndexColumn to be mapped
     */
    public void put(String key, SQLTableIndexColumn column) {
        columns.put(key, column);
        reNumIndex();
    }

    /**
     * Removes the key (and its corresponding value) from this map
     *
     * @param key the columns key
     */
    public void remove(String key) {
        columns.remove(key);
    }

    /**
     * Add a column to the index. If the column name variable is null or empty
     * the column key will be column size
     *
     * @param name the column name
     * @param order the column index order
     */
    public void addColumn(String name, String order) {
        String key;
        if (name == null || name.isEmpty()) {
            key = new Integer(columns.size()).toString();
        } else {
            key = name;
        }
        columns.put(key, new SQLTableIndexColumn(name, columns.size(), order, ""));
    }

    /**
     * Return the index column by its name
     *
     * @param name the column name
     * @return the index column by its name
     */
    public SQLTableIndexColumn getIndexColumn(String name) {
        if (!columns.isEmpty()) {
            for (SQLTableIndexColumn col : columns.values()) {
                if (col.getName().equals(name)) {
                    return col;
                }
            }
        }
        return null;
    }

    /**
     * Return the index column by its number
     *
     * @param number the column number
     * @return the index column by its number
     */
    public SQLTableIndexColumn getIndexColumn(int number) {
        if (!columns.isEmpty()) {
            for (SQLTableIndexColumn col : columns.values()) {
                if (col.getNumber() == number) {
                    return col;
                }
            }
        }
        return null;
    }

    /**
     * Remove the index column by its number
     *
     * @param number the column number
     */
    public void rmIndexColumn(int number) {
        if (number >= 0 && number < columns.size()) {
            columns.remove(getIndexColumnKey(number));
            reNumIndex();
        }
    }

    /**
     * Return the map's key for the column
     *
     * @param col the column object
     * @return
     */
    public String getIndexColumnKey(SQLTableIndexColumn col) {
        Set<Map.Entry<String, SQLTableIndexColumn>> setKey = columns.entrySet();
        for (Map.Entry me : setKey) {
            if (col.equals(me.getValue())) {
                return (String) me.getKey();
            }
        }
        return null;
    }

    /**
     * Return the map's key for the column
     *
     * @param number the column's number
     * @return the map's key for the column
     */
    public String getIndexColumnKey(int number) {
        SQLTableIndexColumn col = getIndexColumn(number);
        if (col != null) {
            Set<Map.Entry<String, SQLTableIndexColumn>> setKey = columns.entrySet();
            for (Map.Entry me : setKey) {
                if (col.equals(me.getValue())) {
                    return (String) me.getKey();
                }
            }
        }
        return null;
    }

    /**
     * Return the map's key for the column
     *
     * @param name the column's name
     * @return the map's key for the column
     */
    public String getIndexColumnKey(String name) {
        SQLTableIndexColumn col = getIndexColumn(name);
        if (col != null) {
            Set<Map.Entry<String, SQLTableIndexColumn>> setKey = columns.entrySet();
            for (Map.Entry me : setKey) {
                if (col.equals(me.getValue())) {
                    return (String) me.getKey();
                }
            }
        }
        return null;
    }

    /**
     * Return the index's name
     *
     * @return the index's name
     */
    public String getName() {
        return name;
    }

    /**
     * Set the index's name
     *
     * @param name the index's name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Return the index's number
     *
     * @return the index's number
     */
    public int getNumber() {
        return number;
    }

    /**
     * Set the index's number
     *
     * @param number the index's number
     */
    public void setNumber(int number) {
        this.number = number;
    }

    /**
     * Return the index's type
     *
     * @return the index's type
     */
    public String getType() {
        return type;
    }

    /**
     * Set the index's type
     *
     * @param type the index's type
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Return the index's columns
     *
     * @return the index's columns
     */
    public ConcurrentHashMap<String, SQLTableIndexColumn> getColumns() {
        return columns;
    }

    /**
     * Set the index's columns
     *
     * @param columns the index's columns
     */
    public void setColumns(ConcurrentHashMap<String, SQLTableIndexColumn> columns) {
        this.columns = columns;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 37 * hash + Objects.hashCode(this.name);
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
        final SQLTableIndex other = (SQLTableIndex) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        return true;
    }

    /**
     * Return the SQL syntax to create the index
     *
     * @return the SQL syntax to create the index
     * @throws SQLTableException
     */
    public String toSQLFormat() throws SQLTableException {
        StringBuilder s = new StringBuilder();

        if (name == null || name.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Index's name can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Index's name can not be empty");
        }
        if (type == null || type.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Index's type can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Index's type can not be empty");
        }
        if (!columns.isEmpty()) {
            if (type.equals("PRIMARY")) {
                s.append("PRIMARY KEY (");
                List<SQLTableIndexColumn> colList = new ArrayList<>(columns.values());
                Collections.sort(colList, new ColumnComparator());
                for (Iterator ind = colList.iterator(); ind.hasNext();) {
                    s.append("`").append(((SQLTableIndexColumn) ind.next()).getName()).append("`");
                    if (ind.hasNext()) {
                        s.append(",");
                    }
                }
                s.append(")");
            } else {
                s.append(type).append(" ");
                if (!type.equals("INDEX")) {
                    s.append("INDEX ");
                }
                s.append("`").append(name).append("` (");
                List<SQLTableIndexColumn> colList = new ArrayList<>(columns.values());
                Collections.sort(colList, new ColumnComparator());
                for (Iterator ind = colList.iterator(); ind.hasNext();) {
                    SQLTableIndexColumn col = (SQLTableIndexColumn) ind.next();
                    s.append("`").append(col.getName()).append("`");
                    if (!col.getLength().isEmpty()) {
                        s.append("(").append(col.getLength()).append(")");
                    }
                    if (col.getOrder() == null || col.getOrder().isEmpty()) {
                        col.setOrder("ASC");
                    }
                    s.append(" ").append(col.getOrder()).append(" ");
                    if (ind.hasNext()) {
                        s.append(",");
                    }
                }
                s.append(")");
            }
        } else {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Index's columns can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Index's columns can not be empty");
        }

        return s.toString();
    }

    @Override
    public String toString() {
        return "SQLTableIndex{" + "name=" + name + ", number=" + number + ", type=" + type + ", columns=" + columns + '}';
    }

    /**
     * Renumbering the index's column internal number. This method should be
     * executed after remove or add a columns to the handler
     */
    public void reNumIndex() {
        List<SQLTableIndexColumn> indList = new ArrayList<>(columns.values());
        Collections.sort(indList, new ColumnComparator());
        int i = 0;
        for (Iterator ind = indList.iterator(); ind.hasNext();) {
            ((SQLTableIndexColumn) ind.next()).setNumber(i++);
        }
    }

    private class ColumnComparator implements Comparator<SQLTableIndexColumn> {

        @Override
        public int compare(SQLTableIndexColumn o1, SQLTableIndexColumn o2) {
            return (o1.getNumber() < o2.getNumber() ? -1 : (o1.equals(o2) ? 0 : 1));
        }
    }
}