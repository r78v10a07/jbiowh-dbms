package org.jbiowhdbms.dbms.sql.exception;

/**
 * This Class is an exception for the SQL Constrains between two non connected 
 * DataSets
 * 
 * @see Exception
 * $Author: r78v10a07@gmail.com $
 * $LastChangedDate: 2012-08-31 15:46:36 +0200 (Fri, 31 Aug 2012) $
 * $LastChangedRevision: 231 $
 * @since Apr 20, 2012
 */
public class SQLConstrainException extends Exception{

    /**
     * Constructs a new SQLConstrain exception with the specified detail message. 
     * The cause is not initialized, and may subsequently be initialized by a call to Exception.initCause.
     * 
     * @param message the detail message. The detail message is saved for later retrieval by the Exception.getMessage() method.
     * @param cause the cause (which is saved for later retrieval by the Exception.getCause() method). (A null value is permitted, and indicates that the cause is nonexistent or unknown.)
     */
    public SQLConstrainException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     *  Create the SQLConstrainException
     * @param message the detail message. The detail message is saved for later retrieval by the Exception.getMessage() method.
     */
    public SQLConstrainException(String message) {
        super(message);
    }

}
