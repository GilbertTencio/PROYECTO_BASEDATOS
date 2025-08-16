package TECHEXPRESS.Modelo;

public class Cliente {
    private int clienteID;
    private int estadoID;
    private String nombre;
    private String apellido;
    private String residencia;
    private String email;

    // Constructor vacío
    public Cliente() {}

    // Constructor completo
    public Cliente(int clienteID, int estadoID, String nombre, String apellido, String residencia, String email) {
        this.clienteID = clienteID;
        this.estadoID = estadoID;
        this.nombre = nombre;
        this.apellido = apellido;
        this.residencia = residencia;
        this.email = email;
    }

    // Getters y Setters
    public int getClienteID() { return clienteID; }
    public void setClienteID(int clienteID) { this.clienteID = clienteID; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getResidencia() { return residencia; }
    public void setResidencia(String residencia) { this.residencia = residencia; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
