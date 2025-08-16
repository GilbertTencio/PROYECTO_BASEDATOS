package TECHEXPRESS.dao.VistasFN;

import TECHEXPRESS.Modelo.Conexion;
import oracle.jdbc.OracleTypes;

import java.sql.*;

public class VistaFuncionesDAO {

    Conexion con = new Conexion();

    // 1️ Cotizaciones Detalle
    public void listarCotizacionesDetalle() {
        ejecutarFuncionCursor("fn_CotizacionesDetalle");
    }

    // 2️ Pagos Completados
    public void listarPagosCompletados() {
        ejecutarFuncionCursor("fn_PagosCompletados");
    }

    // 3️ Clientes Activos
    public void listarClientesActivos() {
        ejecutarFuncionCursor("fn_ClientesActivos");
    }

    // 4️ Inventario Precio Alto
    public void listarInventarioPrecioAlto() {
        ejecutarFuncionCursor("fn_InventarioPrecioAlto");
    }

    // 5️ Servicios Realizados por Fecha
    public void listarServiciosRealizadosFecha() {
        ejecutarFuncionCursor("fn_ServiciosRealizadosFecha");
    }

    // 6️ Empleados Técnicos
    public void listarEmpleadosTecnicos() {
        ejecutarFuncionCursor("fn_EmpleadosTecnicos");
    }

    // 7️ Pagos en Efectivo
    public void listarPagosEfectivo() {
        ejecutarFuncionCursor("fn_PagosEfectivo");
    }

    // 8 Servicios por Técnico
    public void listarServiciosPorTecnico() {
        ejecutarFuncionCursor("fn_ServiciosPorTecnico");
    }

    // 9️ Historial Pagos Cliente
    public void listarHistorialPagosCliente() {
        ejecutarFuncionCursor("fn_HistorialPagosCliente");
    }

    // 10 Inventario con Categoría
    public void listarInventarioConCategoria() {
        ejecutarFuncionCursor("fn_InventarioConCategoria");
    }

    // 11 Cotizaciones Pendientes
    public void listarCotizacionesPendientes() {
        ejecutarFuncionCursor("fn_CotizacionesPendientes");
    }

    // 12 Clientes Recientes
    public void listarClientesRecientes() {
        ejecutarFuncionCursor("fn_ClientesRecientes");
    }

    // Método privado genérico para ejecutar cualquier función de cursor
    private void ejecutarFuncionCursor(String nombreFuncion) {
        try (Connection cn = con.conectar()) {
            CallableStatement cs = cn.prepareCall("{? = call " + nombreFuncion + "}");
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();

            ResultSet rs = (ResultSet) cs.getObject(1);
            ResultSetMetaData md = rs.getMetaData();
            int columnas = md.getColumnCount();

            while (rs.next()) {
                for (int i = 1; i <= columnas; i++) {
                    System.out.print(md.getColumnName(i) + ": " + rs.getString(i) + " | ");
                }
                System.out.println();
            }

        } catch (SQLException e) {
        }
    }
}
