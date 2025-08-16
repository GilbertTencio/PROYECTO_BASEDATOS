package TECHEXPRESS.controler.VistasFN;

import TECHEXPRESS.dao.VistasFN.VistaFuncionesDAO;

public class VistaFuncionesController {

    VistaFuncionesDAO dao = new VistaFuncionesDAO();

    public void mostrarCotizacionesDetalle() {
        dao.listarCotizacionesDetalle();
    }

    public void mostrarPagosCompletados() {
        dao.listarPagosCompletados();
    }

    public void mostrarClientesActivos() {
        dao.listarClientesActivos();
    }

    public void mostrarInventarioPrecioAlto() {
        dao.listarInventarioPrecioAlto();
    }

    public void mostrarServiciosRealizadosFecha() {
        dao.listarServiciosRealizadosFecha();
    }

    public void mostrarEmpleadosTecnicos() {
        dao.listarEmpleadosTecnicos();
    }

    public void mostrarPagosEfectivo() {
        dao.listarPagosEfectivo();
    }

    public void mostrarServiciosPorTecnico() {
        dao.listarServiciosPorTecnico();
    }

    public void mostrarHistorialPagosCliente() {
        dao.listarHistorialPagosCliente();
    }

    public void mostrarInventarioConCategoria() {
        dao.listarInventarioConCategoria();
    }

    public void mostrarCotizacionesPendientes() {
        dao.listarCotizacionesPendientes();
    }

    public void mostrarClientesRecientes() {
        dao.listarClientesRecientes();
    }
}
