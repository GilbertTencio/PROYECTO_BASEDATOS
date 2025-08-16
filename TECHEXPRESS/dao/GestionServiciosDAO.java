package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.GestionServicios;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class GestionServiciosDAO {

    Conexion con = new Conexion();

    // Listar todos los servicios
    public List<GestionServicios> listarServicios() {
        List<GestionServicios> lista = new ArrayList<>();
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{? = call fn_ListarServicios}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                GestionServicios gs = new GestionServicios();
                gs.setServicioID(rs.getInt("Servicio_ID"));
                gs.setEstadoID(rs.getInt("Estado_ID"));
                gs.setItemID(rs.getInt("Item_ID"));
                gs.setNombreServicio(rs.getString("Nombre_Servicio"));
                gs.setDescripcionServicio(rs.getString("Descripcion_Servicio"));
                lista.add(gs);
            }

        } catch (SQLException ex) {
        }
        return lista;
    }

    // Insertar nuevo servicio
    public void insertarServicio(int estadoID, int itemID, String nombre, String descripcion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarGestionServicio(?,?,?,?)}");
            cs.setInt(1, estadoID);
            cs.setInt(2, itemID);
            cs.setString(3, nombre);
            cs.setString(4, descripcion);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    // Actualizar servicio
    public void actualizarServicio(int servicioID, String nombre, String descripcion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarGestionServicio(?,?,?)}");
            cs.setInt(1, servicioID);
            cs.setString(2, nombre);
            cs.setString(3, descripcion);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    // Eliminar servicio
    public void eliminarServicio(int servicioID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarGestionServicio(?)}");
            cs.setInt(1, servicioID);
            cs.execute();
        } catch (SQLException ex) {
        }
    }
}
