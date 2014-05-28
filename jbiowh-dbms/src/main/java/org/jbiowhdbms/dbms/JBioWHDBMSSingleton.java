package org.jbiowhdbms.dbms;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import org.jbiowhcore.logger.VerbLogger;

/**
 * This Class is the singleton to keep the DBMS connection
 *
 * $Author$ $LastChangedDate$ $LastChangedRevision$
 *
 * @since Oct 8, 2013
 */
public class JBioWHDBMSSingleton {

    private static JBioWHDBMSSingleton singleton;
    private String mainURL;
    private Map<String, JBioWHDBMS> connections;

    private JBioWHDBMSSingleton() {
        connections = new HashMap();
    }

    /**
     * Return a JBioWHDBMSSingleton instance
     *
     * @return a JBioWHDBMSSingleton instance
     */
    public static synchronized JBioWHDBMSSingleton getInstance() {
        if (singleton == null) {
            singleton = new JBioWHDBMSSingleton();
        }
        return singleton;
    }

    public JBioWHDBMS getWhdbmsFactory() {
        return connections.get(mainURL);
    }

    public JBioWHDBMS getWhdbmsFactory(String URL) {
        return connections.get(parseURL(URL));
    }

    public void setWhdbmsFactory(JBioWHDBMS whdbmsFactory) {
        if (whdbmsFactory != null) {
            if (!connections.containsKey(whdbmsFactory.getUrl())) {
                connections.put(whdbmsFactory.getUrl(), whdbmsFactory);
            }
        }
    }
    
    /**
     * Close all active connections
     *
     * @throws java.sql.SQLException
     */
    public void closeAll() throws SQLException{
        for (String url : connections.keySet()) {
            connections.get(url).closeConnection();
        }
    }
    
    /**
     * Close the main connection using its URL
     *
     * @throws java.sql.SQLException
     */
    public void closeConnection() throws SQLException{
        closeConnection(mainURL);
    }
    
    /**
     * Close the connection using its URL
     *
     * @param url the schema's URL
     * @throws java.sql.SQLException
     */
    public void closeConnection(String url) throws SQLException {
        VerbLogger.getInstance().log(this.getClass(), "Closing connection by url: " + url);
        if (url != null && connections.get(parseURL(url)) != null) {
            VerbLogger.getInstance().log(this.getClass(), "Removing the connection from the Map");
            connections.get(parseURL(url)).closeConnection();
            connections.remove(parseURL(url));
            if (parseURL(url).equals(mainURL)) {
                VerbLogger.getInstance().log(this.getClass(), "The connection is the main");                
                if (!connections.values().isEmpty()) {
                    VerbLogger.getInstance().log(this.getClass(), "Activating the next connection as main");
                    setMainURL(connections.values().iterator().next().getUrl());
                } else {
                    mainURL = null;
                }
            }
        } else {
            throw new NullPointerException("The WHDBMS Factory is not open");
        }
    }

    public String getMainURL() {
        return mainURL;
    }

    public void setMainURL(String mainURL) {
        this.mainURL = parseURL(mainURL);
    }
    
    private String parseURL(String url) {
        String newUrl;
        if (url.startsWith("jdbc")) {
            newUrl = url;
        } else {
            newUrl = "jdbc:mysql://" + url;
        }
        return newUrl;
    }

}
