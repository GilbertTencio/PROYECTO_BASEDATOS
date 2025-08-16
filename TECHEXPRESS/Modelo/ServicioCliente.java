package TECHEXPRESS.Modelo;

import java.util.Date;

public class ServicioCliente {
    private int servicioRealizado;
    private int empleadoID;
    private int servicioID;
    private int clienteID;
    private int estadoID;
    private Date fecha;
    private int cantidad;
    private double precioTotal;

    public ServicioCliente() {}

    public ServicioCliente(int servicioRealizado, int empleadoID, int servicioID, int clienteID, int estadoID, Date fecha, int cantidad, double precioTotal) {
        this.servicioRealizado = servicioRealizado;
        this.empleadoID = empleadoID;
        this.servicioID = servicioID;
        this.clienteID = clienteID;
        this.estadoID = estadoID;
        this.fecha = fecha;
        this.cantidad = cantidad;
        this.precioTotal = precioTotal;
    }

    // Getters y Setters
    public int getServicioRealizado() { return servicioRealizado; }
    public void setServicioRealizado(int servicioRealizado) { this.servicioRealizado = servicioRealizado; }

    public int getEmpleadoID() { return empleadoID; }
    public void setEmpleadoID(int empleadoID) { this.empleadoID = empleadoID; }

    public int getServicioID() { return servicioID; }
    public void setServicioID(int servicioID) { this.servicioID = servicioID; }

    public int getClienteID() { return clienteID; }
    public void setClienteID(int clienteID) { this.clienteID = clienteID; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }

    public double getPrecioTotal() { return precioTotal; }
    public void setPrecioTotal(double precioTotal) { this.precioTotal = precioTotal; }
}
