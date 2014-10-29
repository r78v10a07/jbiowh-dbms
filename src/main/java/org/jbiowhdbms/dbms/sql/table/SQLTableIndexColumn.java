package org.jbiowhdbms.dbms.sql.table;

import java.util.Objects;

/**
 * This Class is the SQLtable index colum
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2012-08-31 15:46:36 +0200 (Fri, 31 Aug 2012) $
 * $LastChangedRevision: 231 $
 * @since Aug 6, 2012
 */
public class SQLTableIndexColumn {

    private String name;
    private int number;
    private String order;
    private String length;

    /**
     * Create the SQL Table Index Column
     *
     * @param name the column name
     * @param number the number
     * @param order the order (ASC or DECS)
     * @param length the index length
     */
    public SQLTableIndexColumn(String name, int number, String order, String length) {
        this.name = name;
        this.number = number;
        this.order = order;
        this.length = length;
    }

    /**
     * Return the column's name
     *
     * @return the column's name
     */
    public String getName() {
        return name;
    }

    /**
     * Set the column's name
     *
     * @param name the column's name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Return the column's number
     *
     * @return the column's number
     */
    public int getNumber() {
        return number;
    }

    /**
     * Set the column's number
     *
     * @param number the column's number
     */
    public void setNumber(int number) {
        this.number = number;
    }

    /**
     * Return the the column's order
     *
     * @return the column's order
     */
    public String getOrder() {
        return order;
    }

    /**
     * Set the column's order
     *
     * @param order the column's order
     */
    public void setOrder(String order) {
        this.order = order;
    }

    /**
     * Return the column's length
     *
     * @return the column's length
     */
    public String getLength() {
        return length;
    }

    /**
     * Set the column's length
     *
     * @param length the column's length
     */
    public void setLength(String length) {
        this.length = length;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 59 * hash + Objects.hashCode(this.name);
        hash = 59 * hash + this.number;
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
        final SQLTableIndexColumn other = (SQLTableIndexColumn) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        return this.number == other.number;
    }

    @Override
    public String toString() {
        return "SQLTableIndexColumn{" + "name=" + name + ", number=" + number + ", order=" + order + ", length=" + length + '}';
    }
}
