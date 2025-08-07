--este paquete esta encargado de gestionar la logica que tienen los procedimientos almacenados con los clientes


CREATE OR REPLACE PACKAGE pkg_clientes AS
  
    PROCEDURE InsertarCliente(
        p_Nombre        IN VARCHAR2,
        p_Apellido      IN VARCHAR2,
        p_Residencia    IN VARCHAR2,
        p_Email         IN VARCHAR2,
        p_EstadoID      IN NUMBER
    );
    
    PROCEDURE ActualizarCliente(
        p_ClienteID     IN NUMBER,
        p_Nombre        IN VARCHAR2,
        p_Apellido      IN VARCHAR2,
        p_Residencia    IN VARCHAR2,
        p_Email         IN VARCHAR2
    );
    
    PROCEDURE EliminarCliente(
        p_ClienteID     IN NUMBER
    );
    
    PROCEDURE BuscarClientePorCorreo(
        p_Email         IN VARCHAR2
    );
    
    PROCEDURE ActualizarEstadoCliente(
        p_ClienteID     IN NUMBER,
        p_EstadoID      IN NUMBER
    );

END pkg_clientes;

CREATE OR REPLACE PACKAGE BODY pkg_clientes AS

    PROCEDURE InsertarCliente(
        p_Nombre        IN VARCHAR2,
        p_Apellido      IN VARCHAR2,
        p_Residencia    IN VARCHAR2,
        p_Email         IN VARCHAR2,
        p_EstadoID      IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Clientes (
            Nombre_Cliente, Apellido_Cliente, Residencia_Cliente, Email_Cliente, Estado_ID
        ) VALUES (
            p_Nombre, p_Apellido, p_Residencia, p_Email, p_EstadoID
        );
        COMMIT;
    END InsertarCliente;

    --------------------------------------------------------

    PROCEDURE ActualizarCliente(
        p_ClienteID     IN NUMBER,
        p_Nombre        IN VARCHAR2,
        p_Apellido      IN VARCHAR2,
        p_Residencia    IN VARCHAR2,
        p_Email         IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Clientes
        SET
            Nombre_Cliente    = p_Nombre,
            Apellido_Cliente  = p_Apellido,
            Residencia_Cliente= p_Residencia,
            Email_Cliente     = p_Email
        WHERE Cliente_ID = p_ClienteID;
        COMMIT;
    END ActualizarCliente;

    --------------------------------------------------------

    PROCEDURE EliminarCliente(
        p_ClienteID     IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Clientes
        WHERE Cliente_ID = p_ClienteID;
        COMMIT;
    END EliminarCliente;

    --------------------------------------------------------

    PROCEDURE BuscarClientePorCorreo(
        p_Email         IN VARCHAR2
    ) IS
        CURSOR c_cliente IS
            SELECT Cliente_ID, Nombre_Cliente, Apellido_Cliente, Residencia_Cliente, Estado_ID
            FROM Clientes
            WHERE Email_Cliente = p_Email;
        
        v_cliente c_cliente%ROWTYPE;
    BEGIN
        OPEN c_cliente;
        FETCH c_cliente INTO v_cliente;
        IF c_cliente%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_cliente.Cliente_ID);
            DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_cliente.Nombre_Cliente);
            DBMS_OUTPUT.PUT_LINE('Apellido: ' || v_cliente.Apellido_Cliente);
            DBMS_OUTPUT.PUT_LINE('Residencia: ' || v_cliente.Residencia_Cliente);
            DBMS_OUTPUT.PUT_LINE('Estado_ID: ' || v_cliente.Estado_ID);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Cliente no encontrado.');
        END IF;
        CLOSE c_cliente;
    END BuscarClientePorCorreo;

    --------------------------------------------------------

    PROCEDURE ActualizarEstadoCliente(
        p_ClienteID     IN NUMBER,
        p_EstadoID      IN NUMBER
    ) IS
    BEGIN
        UPDATE Clientes
        SET Estado_ID = p_EstadoID
        WHERE Cliente_ID = p_ClienteID;
        COMMIT;
    END ActualizarEstadoCliente;

END pkg_clientes;

/*Este es un ejemplo de como se usa

BEGIN
  pkg_clientes.ActualizarEstadoCliente(
    p_cliente_id => 1,
    p_estado_id  => 2
  );
END;



BEGIN
  pkg_clientes.BuscarClientePorCorreo(
    p_Email => 'carlos.ramirez@email.com'
  );
END;


BEGIN
  pkg_clientes.EliminarCliente(
    p_ClienteID => 40
  );
END;

BEGIN
  pkg_clientes.ActualizarCliente(
    p_ClienteID  => 1,
    p_Nombre     => 'Carlos Alberto',
    p_Apellido   => 'Ramírez Gómez',
    p_Residencia => 'Heredia Centro',
    p_Email      => 'carlos.a.ramirez@email.com'
  );
END;

EL DE AGREGAR CLIENTE ESTA FALLANDO, INVESTIGARÉ MAS TARDE 
BEGIN
  pkg_clientes.InsertarCliente(
    p_Nombre     => 'Carlos',
    p_Apellido   => 'Ramírez',
    p_Residencia => 'Heredia',
    p_Email      => 'carlos.ramirez@email.com',
    p_EstadoID   => 40
  );
END;


*/
CREATE OR REPLACE PACKAGE pkg_empleados AS
    
    PROCEDURE InsertarEmpleado(
        p_Nombre     IN VARCHAR2,
        p_Apellido   IN VARCHAR2,
        p_Email      IN VARCHAR2,
        p_Puesto     IN VARCHAR2,
        p_Salario    IN NUMBER,
        p_EstadoID   IN NUMBER
    );
    
    PROCEDURE ActualizarSalarioEmpleado(
        p_EmpleadoID IN NUMBER,
        p_Salario    IN NUMBER
    );
    
    PROCEDURE ActualizarEmailEmpleado(
        p_EmpleadoID IN NUMBER,
        p_Email      IN VARCHAR2
    );

END pkg_empleados;


CREATE OR REPLACE PACKAGE BODY pkg_empleados AS

    -- Insertar un nuevo empleado
    PROCEDURE InsertarEmpleado(
        p_Nombre     IN VARCHAR2,
        p_Apellido   IN VARCHAR2,
        p_Email      IN VARCHAR2,
        p_Puesto     IN VARCHAR2,
        p_Salario    IN NUMBER,
        p_EstadoID   IN NUMBER
    ) IS
        v_estado_count NUMBER;
        v_email_count NUMBER;
        v_duplicado_count NUMBER;
    BEGIN
        -- Validar salario mínimo
        IF p_Salario < 300000 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El salario debe ser mayor o igual a 300000.');
        END IF;
        
        -- Validar que el Estado exista
        SELECT COUNT(*) INTO v_estado_count
        FROM Estado
        WHERE Estado_ID = p_EstadoID;
        
        IF v_estado_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El Estado_ID no existe.');
        END IF;
        
        -- Validar email único
        SELECT COUNT(*) INTO v_email_count
        FROM Empleados
        WHERE LOWER(Email_Empleado) = LOWER(p_Email);
        
        IF v_email_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El email ya está registrado.');
        END IF;
        
        -- Validar que no exista empleado con mismo nombre y apellido
        SELECT COUNT(*) INTO v_duplicado_count
        FROM Empleados
        WHERE LOWER(Nombre_Empleado) = LOWER(p_Nombre)
        AND LOWER(Apellido_Empleado) = LOWER(p_Apellido);
        
        IF v_duplicado_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El empleado ya existe.');
        END IF;
        
        -- Insertar registro
        INSERT INTO Empleados (
            Empleado_ID, Estado_ID, Nombre_Empleado, Apellido_Empleado, Email_Empleado, Puesto, Salario
        ) VALUES (
            Empleados_SEQ.NEXTVAL, p_EstadoID, p_Nombre, p_Apellido, p_Email, p_Puesto, p_Salario
        );
        COMMIT;
    END InsertarEmpleado;

    --------------------------------------------------------

    -- Actualizar salario de un empleado
    PROCEDURE ActualizarSalarioEmpleado(
        p_EmpleadoID IN NUMBER,
        p_Salario    IN NUMBER
    ) IS
    BEGIN
        IF p_Salario < 300000 THEN
            RAISE_APPLICATION_ERROR(-20005, 'El salario debe ser mayor o igual a 300000.');
        END IF;
        
        UPDATE Empleados
        SET Salario = p_Salario
        WHERE Empleado_ID = p_EmpleadoID;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Empleado no encontrado.');
        END IF;
        
        COMMIT;
    END ActualizarSalarioEmpleado;

    --------------------------------------------------------

    -- Actualizar email de un empleado
    PROCEDURE ActualizarEmailEmpleado(
        p_EmpleadoID IN NUMBER,
        p_Email      IN VARCHAR2
    ) IS
        v_email_count NUMBER;
    BEGIN
        -- Validar email único
        SELECT COUNT(*) INTO v_email_count
        FROM Empleados
        WHERE LOWER(Email_Empleado) = LOWER(p_Email)
        AND Empleado_ID <> p_EmpleadoID;
        
        IF v_email_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20007, 'El email ya está registrado por otro empleado.');
        END IF;
        
        UPDATE Empleados
        SET Email_Empleado = p_Email
        WHERE Empleado_ID = p_EmpleadoID;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20008, 'Empleado no encontrado.');
        END IF;
        
        COMMIT;
    END ActualizarEmailEmpleado;

END pkg_empleados;


/*BEGIN

ESTE METODO VUELVE A FALLAR
    pkg_empleados.InsertarEmpleado(
        p_Nombre   => 'Carlos',
        p_Apellido => 'Ramírez',
        p_Email    => 'carlos.ramirez@email.com',
        p_Puesto   => 'Técnico',
        p_Salario  => 350000,
        p_EstadoID => 101
    );
END;
/

BEGIN
    pkg_empleados.ActualizarSalarioEmpleado(
        p_EmpleadoID => 1,
        p_Salario    => 400000
    );
END;
/

BEGIN
    pkg_empleados.ActualizarEmailEmpleado(
        p_EmpleadoID => 1,
        p_Email      => 'nuevo.email@email.com'
    );
END;
/
*/


