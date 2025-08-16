package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Cotizacion;
import TECHEXPRESS.dao.CotizacionDAO;
import java.util.Date;

public class CotizacionController {

    CotizacionDAO dao = new CotizacionDAO();

    public void agregarCotizacion(int estadoID, int itemID, int servicioID, int empleadoID, Date fecha) {
        Cotizacion c = new Cotizacion(0, estadoID, itemID, servicioID, empleadoID, fecha);
        dao.insertarCotizacion(c);
    }

    public void borrarCotizacion(int cotizacionID) {
        dao.eliminarCotizacion(cotizacionID);
    }

    public void consultarPorFecha(java.util.Date inicio, java.util.Date fin) {
        java.sql.Date sqlInicio = new java.sql.Date(inicio.getTime());
        java.sql.Date sqlFin = new java.sql.Date(fin.getTime());
        dao.consultarCotizacionesPorFecha(sqlInicio, sqlFin);
    }

}
