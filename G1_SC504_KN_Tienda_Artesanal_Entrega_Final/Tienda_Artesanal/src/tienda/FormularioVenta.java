package tienda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.awt.GridLayout;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/* ---------------------------------------------------------------
 * FORMULARIO VENTA
 * --------------------------------------------------------------- */
class FormularioVenta extends JDialog {
    private Connection connection;
    private boolean ventaRealizada = false;
    private int idVenta;
    private DefaultTableModel modeloDetalles;
    private JTable tablaDetalles;
    private JLabel lblTotal;
    private double totalVenta = 0.0;
    
    // Componentes del formulario
    private JComboBox<String> cbClientes, cbEmpleados;
    private JButton btnAgregarProducto;
    
    public FormularioVenta(Connection connection) {
        this.connection = connection;
        
        setTitle("Nueva Venta");
        setSize(800, 600);
        setModal(true);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout(5, 5));
        
        initComponents();
        generarNuevoIdVenta();
    }
    
    private void initComponents() {
        // Panel superior para datos generales
        JPanel panelSuperior = new JPanel(new GridLayout(0, 2, 10, 10));
        
        // Generar ID de venta (se hace automáticamente)
        JTextField txtIdVenta = new JTextField();
        txtIdVenta.setEditable(false);
        txtIdVenta.setText("Generando...");
        
        // Combo boxes para cliente y empleado
        cbClientes = new JComboBox<>();
        cbEmpleados = new JComboBox<>();
        
        cargarClientes();
        cargarEmpleados();
        
        panelSuperior.add(new JLabel("ID Venta:"));
        panelSuperior.add(txtIdVenta);
        panelSuperior.add(new JLabel("Cliente:"));
        panelSuperior.add(cbClientes);
        panelSuperior.add(new JLabel("Empleado:"));
        panelSuperior.add(cbEmpleados);
        
        // Tabla para detalles de venta
        modeloDetalles = new DefaultTableModel() {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        modeloDetalles.addColumn("ID");
        modeloDetalles.addColumn("Producto");
        modeloDetalles.addColumn("Cantidad");
        modeloDetalles.addColumn("Precio Unit.");
        modeloDetalles.addColumn("Descuento (%)");
        modeloDetalles.addColumn("Subtotal");
        
        tablaDetalles = new JTable(modeloDetalles);
        tablaDetalles.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        
        JScrollPane scrollTabla = new JScrollPane(tablaDetalles);
        
        // Panel inferior con total y botones
        JPanel panelInferior = new JPanel(new BorderLayout(5, 5));
        
        lblTotal = new JLabel("Total: $0.00", SwingConstants.RIGHT);
        lblTotal.setFont(new Font("Arial", Font.BOLD, 16));
        
        JPanel panelBotones = new JPanel(new FlowLayout(FlowLayout.RIGHT, 5, 5));
        btnAgregarProducto = new JButton("Agregar Producto");
        JButton btnFinalizar = new JButton("Finalizar Venta");
        JButton btnCancelar = new JButton("Cancelar");
        
        panelBotones.add(btnAgregarProducto);
        panelBotones.add(btnFinalizar);
        panelBotones.add(btnCancelar);
        
        panelInferior.add(lblTotal, BorderLayout.NORTH);
        panelInferior.add(panelBotones, BorderLayout.SOUTH);
        
        // Agregar componentes al diálogo
        add(panelSuperior, BorderLayout.NORTH);
        add(scrollTabla, BorderLayout.CENTER);
        add(panelInferior, BorderLayout.SOUTH);
        
        // Listeners
        btnAgregarProducto.addActionListener(e -> agregarProducto());
        btnFinalizar.addActionListener(e -> finalizarVenta());
        btnCancelar.addActionListener(e -> dispose());
    }
    
    private void generarNuevoIdVenta() {
        try {
            // Obtener el próximo ID de venta disponible
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT NVL(MAX(ID_Venta), 0) + 1 FROM Ventas");
            
            if (rs.next()) {
                idVenta = rs.getInt(1);
                ((JTextField) ((JPanel) getContentPane().getComponent(0)).getComponent(1)).setText(String.valueOf(idVenta));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al generar ID de venta: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void cargarClientes() {
        try {
            cbClientes.removeAllItems();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(
                    "SELECT ID_Cliente, Nombre || ' ' || Apellido AS NombreCompleto FROM Clientes ORDER BY Nombre");
            
            while (rs.next()) {
                cbClientes.addItem(rs.getInt("ID_Cliente") + " - " + rs.getString("NombreCompleto"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al cargar clientes: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void cargarEmpleados() {
        try {
            cbEmpleados.removeAllItems();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(
                    "SELECT ID_Empleado, Nombre || ' ' || Apellido AS NombreCompleto FROM Empleados ORDER BY Nombre");
            
            while (rs.next()) {
                cbEmpleados.addItem(rs.getInt("ID_Empleado") + " - " + rs.getString("NombreCompleto"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al cargar empleados: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void agregarProducto() {
        try {
            // Obtener lista de productos disponibles
            JComboBox<String> cbProductos = new JComboBox<>();
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(
                    "SELECT ID_Producto, Nombre FROM Productos WHERE Stock > 0 ORDER BY Nombre");
            
            while (rs.next()) {
                cbProductos.addItem(rs.getInt("ID_Producto") + " - " + rs.getString("Nombre"));
            }
            
            if (cbProductos.getItemCount() == 0) {
                JOptionPane.showMessageDialog(this, "No hay productos disponibles en stock", 
                        "Error", JOptionPane.WARNING_MESSAGE);
                return;
            }
            
            // Crear diálogo para seleccionar producto y cantidad
            JDialog dialogoProducto = new JDialog(this, "Agregar Producto", true);
            dialogoProducto.setLayout(new GridLayout(0, 2, 10, 10));
            
            JTextField txtCantidad = new JTextField("1");
            JTextField txtDescuento = new JTextField("0");
            
            JButton btnAgregar = new JButton("Agregar");
            JButton btnCancelar = new JButton("Cancelar");
            
            dialogoProducto.add(new JLabel("Producto:"));
            dialogoProducto.add(cbProductos);
            dialogoProducto.add(new JLabel("Cantidad:"));
            dialogoProducto.add(txtCantidad);
            dialogoProducto.add(new JLabel("Descuento (%):"));
            dialogoProducto.add(txtDescuento);
            dialogoProducto.add(btnAgregar);
            dialogoProducto.add(btnCancelar);
            
            btnAgregar.addActionListener(e -> {
                try {
                    int idProducto = Integer.parseInt(((String) cbProductos.getSelectedItem()).split(" - ")[0]);
                    int cantidad = Integer.parseInt(txtCantidad.getText());
                    double descuento = Double.parseDouble(txtDescuento.getText());
                    
                    // Validar descuento
                    if (descuento < 0 || descuento > 100) {
                        JOptionPane.showMessageDialog(dialogoProducto, "El descuento debe estar entre 0 y 100%",
                                "Error", JOptionPane.ERROR_MESSAGE);
                        return;
                    }
                    
                    // Obtener información del producto
                    PreparedStatement pstmt = connection.prepareStatement(
                            "SELECT Nombre, Precio FROM Productos WHERE ID_Producto = ?");
                    pstmt.setInt(1, idProducto);
                    ResultSet rsProducto = pstmt.executeQuery();
                    
                    if (rsProducto.next()) {
                        String nombreProducto = rsProducto.getString("Nombre");
                        double precio = rsProducto.getDouble("Precio");
                        double subtotal = cantidad * precio * (1 - descuento / 100);
                        
                        // Agregar a la tabla de detalles
                        modeloDetalles.addRow(new Object[]{
                            idProducto,
                            nombreProducto,
                            cantidad,
                            precio,
                            descuento,
                            subtotal
                        });
                        
                        // Actualizar total
                        totalVenta += subtotal;
                        lblTotal.setText(String.format("Total: $%,.2f", totalVenta));
                        
                        dialogoProducto.dispose();
                    }
                } catch (NumberFormatException ex) {
                    JOptionPane.showMessageDialog(dialogoProducto, "Cantidad y descuento deben ser números válidos",
                            "Error", JOptionPane.ERROR_MESSAGE);
                } catch (SQLException ex) {
                    JOptionPane.showMessageDialog(dialogoProducto, "Error al obtener producto: " + ex.getMessage(),
                            "Error", JOptionPane.ERROR_MESSAGE);
                }
            });
            
            btnCancelar.addActionListener(e -> dialogoProducto.dispose());
            
            dialogoProducto.pack();
            dialogoProducto.setLocationRelativeTo(this);
            dialogoProducto.setVisible(true);
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al cargar productos: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void finalizarVenta() {
        if (modeloDetalles.getRowCount() == 0) {
            JOptionPane.showMessageDialog(this, "Debe agregar al menos un producto a la venta",
                    "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }
        
        int confirm = JOptionPane.showConfirmDialog(this, 
                "¿Confirmar finalización de la venta por $" + totalVenta + "?",
                "Confirmar Venta", JOptionPane.YES_NO_OPTION);
        
        if (confirm == JOptionPane.YES_OPTION) {
            try {
                // Obtener cliente y empleado seleccionados
                int idCliente = Integer.parseInt(((String) cbClientes.getSelectedItem()).split(" - ")[0]);
                int idEmpleado = Integer.parseInt(((String) cbEmpleados.getSelectedItem()).split(" - ")[0]);
                
                // Registrar la venta
                CallableStatement csVenta = connection.prepareCall(
                        "{call sp_RegistrarVenta(?, ?, ?, ?)}");
                csVenta.setInt(1, idVenta);
                csVenta.setInt(2, idCliente);
                csVenta.setInt(3, idEmpleado);
                csVenta.setDate(4, new java.sql.Date(System.currentTimeMillis()));
                csVenta.execute();
                
                // Registrar los detalles de venta
                for (int i = 0; i < modeloDetalles.getRowCount(); i++) {
                    CallableStatement csDetalle = connection.prepareCall(
                            "{call sp_AgregarDetalleVenta(?, ?, ?, ?, ?)}");
                    csDetalle.setInt(1, i + 1); // ID detalle secuencial
                    csDetalle.setInt(2, idVenta);
                    csDetalle.setInt(3, (int) modeloDetalles.getValueAt(i, 0)); // ID Producto
                    csDetalle.setInt(4, (int) modeloDetalles.getValueAt(i, 2)); // Cantidad
                    csDetalle.setDouble(5, (double) modeloDetalles.getValueAt(i, 4)); // Descuento
                    csDetalle.execute();
                    
                    // Actualizar stock
                    CallableStatement csStock = connection.prepareCall(
                            "{call sp_ActualizarStock(?, ?)}");
                    csStock.setInt(1, (int) modeloDetalles.getValueAt(i, 0)); // ID Producto
                    csStock.setInt(2, (int) modeloDetalles.getValueAt(i, 2) * -1); // Cantidad restando
                    csStock.execute();
                }
                
                // Calcular total final
                CallableStatement csTotal = connection.prepareCall(
                        "{call sp_CalcularTotalVenta(?, ?)}");
                csTotal.setInt(1, idVenta);
                csTotal.registerOutParameter(2, Types.DOUBLE);
                csTotal.execute();
                
                ventaRealizada = true;
                dispose();
                
                JOptionPane.showMessageDialog(this, 
                        "Venta registrada exitosamente\nNúmero de venta: " + idVenta,
                        "Venta Exitosa", JOptionPane.INFORMATION_MESSAGE);
                
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(this, "Error al registrar venta: " + ex.getMessage(),
                        "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }
    
    public boolean isVentaRealizada() {
        return ventaRealizada;
    }
}
