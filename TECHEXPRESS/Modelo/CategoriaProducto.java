package TECHEXPRESS.Modelo;

public class CategoriaProducto {
    private int categoriaID;
    private int itemID;
    private int estadoID;
    private String nombre;
    private String descripcion;

    public CategoriaProducto() {}

    public CategoriaProducto(int categoriaID, int itemID, int estadoID, String nombre, String descripcion) {
        this.categoriaID = categoriaID;
        this.itemID = itemID;
        this.estadoID = estadoID;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // Getters y setters
    public int getCategoriaID() { return categoriaID; }
    public void setCategoriaID(int categoriaID) { this.categoriaID = categoriaID; }

    public int getItemID() { return itemID; }
    public void setItemID(int itemID) { this.itemID = itemID; }

    public int getEstadoID() { return estadoID; }
    public void setEstadoID(int estadoID) { this.estadoID = estadoID; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}
