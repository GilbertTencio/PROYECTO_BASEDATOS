
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
 * FORMULARIO PROVEEDOR
 * --------------------------------------------------------------- */
class FormularioProveedor extends JDialog {
    private Connection connection;
    private boolean guardado = false;
    private Integer idProveedor;
    
    // Componentes del formulario
    private JTextField txtId, txtNombre, txtContacto, txtTelefono, txtDireccion, txtEmail;
    
    public FormularioProveedor(Connection connection, Integer idProveedor) {
        this.connection = connection;
        this.idProveedor = idProveedor;
        
        setTitle(idProveedor == null ? "Nuevo Proveedor" : "Editar Proveedor");
        setSize(400, 350);
        setModal(true);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(0, 2, 10, 10));
        
        initComponents();
        if (idProveedor != null) {
            cargarDatosProveedor();
        }
    }
    
    private void initComponents() {
        txtId = new JTextField();
        txtNombre = new JTextField();
        txtContacto = new JTextField();
        txtTelefono = new JTextField();
        txtDireccion = new JTextField();
        txtEmail = new JTextField();
        
        // Configurar campos
        if (idProveedor == null) {
            txtId.setEditable(true);
        } else {
            txtId.setEditable(false);
            txtId.setText(idProveedor.toString());
        }
        
        // Botones
        JButton btnGuardar = new JButton("Guardar");
        JButton btnCancelar = new JButton("Cancelar");
        
        // Agregar componentes
        add(new JLabel("ID Proveedor:"));
        add(txtId);
        add(new JLabel("Nombre:"));
        add(txtNombre);
        add(new JLabel("Contacto:"));
        add(txtContacto);
        add(new JLabel("Teléfono:"));
        add(txtTelefono);
        add(new JLabel("Dirección:"));
        add(txtDireccion);
        add(new JLabel("Email:"));
        add(txtEmail);
        add(btnGuardar);
        add(btnCancelar);
        
        // Listeners
        btnGuardar.addActionListener(e -> guardarProveedor());
        btnCancelar.addActionListener(e -> dispose());
    }
    
    private void cargarDatosProveedor() {
        try {
            String sql = "SELECT Nombre, Contacto, Telefono, Direccion, Email " +
                         "FROM Proveedores WHERE ID_Proveedor = ?";
            
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, idProveedor);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                txtNombre.setText(rs.getString("Nombre"));
                txtContacto.setText(rs.getString("Contacto"));
                txtTelefono.setText(rs.getString("Telefono"));
                txtDireccion.setText(rs.getString("Direccion"));
                txtEmail.setText(rs.getString("Email"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al cargar datos del proveedor: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void guardarProveedor() {
        try {
            // Validaciones
            if (txtNombre.getText().trim().isEmpty()) {
                JOptionPane.showMessageDialog(this, "El nombre es obligatorio", 
                        "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
            if (!txtEmail.getText().contains("@") || !txtEmail.getText().contains(".")) {
                JOptionPane.showMessageDialog(this, "Ingrese un email válido", 
                        "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
            
            if (idProveedor == null) {
                // Insertar nuevo proveedor
                int id;
                try {
                    id = Integer.parseInt(txtId.getText());
                } catch (NumberFormatException e) {
                    JOptionPane.showMessageDialog(this, "El ID debe ser un número entero", 
                            "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                
                CallableStatement cs = connection.prepareCall(
                        "{call pkg_proveedores.Registrar_Proveedor(?, ?, ?, ?, ?, ?)}");
                cs.setInt(1, id);
                cs.setString(2, txtNombre.getText());
                cs.setString(3, txtContacto.getText());
                cs.setString(4, txtTelefono.getText());
                cs.setString(5, txtDireccion.getText());
                cs.setString(6, txtEmail.getText());
                cs.execute();
            } else {
                // Actualizar proveedor existente
                CallableStatement cs = connection.prepareCall(
                        "{call pkg_proveedores.Actualizar_Proveedor(?, ?, ?, ?, ?, ?)}");
                cs.setInt(1, idProveedor);
                cs.setString(2, txtNombre.getText());
                cs.setString(3, txtContacto.getText());
                cs.setString(4, txtTelefono.getText());
                cs.setString(5, txtDireccion.getText());
                cs.setString(6, txtEmail.getText());
                cs.execute();
            }
            
            guardado = true;
            dispose();
            
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error al guardar proveedor: " + ex.getMessage(),
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public boolean isGuardado() {
        return guardado;
    }
}
