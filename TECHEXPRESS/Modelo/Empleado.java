package TECHEXPRESS.Modelo;

public class Empleado {
    private int empleadoID;
    private int estadoID;
    private String nombre;
    private String apellido;
    private String email;
    private String puesto;
    private String salario;

    public Empleado() {}

    public Empleado(int empleadoID, int estadoID, String nombre, String apellido, String email, String puesto, String salario) {
        this.empleadoID = empleadoID;
        this.estadoID = estadoID;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.puesto = puesto;
        this.salario = salario;
    }

    // Getters y Setters
    public int getEmpleadoID() { return empleadoID; }
    public void setEmpleadoID(int empleadoID) { this.empleadoID = empleadoID; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPuesto() { return puesto; }
    public void setPuesto(String puesto) { this.puesto = puesto; }

    public String getSalario() { return salario; }
    public void setSalario(String salario) { this.salario = salario; }
}
