package TECHEXPRESS.dao;

import TECHEXPRESS.Modelo.Cliente;
import TECHEXPRESS.Modelo.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

public class ClienteDAO {
    Conexion con = new Conexion();

    // Insertar cliente usando SP
    public void insertarCliente(Cliente c) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call InsertarCliente(?, ?, ?, ?, ?)}");
            cs.setInt(1, c.getEstadoID());
            cs.setString(2, c.getNombre());
            cs.setString(3, c.getApellido());
            cs.setString(4, c.getResidencia());
            cs.setString(5, c.getEmail());
            cs.execute();
        } catch (SQLException e) {
        }
    }

    // Actualizar cliente usando SP
    public void actualizarCliente(Cliente c) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call ActualizarCliente(?, ?, ?, ?, ?)}");
            cs.setInt(1, c.getClienteID());
            cs.setString(2, c.getNombre());
            cs.setString(3, c.getApellido());
            cs.setString(4, c.getResidencia());
            cs.setString(5, c.getEmail());
            cs.execute();
        } catch (SQLException e) {
        }
    }

    // Eliminar cliente usando SP
    public void eliminarCliente(int clienteID) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call EliminarCliente(?)}");
            cs.setInt(1, clienteID);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    // Buscar cliente por email usando SP
    public void buscarClientePorEmail(String email) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call BuscarClientePorEmail(?)}");
            cs.setString(1, email);
            cs.execute();
        } catch (SQLException e) {
        }
    }

    // Listar todos los clientes usando un procedimiento con cursor (si creas uno)
    public List<Cliente> listarClientes() {
        List<Cliente> lista = new ArrayList<>();
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{call FN_LISTAR_CLIENTES(?)}");
            cs.registerOutParameter(1, OracleTypes.CURSOR); // Requiere import oracle.jdbc.OracleTypes
            cs.execute();
            ResultSet rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setClienteID(rs.getInt("Cliente_ID"));
                c.setEstadoID(rs.getInt("Estado_ID"));
                c.setNombre(rs.getString("Nombre_Cliente"));
                c.setApellido(rs.getString("Apellido_Cliente"));
                c.setResidencia(rs.getString("Residencia_Cliente"));
                c.setEmail(rs.getString("Email_Cliente"));
                lista.add(c);
            }
        } catch (SQLException e) {
        }
        return lista;
    }
}
