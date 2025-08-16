package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Pago;
import TECHEXPRESS.dao.PagosDAO;

public class PagosController {
    PagosDAO dao = new PagosDAO();

    public void agregarPago(int servicioRealizado, int estadoID, double precioTotal, String metodoPago) {
        Pago p = new Pago(0, servicioRealizado, estadoID, precioTotal, metodoPago);
        dao.registrarPago(p);
    }
}
