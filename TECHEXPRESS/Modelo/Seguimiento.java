package TECHEXPRESS.Modelo;

import java.util.Date;

public class Seguimiento {
    private int seguimientoID;
    private int estadoID;
    private int servicioRealizado;
    private Date fechaSeguimiento;
    private String descripcion;
    private Date siguienteSeguimiento;

    public Seguimiento() {}

    public Seguimiento(int seguimientoID, int estadoID, int servicioRealizado, Date fechaSeguimiento, String descripcion, Date siguienteSeguimiento) {
        this.seguimientoID = seguimientoID;
        this.estadoID = estadoID;
        this.servicioRealizado = servicioRealizado;
        this.fechaSeguimiento = fechaSeguimiento;
        this.descripcion = descripcion;
        this.siguienteSeguimiento = siguienteSeguimiento;
    }

    // Getters y setters
    public int getSeguimientoID() { return seguimientoID; }
    public void setSeguimientoID(int seguimientoID) { this.seguimientoID = seguimientoID; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public int getServicioRealizado() { return servicioRealizado; }
    public void setServicioRealizado(int servicioRealizado) { this.servicioRealizado = servicioRealizado; }

    public Date getFechaSeguimiento() { return fechaSeguimiento; }
    public void setFechaSeguimiento(Date fechaSeguimiento) { this.fechaSeguimiento = fechaSeguimiento; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public Date getSiguienteSeguimiento() { return siguienteSeguimiento; }
    public void setSiguienteSeguimiento(Date siguienteSeguimiento) { this.siguienteSeguimiento = siguienteSeguimiento; }
}
