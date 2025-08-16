package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Inventario;
import TECHEXPRESS.dao.InventarioDAO;

import java.util.List;

public class InventarioController {

    InventarioDAO dao = new InventarioDAO();

    public void agregarInventario(int estadoID, String nombre, String descripcion, double precio, int cantidad) {
        Inventario inv = new Inventario(0, estadoID, nombre, descripcion, precio, cantidad);
        dao.insertarInventario(inv);
    }

    public void cambiarDescripcion(int itemID, String nuevaDescripcion) {
        dao.actualizarDescripcion(itemID, nuevaDescripcion);
    }

    public void cambiarCantidad(int itemID, int nuevaCantidad) {
        dao.actualizarCantidad(itemID, nuevaCantidad);
    }

    public void borrarInventario(int itemID) {
        dao.eliminarInventario(itemID);
    }

    public List<Inventario> listarTodo() {
        return dao.listarInventario();
    }

    public void mostrarInventarioBajo() {
        dao.listarInventarioBajo();
    }
}
