package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Conexion;
import TECHEXPRESS.Modelo.Estado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class EstadoDAO {

    Conexion con = new Conexion();

    // Listar todos los estados usando función con cursor
    public List<Estado> listarEstados() {
        List<Estado> lista = new ArrayList<>();
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{? = call fn_ListarEstados}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                Estado e = new Estado();
                e.setEstadoID(rs.getInt("Estado_ID"));
                e.setNombreEstado(rs.getString("Nombre_Estado"));
                e.setDescripcionEstado(rs.getString("Descripcion_Estado"));
                lista.add(e);
            }

        } catch (SQLException ex) {
        }
        return lista;
    }

    // Insertar estado usando SP
    public void insertarEstado(String nombre, String descripcion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarEstado(?,?)}");
            cs.setString(1, nombre);
            cs.setString(2, descripcion);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    // Actualizar estado usando SP
    public void actualizarEstado(int estadoID, String nombre, String descripcion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarEstado(?,?,?)}");
            cs.setInt(1, estadoID);
            cs.setString(2, nombre);
            cs.setString(3, descripcion);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    // Eliminar estado usando SP
    public void eliminarEstado(int estadoID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarEstado(?)}");
            cs.setInt(1, estadoID);
            cs.execute();
        } catch (SQLException ex) {
        }
    }
}
