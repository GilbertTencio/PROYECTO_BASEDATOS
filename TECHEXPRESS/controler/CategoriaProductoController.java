package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.CategoriaProducto;
import TECHEXPRESS.dao.CategoriaProductoDAO;

public class CategoriaProductoController {
    CategoriaProductoDAO dao = new CategoriaProductoDAO();

    public void agregarCategoria(int itemID, int estadoID, String nombre, String descripcion) {
        CategoriaProducto cp = new CategoriaProducto(0, itemID, estadoID, nombre, descripcion);
        dao.insertarCategoria(cp);
    }
}
