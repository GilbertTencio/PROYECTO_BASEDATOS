package TECHEXPRESS.Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    Connection con;
    String url = "jdbc:oracle:thin:@//192.168.100.82:1521/orclpdb";
    String user = "remoteUser";
    String pass = "DBFide1";

    public Connection conectar() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException e) {
        }
        return con;
    }
}
