package TECHEXPRESS.Tests;

import TECHEXPRESS.controler.VistasFN.VistaFuncionesController;

public class TestConsola {
    public static void main(String[] args) {
        VistaFuncionesController controller = new VistaFuncionesController();

        System.out.println("===== LISTA DE CLIENTES ACTIVOS =====");
        controller.mostrarClientesActivos();
    }
}
