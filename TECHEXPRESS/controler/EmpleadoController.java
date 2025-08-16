package TECHEXPRESS.controler;

import TECHEXPRESS.Modelo.Empleado;
import TECHEXPRESS.dao.EmpleadoDAO;

import java.util.List;

public class EmpleadoController {

    EmpleadoDAO dao = new EmpleadoDAO();

    public void agregarEmpleado(int estadoID, String nombre, String apellido, String email, String puesto, String salario) {
        Empleado e = new Empleado(0, estadoID, nombre, apellido, email, puesto, salario);
        dao.insertarEmpleado(e);
    }

    public void cambiarEmail(int empleadoID, String nuevoEmail) {
        dao.actualizarEmail(empleadoID, nuevoEmail);
    }

    public void cambiarSalario(int empleadoID, String nuevoSalario) {
        dao.actualizarSalario(empleadoID, nuevoSalario);
    }

    public void borrarEmpleado(int empleadoID) {
        dao.eliminarEmpleado(empleadoID);
    }

    public List<Empleado> listarTodo() {
        return dao.listarEmpleados();
    }
}
