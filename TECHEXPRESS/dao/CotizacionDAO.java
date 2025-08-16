package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.Cotizacion;
import java.sql.*;

public class CotizacionDAO {

    Conexion con = new Conexion();

    public void insertarCotizacion(Cotizacion c) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarCotizacion(?, ?, ?, ?, ?)}");
            cs.setInt(1, c.getEstadoID());
            cs.setInt(2, c.getItemID());
            cs.setInt(3, c.getServicioID());
            cs.setInt(4, c.getEmpleadoID());
            cs.setDate(5, new java.sql.Date(c.getPosibleFecha().getTime()));
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void eliminarCotizacion(int cotizacionID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarCotizacion(?)}");
            cs.setInt(1, cotizacionID);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void consultarCotizacionesPorFecha(Date inicio, Date fin) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ConsultarCotizacionesPorFecha(?, ?)}");
            cs.setDate(1, new java.sql.Date(inicio.getTime()));
            cs.setDate(2, new java.sql.Date(fin.getTime()));
            cs.execute();
        } catch (SQLException e) {
        }
    }
}
