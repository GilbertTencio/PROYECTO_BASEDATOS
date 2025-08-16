package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.ServicioCliente;
import TECHEXPRESS.dao.ServicioClienteDAO;

import java.util.Date;

public class ServicioClienteController {
    ServicioClienteDAO dao = new ServicioClienteDAO();

    public void agregarServicio(int empleadoID, int servicioID, int clienteID, int estadoID, Date fecha, int cantidad, double precioTotal) {
        ServicioCliente sc = new ServicioCliente(0, empleadoID, servicioID, clienteID, estadoID, fecha, cantidad, precioTotal);
        dao.insertarServicio(sc);
    }

    public void cambiarEstadoServicio(int servicioRealizado, int nuevoEstadoID) {
        dao.actualizarEstadoServicio(servicioRealizado, nuevoEstadoID);
    }

    public void consultarServiciosPorFecha(Date inicio, Date fin) {
        dao.consultarServiciosPorFecha((java.sql.Date) inicio, (java.sql.Date) fin);
    }
}
