package TECHEXPRESS.dao.VistasFN;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import TECHEXPRESS.Modelo.Conexion;
import oracle.jdbc.OracleTypes;

public class VistaServiciosDAO {

    Conexion con = new Conexion();

    public void listarServiciosActivos() {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{? = call fn_ServiciosActivosTecnico}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                System.out.println("Técnico: " + rs.getString("Tecnico")
                        + " | Servicio: " + rs.getString("Nombre_Servicio")
                        + " | Fecha: " + rs.getDate("Fecha_ID")
                        + " | Precio: " + rs.getDouble("Precio_Total"));
            }
        } catch (SQLException e) {
        }
    }
}
