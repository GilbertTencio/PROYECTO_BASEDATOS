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
