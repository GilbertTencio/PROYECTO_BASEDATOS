package TECHEXPRESS.Modelo;

public class GestionServicios {

    private int servicioID;
    private int estadoID;
    private int itemID;
    private String nombreServicio;
    private String descripcionServicio;

    public GestionServicios() {
    }

    public GestionServicios(int servicioID, int estadoID, int itemID, String nombreServicio, String descripcionServicio) {
        this.servicioID = servicioID;
        this.estadoID = estadoID;
        this.itemID = itemID;
        this.nombreServicio = nombreServicio;
        this.descripcionServicio = descripcionServicio;
    }

    public int getServicioID() {
        return servicioID;
    }

    public void setServicioID(int servicioID) {
        this.servicioID = servicioID;
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

    public String getNombreServicio() {
        return nombreServicio;
    }

    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }

    public String getDescripcionServicio() {
        return descripcionServicio;
    }

    public void setDescripcionServicio(String descripcionServicio) {
        this.descripcionServicio = descripcionServicio;
    }
}
