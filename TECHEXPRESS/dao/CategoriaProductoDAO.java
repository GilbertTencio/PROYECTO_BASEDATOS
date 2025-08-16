package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.CategoriaProducto;
import TECHEXPRESS.Modelo.Conexion;

import java.sql.*;

public class CategoriaProductoDAO {
    Conexion con = new Conexion();

    public void insertarCategoria(CategoriaProducto cp) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarCategoriaProducto(?, ?, ?, ?)}");
            cs.setInt(1, cp.getItemID());
            cs.setInt(2, cp.getEstadoID());
            cs.setString(3, cp.getNombre());
            cs.setString(4, cp.getDescripcion());
            cs.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
