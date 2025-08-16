package TECHEXPRESS.Modelo;

public class Estado {

    private int estadoID;
    private String nombreEstado;
    private String descripcionEstado;

    public Estado() {
    }

    public Estado(int estadoID, String nombreEstado, String descripcionEstado) {
        this.estadoID = estadoID;
        this.nombreEstado = nombreEstado;
        this.descripcionEstado = descripcionEstado;
    }

    public int getEstadoID() {
        return estadoID;
    }

    public void setEstadoID(int estadoID) {
        this.estadoID = estadoID;
    }

    public String getNombreEstado() {
        return nombreEstado;
    }

    public void setNombreEstado(String nombreEstado) {
        this.nombreEstado = nombreEstado;
    }

    public String getDescripcionEstado() {
        return descripcionEstado;
    }

    public void setDescripcionEstado(String descripcionEstado) {
        this.descripcionEstado = descripcionEstado;
    }
}
