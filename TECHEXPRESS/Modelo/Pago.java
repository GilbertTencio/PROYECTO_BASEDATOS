package TECHEXPRESS.Modelo;

public class Pago {
    private int pagoID;
    private int servicioRealizado;
    private int estadoID;
    private double precioTotal;
    private String metodoPago;

    public Pago() {}

    public Pago(int pagoID, int servicioRealizado, int estadoID, double precioTotal, String metodoPago) {
        this.pagoID = pagoID;
        this.servicioRealizado = servicioRealizado;
        this.estadoID = estadoID;
        this.precioTotal = precioTotal;
        this.metodoPago = metodoPago;
    }

    // Getters y setters
    public int getPagoID() { return pagoID; }
    public void setPagoID(int pagoID) { this.pagoID = pagoID; }

    public int getServicioRealizado() { return servicioRealizado; }
    public void setServicioRealizado(int servicioRealizado) { this.servicioRealizado = servicioRealizado; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public double getPrecioTotal() { return precioTotal; }
    public void setPrecioTotal(double precioTotal) { this.precioTotal = precioTotal; }

    public String getMetodoPago() { return metodoPago; }
    public void setMetodoPago(String metodoPago) { this.metodoPago = metodoPago; }
}
