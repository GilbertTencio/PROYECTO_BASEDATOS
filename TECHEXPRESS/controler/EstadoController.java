package TECHEXPRESS.controler;

import TECHEXPRESS.dao.EstadoDAO;
import TECHEXPRESS.Modelo.Estado;
import java.util.List;

public class EstadoController {

    EstadoDAO dao = new EstadoDAO();

    public List<Estado> obtenerEstados() {
        return dao.listarEstados();
    }

    public void agregarEstado(String nombre, String descripcion) {
        dao.insertarEstado(nombre, descripcion);
    }

    public void modificarEstado(int estadoID, String nombre, String descripcion) {
        dao.actualizarEstado(estadoID, nombre, descripcion);
    }

    public void borrarEstado(int estadoID) {
        dao.eliminarEstado(estadoID);
    }
}
