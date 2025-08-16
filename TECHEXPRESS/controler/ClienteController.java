package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Cliente;
import TECHEXPRESS.dao.ClienteDAO;

import java.util.List;

public class ClienteController {
    ClienteDAO dao = new ClienteDAO();

    public void crearCliente(int estadoID, String nombre, String apellido, String residencia, String email) {
        Cliente c = new Cliente(0, estadoID, nombre, apellido, residencia, email);
        dao.insertarCliente(c);
    }

    public void modificarCliente(int clienteID, String nombre, String apellido, String residencia, String email) {
        Cliente c = new Cliente(clienteID, 0, nombre, apellido, residencia, email);
        dao.actualizarCliente(c);
    }

    public void borrarCliente(int clienteID) {
        dao.eliminarCliente(clienteID);
    }

    public void buscarPorEmail(String email) {
        dao.buscarClientePorEmail(email);
    }

    public List<Cliente> listarTodos() {
        return dao.listarClientes();
    }
}
