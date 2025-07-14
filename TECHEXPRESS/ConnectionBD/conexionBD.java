package TECHEXPRESS.ConnectionBD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class conexionBD {

    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@//192.168.100.82:1521/orclpdb";
        String user = "remoteUser";
        String password = "DBFide1";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Conexión exitosa a Oracle");

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT SYSDATE FROM dual");

            while (rs.next()) {
                System.out.println("🕒 Fecha actual en la BD: " + rs.getString(1));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("❌ Error de conexión:");
            e.printStackTrace();
        }
    }
}
