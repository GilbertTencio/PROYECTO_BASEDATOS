package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.ServicioCliente;
import java.sql.*;

public class ServicioClienteDAO {

    Conexion con = new Conexion();

    public void insertarServicio(ServicioCliente sc) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarServicioCliente(?, ?, ?, ?, ?, ?, ?, ?)}");
            cs.setInt(1, sc.getEmpleadoID());
            cs.setInt(2, sc.getServicioID());
            cs.setInt(3, sc.getClienteID());
            cs.setInt(4, sc.getEstadoID());
            cs.setDate(5, new java.sql.Date(sc.getFecha().getTime()));
            cs.setInt(6, sc.getCantidad());
            cs.setDouble(7, sc.getPrecioTotal());
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void actualizarEstadoServicio(int servicioRealizado, int nuevoEstadoID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarEstadoServicioRealizado(?, ?)}");
            cs.setInt(1, servicioRealizado);
            cs.setInt(2, nuevoEstadoID);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void consultarServiciosPorFecha(Date inicio, Date fin) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ConsultarServiciosPorFecha(?, ?)}");
            cs.setDate(1, new java.sql.Date(inicio.getTime()));
            cs.setDate(2, new java.sql.Date(fin.getTime()));
            cs.execute();
        } catch (SQLException e) {
        }
    }
}
