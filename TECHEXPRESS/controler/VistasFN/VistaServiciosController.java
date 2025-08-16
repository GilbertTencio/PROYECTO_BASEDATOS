package TECHEXPRESS.controler.VistasFN;

import TECHEXPRESS.dao.VistasFN.VistaServiciosDAO;

public class VistaServiciosController {
    VistaServiciosDAO dao = new VistaServiciosDAO();

    public void mostrarServiciosActivos() {
        dao.listarServiciosActivos();
    }
}
