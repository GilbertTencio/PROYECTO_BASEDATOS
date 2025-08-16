package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.Seguimiento;
import java.sql.*;

public class SeguimientoDAO {
    Conexion con = new Conexion();

    public void insertarSeguimiento(Seguimiento s) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarSeguimiento(?, ?, ?, ?, ?, ?)}");
            cs.setInt(1, s.getEstadoID());
            cs.setInt(2, s.getServicioRealizado());
            cs.setDate(3, new java.sql.Date(s.getFechaSeguimiento().getTime()));
            cs.setString(4, s.getDescripcion());
            cs.setDate(5, new java.sql.Date(s.getSiguienteSeguimiento().getTime()));
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void consultarPorServicio(int servicioRealizado) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ConsultarSeguimientoServicio(?)}");
            cs.setInt(1, servicioRealizado);
            cs.execute();
        } catch (SQLException e) {
        }
    }
}
