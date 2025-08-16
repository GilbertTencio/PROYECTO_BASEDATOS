package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.Pago;
import java.sql.*;

public class PagosDAO {
    Conexion con = new Conexion();

    public void registrarPago(Pago p) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call RegistrarPago(?, ?, ?, ?)}");
            cs.setInt(1, p.getServicioRealizado());
            cs.setInt(2, p.getEstadoID());
            cs.setDouble(3, p.getPrecioTotal());
            cs.setString(4, p.getMetodoPago());
            cs.execute();
        } catch (SQLException e) {
        }
    }
}
