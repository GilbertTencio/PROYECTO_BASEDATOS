package TECHEXPRESS.controler;

import TECHEXPRESS.dao.GestionServiciosDAO;
import TECHEXPRESS.Modelo.GestionServicios;
import java.util.List;

public class GestionServiciosController {

    GestionServiciosDAO dao = new GestionServiciosDAO();

    public List<GestionServicios> obtenerServicios() {
        return dao.listarServicios();
    }

    public void agregarServicio(int estadoID, int itemID, String nombre, String descripcion) {
        dao.insertarServicio(estadoID, itemID, nombre, descripcion);
    }

    public void modificarServicio(int servicioID, String nombre, String descripcion) {
        dao.actualizarServicio(servicioID, nombre, descripcion);
    }

    public void borrarServicio(int servicioID) {
        dao.eliminarServicio(servicioID);
    }
}
