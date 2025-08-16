package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Inventario;
import oracle.jdbc.OracleTypes;
import TECHEXPRESS.Modelo.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventarioDAO {

    Conexion con = new Conexion();

    public void insertarInventario(Inventario inv) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarInventario(?, ?, ?, ?, ?)}");
            cs.setInt(1, inv.getEstadoID());
            cs.setString(2, inv.getNombre());
            cs.setString(3, inv.getDescripcion());
            cs.setDouble(4, inv.getPrecioUnitario());
            cs.setInt(5, inv.getCantidad());
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void actualizarDescripcion(int itemID, String nuevaDescripcion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarDescripcionInventario(?, ?)}");
            cs.setInt(1, itemID);
            cs.setString(2, nuevaDescripcion);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void actualizarCantidad(int itemID, int nuevaCantidad) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarCantidadInventario(?, ?)}");
            cs.setInt(1, itemID);
            cs.setInt(2, nuevaCantidad);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    public void eliminarInventario(int itemID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarInventario(?)}");
            cs.setInt(1, itemID);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    // Listar inventario ()
    public List<Inventario> listarInventario() {
        List<Inventario> lista = new ArrayList<>();
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call FN_LISTAR_INVENTARIO(?)}");
            cs.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
            cs.execute();
            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                Inventario inv = new Inventario();
                inv.setItemID(rs.getInt("Item_ID"));
                inv.setEstadoID(rs.getInt("Estado_ID"));
                inv.setNombre(rs.getString("Nombre_Item"));
                inv.setDescripcion(rs.getString("Descripcion_Item"));
                inv.setPrecioUnitario(rs.getDouble("Precio_Unitario"));
                inv.setCantidad(rs.getInt("Cantidad_Item"));
                lista.add(inv);
            }
        } catch (SQLException e) {
        }
        return lista;
    }

    public void listarInventarioBajo() {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{? = call fn_InventarioBajo}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                System.out.println("Item: " + rs.getString("Nombre_Item")
                        + " | Cantidad: " + rs.getInt("Cantidad_Item"));
            }
        } catch (SQLException e) {
        }
    }
}
