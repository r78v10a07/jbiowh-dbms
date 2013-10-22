package org.jbiowhdbms.dbms.sql.table;

import java.util.Objects;
import org.jbiowhcore.logger.VerbLogger;
import org.jbiowhdbms.dbms.sql.exception.SQLTableException;

/**
 * This Class is the SQL Table Column
 *
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2013-03-19 09:38:47 +0100 (Tue, 19 Mar 2013) $
 * $LastChangedRevision: 396 $
 * @since Aug 6, 2012
 */
public class SQLTableColumn {

    private String name;
    private int number;
    private String type;
    private boolean PK;
    private boolean NN;
    private boolean UQ;
    private boolean AI;
    private Object def;

    /**
     * Creates a table column
     *
     * @param name the column's name
     * @param number the column's number
     * @param type the column's data type
     * @param PK true is this column is PK
     * @param NN true is this column is NN
     * @param UQ true is this column is UQ
     * @param AI true is this column is AI
     * @param def the column's default value
     */
    public SQLTableColumn(String name, int number, String type, boolean PK, boolean NN, boolean UQ, boolean AI, Object def) {
        this.name = name;
        this.number = number;
        this.type = type;
        this.PK = PK;
        this.NN = NN;
        this.UQ = UQ;
        this.AI = AI;
        this.def = def;
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
     * Get the column's type
     *
     * @return the column's type
     */
    public String getType() {
        return type;
    }

    /**
     * Set the column's type
     *
     * @param type the column's type
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * True if column is PK
     *
     * @return true if column is PK
     */
    public boolean isPK() {
        return PK;
    }

    /**
     * Set the column as PK
     *
     * @param PK true if column is PK
     */
    public void setPK(boolean PK) {
        this.PK = PK;
        setNN(PK);
    }

    /**
     * True if column is NN
     *
     * @return rue if column is NN
     */
    public boolean isNN() {
        return NN;
    }

    /**
     * Set the column as NN
     *
     * @param NN true if column is NN
     */
    public void setNN(boolean NN) {
        this.NN = NN;
    }

    /**
     * True if column is UQ
     *
     * @return true if column is UQ
     */
    public boolean isUQ() {
        return UQ;
    }

    /**
     * Set the column as UQ
     *
     * @param UQ true if column is UQ
     */
    public void setUQ(boolean UQ) {
        this.UQ = UQ;
    }

    /**
     * True if column is AI
     *
     * @return true if column is AI
     */
    public boolean isAI() {
        return AI;
    }

    /**
     * Set the column as AI
     *
     * @param AI true if column is AI
     */
    public void setAI(boolean AI) {
        this.AI = AI;
    }

    /**
     * Return the column's default value
     *
     * @return the column's default value
     */
    public Object getDef() {
        return def;
    }

    /**
     * Set the column's default value
     *
     * @param def the column's default value
     */
    public void setDef(Object def) {
        this.def = def;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 79 * hash + Objects.hashCode(this.name);
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
        final SQLTableColumn other = (SQLTableColumn) obj;
        return Objects.equals(this.name, other.name);
    }

    /**
     * Return the SQL syntax to create the columns
     *
     * @return the SQL syntax to create the columns
     * @throws SQLTableException
     */
    public String toSQLFormat() throws SQLTableException {
        StringBuilder s = new StringBuilder();

        if (name == null || name.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Column's name can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Column's name can not be empty");
        }
        if (type == null || type.isEmpty()) {
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().ERROR);
            VerbLogger.getInstance().log(this.getClass(), "Column's type can not be empty");
            VerbLogger.getInstance().setLevel(VerbLogger.getInstance().getInitialLevel());
            throw new SQLTableException("Column's type can not be empty");
        }
        s.append("`").append(name).append("` ").append(type).append(" ");
        if (NN) {
            s.append("NOT ");
        }
        s.append(" NULL ");
        if (AI) {
            s.append(" AUTO_INCREMENT");
        }
        if (def != null) {
            s.append(" DEFAULT ");
            if (def instanceof String) {
                s.append("'").append(def).append("'");
            } else {
                s.append(def);
            }
        }
        return s.toString();
    }
}
