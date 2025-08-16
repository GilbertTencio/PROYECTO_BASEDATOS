package TECHEXPRESS.Modelo;

import java.util.Date;

public class Cotizacion {

    private int cotizacionID;
    private int estadoID;
    private int itemID;
    private int servicioID;
    private int empleadoID;
    private Date posibleFecha;

    public Cotizacion() {
    }

    public Cotizacion(int cotizacionID, int estadoID, int itemID, int servicioID, int empleadoID, Date posibleFecha) {
        this.cotizacionID = cotizacionID;
        this.estadoID = estadoID;
        this.itemID = itemID;
        this.servicioID = servicioID;
        this.empleadoID = empleadoID;
        this.posibleFecha = posibleFecha;
    }

    // Getters y Setters
    public int getCotizacionID() {
        return cotizacionID;
    }

    public void setCotizacionID(int cotizacionID) {
        this.cotizacionID = cotizacionID;
    }

    public int getEstadoID() {
        return estadoID;
    }

    public void setEstadoID(int estadoID) {
        this.estadoID = estadoID;
    }

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    public int getServicioID() {
        return servicioID;
    }

    public void setServicioID(int servicioID) {
        this.servicioID = servicioID;
    }

    public int getEmpleadoID() {
        return empleadoID;
    }

    public void setEmpleadoID(int empleadoID) {
        this.empleadoID = empleadoID;
    }

    public Date getPosibleFecha() {
        return posibleFecha;
    }

    public void setPosibleFecha(Date posibleFecha) {
        this.posibleFecha = posibleFecha;
    }
}
