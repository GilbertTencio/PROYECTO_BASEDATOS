package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Seguimiento;
import TECHEXPRESS.dao.SeguimientoDAO;

import java.util.Date;

public class SeguimientoController {
    SeguimientoDAO dao = new SeguimientoDAO();

    public void agregarSeguimiento(int estadoID, int servicioRealizado, Date fecha, String descripcion, Date siguiente) {
        Seguimiento s = new Seguimiento(0, estadoID, servicioRealizado, fecha, descripcion, siguiente);
        dao.insertarSeguimiento(s);
    }

    public void consultarPorServicio(int servicioRealizado) {
        dao.consultarPorServicio(servicioRealizado);
    }
}
