package org.jbiowhdbms.dbms.sql.table;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Observable;
import java.util.Observer;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import org.jbiowhdbms.dbms.sql.exception.SQLTableException;

/**
 * This Class handled the indexes in a table
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2012-08-31 15:46:36 +0200 (Fri, 31 Aug 2012) $
 * $LastChangedRevision: 231 $
 * @since Aug 8, 2012
 */
public class SQLTableIndexes implements Observer {

    private final ConcurrentHashMap<String, SQLTableIndex> indexes;

    /**
     * Creates the indexes handler in a SQLTable
     */
    public SQLTableIndexes() {
        indexes = new ConcurrentHashMap();
    }

    /**
     * Return the number of indexes in the table
     *
     * @return the number of indexes in the table
     */
    public int getIndexCount() {
        return indexes.size();
    }

    /**
     * Is true if there is not indexes in the table
     *
     * @return true if there is not indexes in the table
     */
    public boolean isEmpty() {
        return indexes.isEmpty();
    }

    /**
     * Maps the specified key to the specified SQLTableIndex column in this
     * table.
     *
     * @param key the column key
     * @param index the index object
     */
    public void put(String key, SQLTableIndex index) {
        indexes.put(key, index);
        reNumIndex();
    }

    /**
     * Removes the key (and its corresponding value) from this map
     *
     * @param key the columns key
     */
    public void remove(String key) {
        indexes.remove(key);
        reNumIndex();
    }

    /**
     * Add an index to the handler. If the index name variable is null or empty
     * the index key will be index size
     *
     * @param name the index's name
     * @param type the index's type
     */
    public void addIndex(String name, String type) {
        String key;
        if (name == null || name.isEmpty()) {
            key = Integer.toString(indexes.size());
        } else {
            key = name;
        }
        SQLTableIndex index = new SQLTableIndex(name, indexes.size(), type);
        indexes.put(key, index);
    }

    /**
     * Remove the index by its number
     *
     * @param number the index's number
     */
    public void rmIndex(int number) {
        if (number >= 0 && number < indexes.size()) {
            remove(getIndexKey(number));
        }
    }

    /**
     * Return true if the handler contains an index with name: name
     *
     * @param name the index's name
     * @return true if the handler contains an index with name: name
     */
    public boolean containsIndexName(String name) {
        if (!indexes.isEmpty() && name != null && !name.isEmpty()) {
            for (SQLTableIndex ind : indexes.values()) {
                if (ind.getName() != null && ind.getName().equals(name)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Return the index from its key in the handler
     *
     * @param key the index's key in the handler
     * @return the index from its key in the handler
     */
    public SQLTableIndex getIndex(String key) {
        return indexes.get(key);
    }

    /**
     * Return the index from its number in the handler
     *
     * @param number the index's number in the handler
     * @return the index from its number in the handler
     */
    public SQLTableIndex getIndex(int number) {
        if (!indexes.isEmpty()) {
            for (SQLTableIndex ind : indexes.values()) {
                if (ind.getNumber() == number) {
                    return ind;
                }
            }
        }
        return null;
    }

    /**
     * Return the index key in the handler. Null if the handler does not
     * contains the index
     *
     * @param ind the index object
     * @return the index key in the handler
     */
    public String getIndexKey(SQLTableIndex ind) {
        Set<Map.Entry<String, SQLTableIndex>> setKey = indexes.entrySet();
        for (Map.Entry me : setKey) {
            if (ind.equals(me.getValue())) {
                return (String) me.getKey();
            }
        }
        return null;
    }

    /**
     * Return the index key in the handler. Null if the handler does not
     * contains the index
     *
     * @param number the index's number in the handler
     * @return the index key in the handler
     */
    public String getIndexKey(int number) {
        SQLTableIndex ind = getIndex(number);
        if (ind != null) {
            Set<Map.Entry<String, SQLTableIndex>> setKey = indexes.entrySet();
            for (Map.Entry me : setKey) {
                if (ind.equals(me.getValue())) {
                    return (String) me.getKey();
                }
            }
        }
        return null;
    }

    /**
     * Return the index key in the handler. Null if the handler does not
     * contains the index
     *
     * @param name the index's name
     * @return the index key in the handler
     */
    public String getIndexKey(String name) {
        SQLTableIndex ind = getIndex(name);
        if (ind != null) {
            Set<Map.Entry<String, SQLTableIndex>> setKey = indexes.entrySet();
            for (Map.Entry me : setKey) {
                if (ind.equals(me.getValue())) {
                    return (String) me.getKey();
                }
            }
        }
        return null;
    }

    /**
     * Return the SQL syntax to create the index in the table
     *
     * @return
     * @throws SQLTableException
     */
    public String toSQLFormat() throws SQLTableException {
        StringBuilder s = new StringBuilder();

        List<SQLTableIndex> indList = new ArrayList(indexes.values());
        Collections.sort(indList, new IndexComparator());
        for (Iterator ind = indList.iterator(); ind.hasNext();) {
            s.append(((SQLTableIndex) ind.next()).toSQLFormat());
            if (ind.hasNext()) {
                s.append(",");
            }
            s.append("\n");
        }
        return s.toString();
    }

    /**
     * Return a list of the index sorted by its internal number
     *
     * @return a list of the index sorted by its internal number
     */
    public List<SQLTableIndex> getIndexSet() {
        List<SQLTableIndex> indList = new ArrayList(indexes.values());
        Collections.sort(indList, new IndexComparator());
        return indList;
    }

    private void reNumIndex() {
        List<SQLTableIndex> indList = new ArrayList(indexes.values());
        Collections.sort(indList, new IndexComparator());
        int i = 0;
        for (Iterator ind = indList.iterator(); ind.hasNext();) {
            ((SQLTableIndex) ind.next()).setNumber(i++);
        }
    }

    @Override
    public void update(Observable o, Object arg) {
        if (arg != null) {
            for (SQLTableIndex ind : indexes.values()) {
                for (SQLTableIndexColumn col : ind.getColumns().values()) {
                    if (col.getName().equals(arg)) {
                        ind.getColumns().remove(ind.getIndexColumnKey(col.getName()));
                        ind.reNumIndex();
                    }
                }
                if (ind.getIndexColumnCount() == 0) {
                    indexes.remove(getIndexKey(ind.getName()));
                }
            }
        }
    }

    private class IndexComparator implements Comparator<SQLTableIndex> {

        @Override
        public int compare(SQLTableIndex o1, SQLTableIndex o2) {
            return (o1.getNumber() < o2.getNumber() ? -1 : (o1.equals(o2) ? 0 : 1));
        }
    }
}
