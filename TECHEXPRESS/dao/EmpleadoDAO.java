package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Empleado;
import TECHEXPRESS.Modelo.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {
    Conexion con = new Conexion();

    public void insertarEmpleado(Empleado e) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarEmpleado(?, ?, ?, ?, ?, ?)}");
            cs.setInt(1, e.getEstadoID());
            cs.setString(2, e.getNombre());
            cs.setString(3, e.getApellido());
            cs.setString(4, e.getEmail());
            cs.setString(5, e.getPuesto());
            cs.setString(6, e.getSalario());
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    public void actualizarEmail(int empleadoID, String nuevoEmail) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarEmailEmpleado(?, ?)}");
            cs.setInt(1, empleadoID);
            cs.setString(2, nuevoEmail);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    public void actualizarSalario(int empleadoID, String nuevoSalario) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarSalarioEmpleado(?, ?)}");
            cs.setInt(1, empleadoID);
            cs.setString(2, nuevoSalario);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    public void eliminarEmpleado(int empleadoID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarEmpleado(?)}"); // Si creas SP eliminar
            cs.setInt(1, empleadoID);
            cs.execute();
        } catch (SQLException ex) {
        }
    }

    // Listar empleados usando función con cursor
    public List<Empleado> listarEmpleados() {
        List<Empleado> lista = new ArrayList<>();
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call FN_LISTAR_EMPLEADOS(?)}");
            cs.registerOutParameter(1, oracle.jdbc.OracleTypes.CURSOR);
            cs.execute();
            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                Empleado e = new Empleado();
                e.setEmpleadoID(rs.getInt("Empleado_ID"));
                e.setEstadoID(rs.getInt("Estado_ID"));
                e.setNombre(rs.getString("Nombre_Empleado"));
                e.setApellido(rs.getString("Apellido_Empleado"));
                e.setEmail(rs.getString("Email_Empleado"));
                e.setPuesto(rs.getString("Puesto"));
                e.setSalario(rs.getString("Salario"));
                lista.add(e);
            }
        } catch (SQLException ex) {
        }
        return lista;
    }
}