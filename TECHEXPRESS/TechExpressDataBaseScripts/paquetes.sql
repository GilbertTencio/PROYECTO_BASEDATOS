--por el momento todos los procedimientos de incertar datos a las tablas estan fallando, cuando se hace un insert a mano funciona, haciendo pruebas a los procedimientos de insertar a las tablas se ve que ninguno funciona 

--este paquete esta encargado de gestionar la logica que tienen los procedimientos almacenados con los clientes

--pkg_Clientes
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
----------------------------------------------------------------------------------------------------------------------------------------

*/
--pkg_Empleados
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--pkg_Inventario
CREATE OR REPLACE PACKAGE pkg_inventario AS

  -- Inserta un nuevo item en Inventario (genera Item_ID automáticamente)
  PROCEDURE InsertarInventario(
    p_EstadoID       IN NUMBER,
    p_NombreItem     IN VARCHAR2,
    p_Descripcion    IN VARCHAR2,
    p_PrecioUnitario IN NUMBER,
    p_Cantidad       IN NUMBER
  );

  -- Actualiza la cantidad de un item (no puede quedar negativa).
  PROCEDURE ActualizarCantidadInventario(
    p_ItemID        IN NUMBER,
    p_NuevaCantidad IN NUMBER
  );

  -- Actualiza la descripción de un item
  PROCEDURE ActualizarDescripcionInventario(
    p_ItemID          IN NUMBER,
    p_NuevaDescripcion IN VARCHAR2
  );

END pkg_inventario;
/

CREATE OR REPLACE PACKAGE BODY pkg_inventario AS

  PROCEDURE InsertarInventario(
    p_EstadoID       IN NUMBER,
    p_NombreItem     IN VARCHAR2,
    p_Descripcion    IN VARCHAR2,
    p_PrecioUnitario IN NUMBER,
    p_Cantidad       IN NUMBER
  ) IS
    v_new_id NUMBER;
  BEGIN
    -- Validaciones
    IF p_Cantidad IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'La cantidad es obligatoria.');
    END IF;
    IF p_PrecioUnitario IS NULL THEN
      RAISE_APPLICATION_ERROR(-20002, 'El precio unitario es obligatorio.');
    END IF;
    IF p_Cantidad < 0 THEN
      RAISE_APPLICATION_ERROR(-20003, 'La cantidad no puede ser negativa.');
    END IF;
    IF p_PrecioUnitario < 0 THEN
      RAISE_APPLICATION_ERROR(-20004, 'El precio unitario no puede ser negativo.');
    END IF;

    -- Insert con Item_ID generado por secuencia
    v_new_id := Inventario_SEQ.NEXTVAL;
    INSERT INTO Inventario (
      Item_ID, Estado_ID, Nombre_Item, Descripcion_Item, Precio_Unitario, Cantidad_Item
    ) VALUES (
      v_new_id, p_EstadoID, p_NombreItem, p_Descripcion, p_PrecioUnitario, p_Cantidad
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Item insertado. Item_ID = ' || v_new_id);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END InsertarInventario;


  PROCEDURE ActualizarCantidadInventario(
    p_ItemID        IN NUMBER,
    p_NuevaCantidad IN NUMBER
  ) IS
  BEGIN
    IF p_NuevaCantidad IS NULL THEN
      RAISE_APPLICATION_ERROR(-20005, 'La nueva cantidad es obligatoria.');
    END IF;
    IF p_NuevaCantidad < 0 THEN
      RAISE_APPLICATION_ERROR(-20006, 'La cantidad no puede ser negativa.');
    END IF;

    UPDATE Inventario
    SET Cantidad_Item = p_NuevaCantidad
    WHERE Item_ID = p_ItemID;

    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20007, 'Item no encontrado: Item_ID = ' || p_ItemID);
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cantidad actualizada para Item_ID = ' || p_ItemID || '. Nueva cantidad = ' || p_NuevaCantidad);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END ActualizarCantidadInventario;


  PROCEDURE ActualizarDescripcionInventario(
    p_ItemID           IN NUMBER,
    p_NuevaDescripcion IN VARCHAR2
  ) IS
  BEGIN
    UPDATE Inventario
    SET Descripcion_Item = p_NuevaDescripcion
    WHERE Item_ID = p_ItemID;

    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20008, 'Item no encontrado: Item_ID = ' || p_ItemID);
    END IF;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Descripción actualizada para Item_ID = ' || p_ItemID);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END ActualizarDescripcionInventario;

END pkg_inventario;
/



CREATE SEQUENCE CATEGORIA_PRODUCTO_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;


/*
--no funciona
BEGIN
  pkg_inventario.InsertarInventario(
    p_EstadoID       => 102,
    p_NombreItem     => 'Tarjeta RAID PCIe',
    p_Descripcion    => 'Nuevas 4 puertos SATA',
    p_PrecioUnitario => 68000,
    p_Cantidad       => 2
  );
END;
/
-- Revisa inventario y categoría:
SELECT * FROM Inventario WHERE Item_ID > 0 ORDER BY Item_ID DESC FETCH FIRST 5 ROWS ONLY;
SELECT * FROM Categoria_Producto WHERE Item_ID = (SELECT MAX(Item_ID) FROM Inventario);


-- la fincion de rechasar numeros negativos funciona, pero no permite ingresar nada
BEGIN
  pkg_inventario.InsertarInventario(109,'Prueba','Desc',1000,6);
END;
/
-- Espera RAISE_APPLICATION_ERROR con código -20003


BEGIN
  pkg_inventario.ActualizarCantidadInventario(p_ItemID => 3, p_NuevaCantidad => 100);
END;
/

BEGIN
  pkg_inventario.ActualizarCantidadInventario(p_ItemID => 99999, p_NuevaCantidad => 2);
END;
/
-- Espera error -20007: Item no encontrado


BEGIN
  pkg_inventario.ActualizarDescripcionInventario(p_ItemID => 4, p_NuevaDescripcion => 'Placa madre ASUS H110M - revisada');
END;
/
*/
------------------------------------------------------------------------------------------------------------------------------------------------


--pkg_Estado
CREATE OR REPLACE PACKAGE pkg_estado AS
    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE ActualizarEstado(
        pEstado_ID           NUMBER,
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE EliminarEstado(
        pEstado_ID NUMBER
    );
END pkg_estado;


CREATE OR REPLACE PACKAGE BODY pkg_estado AS

    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    ) AS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Estado
        WHERE UPPER(Nombre_Estado) = UPPER(pNombre_Estado);

        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El estado ya existe.');
        END IF;

        INSERT INTO Estado (Estado_ID, Nombre_Estado, Descripcion_Estado)
        VALUES (Estado_SEQ.NEXTVAL, pNombre_Estado, pDescripcion_Estado);

        DBMS_OUTPUT.PUT_LINE('Estado insertado correctamente.');
    END InsertarEstado;

    PROCEDURE ActualizarEstado(
        pEstado_ID           NUMBER,
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    ) AS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Estado
        WHERE Estado_ID = pEstado_ID;

        IF vCount = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El estado no existe.');
        END IF;

        UPDATE Estado
        SET Nombre_Estado = pNombre_Estado,
            Descripcion_Estado = pDescripcion_Estado
        WHERE Estado_ID = pEstado_ID;

        DBMS_OUTPUT.PUT_LINE('Estado actualizado correctamente.');
    END ActualizarEstado;

    PROCEDURE EliminarEstado(
        pEstado_ID NUMBER
    ) AS
    BEGIN
        DELETE FROM Estado
        WHERE Estado_ID = pEstado_ID;

        DBMS_OUTPUT.PUT_LINE('Estado eliminado correctamente.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar: el estado está en uso.');
            ELSE
                RAISE;
            END IF;
    END EliminarEstado;

END pkg_estado;



/*
BEGIN
    pkg_estado.InsertarEstado('Activo00', 'Disponible00');
    pkg_estado.InsertarEstado('Inactivo00', 'No disponible00');
    pkg_estado.ActualizarEstado(1, 'Activo', 'Disponible para operaciones');
    pkg_estado.EliminarEstado(2);
END;
Error report -
ORA-00001: unique constraint (HR.SYS_C007453) violated
ORA-06512: at "HR.PKG_ESTADO", line 17
ORA-06512: at line 2
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
Action:   Either remove the unique restriction or do not insert the key./
*/
--el que no funciona es el de insertar
BEGIN
    pkg_estado.EliminarEstado(20);
END;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


--pkg_cotzaciones
    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE ActualizarEstado(
        pEstado_ID           NUMBER,
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE EliminarEstado(
        pEstado_ID NUMBER
    );
END pkg_estado;


CREATE OR REPLACE PACKAGE BODY pkg_estado AS

    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    ) AS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Estado
        WHERE UPPER(Nombre_Estado) = UPPER(pNombre_Estado);

        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El estado ya existe.');
        END IF;

        INSERT INTO Estado (Estado_ID, Nombre_Estado, Descripcion_Estado)
        VALUES (Estado_SEQ.NEXTVAL, pNombre_Estado, pDescripcion_Estado);

        DBMS_OUTPUT.PUT_LINE('Estado insertado correctamente.');
    END InsertarEstado;

    PROCEDURE ActualizarEstado(
        pEstado_ID           NUMBER,
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    ) AS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Estado
        WHERE Estado_ID = pEstado_ID;

        IF vCount = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El estado no existe.');
        END IF;

        UPDATE Estado
        SET Nombre_Estado = pNombre_Estado,
            Descripcion_Estado = pDescripcion_Estado
        WHERE Estado_ID = pEstado_ID;

        DBMS_OUTPUT.PUT_LINE('Estado actualizado correctamente.');
    END ActualizarEstado;

    PROCEDURE EliminarEstado(
        pEstado_ID NUMBER
    ) AS
    BEGIN
        DELETE FROM Estado
        WHERE Estado_ID = pEstado_ID;

        DBMS_OUTPUT.PUT_LINE('Estado eliminado correctamente.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar: el estado está en uso.');
            ELSE
                RAISE;
            END IF;
    END EliminarEstado;

END pkg_estado;



/*Error starting at line : 602 in command -
BEGIN
    pkg_estado.InsertarEstado('Activo00', 'Disponible00');
    pkg_estado.InsertarEstado('Inactivo00', 'No disponible00');
    pkg_estado.ActualizarEstado(1, 'Activo', 'Disponible para operaciones');
    pkg_estado.EliminarEstado(2);
END;
Error report -
ORA-00001: unique constraint (HR.SYS_C007453) violated
ORA-06512: at "HR.PKG_ESTADO", line 17
ORA-06512: at line 2
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
Action:   Either remove the unique restriction or do not insert the key./

BEGIN
    pkg_estado.EliminarEstado(20);
END;
 CREATE OR REPLACE PACKAGE pkg_cotizaciones AS
    PROCEDURE InsertarCotizacion(
        pEstadoID NUMBER,
        pItemID NUMBER,
        pServicioID NUMBER,
        pEmpleadoID NUMBER,
        pFechaServicio DATE
    );

    PROCEDURE EliminarCotizacion(
        pCotizacionID NUMBER
    );

    PROCEDURE ConsultarCotizacionesPorFecha(
        pFechaInicio DATE,
        pFechaFin DATE
    );
END pkg_cotizaciones;
/
CREATE OR REPLACE PACKAGE BODY pkg_cotizaciones AS

    PROCEDURE InsertarCotizacion(
        pEstadoID NUMBER,
        pItemID NUMBER,
        pServicioID NUMBER,
        pEmpleadoID NUMBER,
        pFechaServicio DATE
    ) AS
        vExisteEmpleado NUMBER;
        vExisteCliente NUMBER;
    BEGIN
        -- Validar si existe el empleado
        SELECT COUNT(*) INTO vExisteEmpleado
        FROM Empleados
        WHERE Empleado_ID = pEmpleadoID;

        IF vExisteEmpleado = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El empleado no existe');
        END IF;

        -- Validar si el servicio tiene cliente asociado
        SELECT COUNT(*) INTO vExisteCliente
        FROM Gestion_Servicios gs
        JOIN Servicio_Cliente sc ON gs.Servicio_ID = sc.Servicio_ID
        JOIN Clientes c ON sc.Cliente_ID = c.Cliente_ID
        WHERE gs.Servicio_ID = pServicioID;

        IF vExisteCliente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No hay cliente asociado al servicio');
        END IF;

        -- Insertar cotización
        INSERT INTO Cotizaciones (
            Cotizacion_ID,
            Estado_ID,
            Item_ID,
            Servicio_ID,
            Empleado_ID,
            Posible_Fecha_Servicio
        ) VALUES (
            Cotizaciones_SEQ.NEXTVAL,
            pEstadoID,
            pItemID,
            pServicioID,
            pEmpleadoID,
            pFechaServicio
        );

        DBMS_OUTPUT.PUT_LINE('Cotización insertada correctamente');
    END InsertarCotizacion;

    PROCEDURE EliminarCotizacion(
        pCotizacionID NUMBER
    ) AS
    BEGIN
        DELETE FROM Cotizaciones
        WHERE Cotizacion_ID = pCotizacionID;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No se encontró la cotización con el ID especificado');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Cotización eliminada correctamente');
        END IF;
    END EliminarCotizacion;

    PROCEDURE ConsultarCotizacionesPorFecha(
        pFechaInicio DATE,
        pFechaFin DATE
    ) AS
    BEGIN
        FOR r IN (
            SELECT *
            FROM Vista_Cotizaciones_Detalle
            WHERE Posible_Fecha_Servicio BETWEEN pFechaInicio AND pFechaFin
            ORDER BY Posible_Fecha_Servicio
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || r.Cotizacion_ID ||
                ' | Servicio: ' || r.Nombre_Servicio ||
                ' | Item: ' || r.Nombre_Item ||
                ' | Técnico: ' || r.Tecnico ||
                ' | Fecha: ' || TO_CHAR(r.Posible_Fecha_Servicio, 'YYYY-MM-DD')
            );
        END LOOP;
    END ConsultarCotizacionesPorFecha;

END pkg_cotizaciones;
/

SET SERVEROUTPUT ON;


Error starting at line : 736 in command -
BEGIN
    pkg_cotizaciones.InsertarCotizacion(
        pEstadoID       => 1,                    -- Estado (ej: Activo)
        pItemID         => 78,                  -- ID de inventario
        pServicioID     => 4,                  -- ID de servicio en Gestion_Servicios
        pEmpleadoID     => 10,                  -- ID del empleado
        pFechaServicio  => TO_DATE('2025-08-15', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('? Cotización insertada correctamente.');
END;
Error report -
ORA-00001: unique constraint (HR.SYS_C007463) violated
ORA-06512: at "HR.PKG_COTIZACIONES", line 34
ORA-06512: at line 2
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
*Action:   Either remove the unique restriction or do not insert the key.

SET SERVEROUTPUT ON;

BEGIN
    pkg_cotizaciones.ConsultarCotizacionesPorFecha(
        pFechaInicio => TO_DATE('2025-08-01', 'YYYY-MM-DD'),
        pFechaFin    => TO_DATE('2025-08-31', 'YYYY-MM-DD')
    );
END;
/

BEGIN
    pkg_cotizaciones.EliminarCotizacion(
        pCotizacionID => 10  
    );
    DBMS_OUTPUT.PUT_LINE('� Cotización eliminada.');
END;
------------------------------------------------------------------------------------------------------------------------------------------------

--pgk_Servicios

CREATE OR REPLACE PACKAGE pkg_estado AS
    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE ActualizarEstado(
        pEstado_ID           NUMBER,
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    );

    PROCEDURE EliminarEstado(
        pEstado_ID NUMBER
    );
END pkg_estado;


CREATE OR REPLACE PACKAGE BODY pkg_estado AS

    PROCEDURE InsertarEstado(
        pNombre_Estado       VARCHAR2,
        pDescripcion_Estado  VARCHAR2
    ) AS
        vCount NUMBER;
    BEGIN
        SELECT COUNT(*) INTO vCount
        FROM Estado
        WHERE UPPER(Nombre_Estado) = UPPER(pNombre_Estado);

        IF vCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20…
[7:57 p. m., 9/8/2025] Santi🤼🥋: CREATE OR REPLACE PACKAGE pkg_cotizaciones AS
    PROCEDURE InsertarCotizacion(
        pEstadoID NUMBER,
        pItemID NUMBER,
        pServicioID NUMBER,
        pEmpleadoID NUMBER,
        pFechaServicio DATE
    );

    PROCEDURE EliminarCotizacion(
        pCotizacionID NUMBER
    );

    PROCEDURE ConsultarCotizacionesPorFecha(
        pFechaInicio DATE,
        pFechaFin DATE
    );
END pkg_cotizaciones;
/
CREATE OR REPLACE PACKAGE BODY pkg_cotizaciones AS

    PROCEDURE InsertarCotizacion(
        pEstadoID NUMBER,
        pItemID NUMBER,
        pServicioID NUMBER,
        pEmpleadoID NUMBER,
        pFechaServicio DATE
    ) AS
        vExisteEmpleado NUMBER;
        vExisteCliente NUMBER;
    BEGIN
        -- Validar si existe el empleado
      …
[8:19 p. m., 9/8/2025] Santi🤼🥋: CREATE OR REPLACE PACKAGE pkg_servicios AS
    -- Insertar un nuevo servicio para un cliente
    PROCEDURE InsertarServicioCliente(
        pEmpleadoID      NUMBER,
        pServicioID      NUMBER,
        pClienteID       NUMBER,
        pEstadoID        NUMBER,
        pFecha           DATE,
        pCantidad        NUMBER,
        pPrecioTotal     NUMBER
    );

    -- Actualizar estado de un servicio realizado
    PROCEDURE ActualizarEstadoServicioRealizado(
        pServicioRealizado NUMBER,
        pEstadoID          NUMBER
    );

    -- Consultar servicios realizados por fecha
    PROCEDURE ConsultarServiciosRealizadosPorFecha(
        pFechaInicio DATE,
        pFechaFin    DATE
    );
END pkg_servicios;


CREATE OR REPLACE PACKAGE BODY pkg_servicios AS

    PROCEDURE InsertarServicioCliente(
        pEmpleadoID      NUMBER,
        pServicioID      NUMBER,
        pClienteID       NUMBER,
        pEstadoID        NUMBER,
        pFecha           DATE,
        pCantidad        NUMBER,
        pPrecioTotal     NUMBER
    ) AS
        vEmpleadoExiste  NUMBER;
        vServicioExiste  NUMBER;
        vClienteExiste   NUMBER;
    BEGIN
        -- Validar que el empleado existe
        SELECT COUNT(*) INTO vEmpleadoExiste
        FROM Empleados
        WHERE Empleado_ID = pEmpleadoID;

        IF vEmpleadoExiste = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El empleado no existe.');
        END IF;

        -- Validar que el servicio existe
        SELECT COUNT(*) INTO vServicioExiste
        FROM Gestion_Servicios
        WHERE Servicio_ID = pServicioID;

        IF vServicioExiste = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El servicio no existe.');
        END IF;

        -- Validar que el cliente existe
        SELECT COUNT(*) INTO vClienteExiste
        FROM Clientes
        WHERE Cliente_ID = pClienteID;

        IF vClienteExiste = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El cliente no existe.');
        END IF;

        -- Insertar el servicio realizado
        INSERT INTO Servicio_Cliente (
            Servicio_Realizado,
            Empleado_ID,
            Servicio_ID,
            Cliente_ID,
            Estado_ID,
            Fecha_ID,
            Cantidad_Servicios,
            Precio_Total
        ) VALUES (
            ServicioCliente_SEQ.NEXTVAL,
            pEmpleadoID,
            pServicioID,
            pClienteID,
            pEstadoID,
            pFecha,
            pCantidad,
            pPrecioTotal
        );

        DBMS_OUTPUT.PUT_LINE('Servicio insertado correctamente.');
    END InsertarServicioCliente;


    PROCEDURE ActualizarEstadoServicioRealizado(
        pServicioRealizado NUMBER,
        pEstadoID          NUMBER
    ) AS
        vExisteServicio NUMBER;
    BEGIN
        -- Verificar que el servicio realizado existe
        SELECT COUNT(*) INTO vExisteServicio
        FROM Servicio_Cliente
        WHERE Servicio_Realizado = pServicioRealizado;

        IF vExisteServicio = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El servicio realizado no existe.');
        END IF;

        UPDATE Servicio_Cliente
        SET Estado_ID = pEstadoID
        WHERE Servicio_Realizado = pServicioRealizado;

        DBMS_OUTPUT.PUT_LINE('Estado del servicio actualizado.');
    END ActualizarEstadoServicioRealizado;


    PROCEDURE ConsultarServiciosRealizadosPorFecha(
        pFechaInicio DATE,
        pFechaFin    DATE
    ) AS
    BEGIN
        FOR r IN (
            SELECT sc.Servicio_Realizado,
                   gs.Nombre_Servicio,
                   sc.Fecha_ID,
                   sc.Precio_Total
            FROM Servicio_Cliente sc
            JOIN Gestion_Servicios gs
              ON sc.Servicio_ID = gs.Servicio_ID
            WHERE sc.Fecha_ID BETWEEN pFechaInicio AND pFechaFin
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Servicio ID: ' || r.Servicio_Realizado ||
                ' | Nombre: ' || r.Nombre_Servicio ||
                ' | Fecha: ' || TO_CHAR(r.Fecha_ID, 'YYYY-MM-DD') ||
                ' | Precio: ' || r.Precio_Total
            );
        END LOOP;
    END ConsultarServiciosRealizadosPorFecha;

END pkg_servicios;
/




Error starting at line : 146 in command -
BEGIN
    pkg_servicios.InsertarServicioCliente(
        pEmpleadoID   => 1,  -- Debe existir en EMPLEADOS
        pServicioID   => 10, -- Debe existir en GESTION_SERVICIOS
        pClienteID    => 5,  -- Debe existir en CLIENTES
        pEstadoID     => 1,  -- Debe existir en ESTADO
        pFecha        => SYSDATE,
        pCantidad     => 2,
        pPrecioTotal  => 500000
    );
END;
Error report -
ORA-00001: unique constraint (HR.SYS_C007471) violated
ORA-06512: at "HR.PKG_SERVICIOS", line 44
ORA-06512: at line 2
00001. 00000 -  "unique constraint (%s.%s) violated"
*Cause:    An UPDATE or INSERT statement attempted to insert a duplicate key.
           For Trusted Oracle configured in DBMS MAC mode, you may see
           this message if a duplicate entry exists at a different level.
*Action:   Either remove the unique restriction or do not insert the key.



BEGIN
    pkg_servicios.ActualizarEstadoServicioRealizado(
        pServicioRealizado => 10,  -- Debe existir en SERVICIO_CLIENTE
        pEstadoID          => 2      -- Nuevo estado válido en ESTADO
    );
END;
/



BEGIN
    pkg_servicios.ConsultarServiciosRealizadosPorFecha(
        pFechaInicio => DATE '2025-08-01',
        pFechaFin    => DATE '2025-08-09'
    );
END;
/



CREATE OR REPLACE PACKAGE pkg_seguimiento AS
    -- Insertar un seguimiento para un servicio realizado
    PROCEDURE InsertarSeguimiento(
        pServicioRealizadoID NUMBER,
        pDescripcion         VARCHAR2,
        pFechaSeguimiento    DATE
    );

    -- Obtener seguimientos por servicio realizado
    PROCEDURE ObtenerSeguimientoPorServicio(
        pServicioRealizadoID NUMBER
    );
END pkg_seguimiento;


CREATE OR REPLACE PACKAGE BODY pkg_seguimiento AS

    PROCEDURE InsertarSeguimiento(
        pServicioRealizadoID NUMBER,
        pDescripcion         VARCHAR2,
        pFechaSeguimiento    DATE
    ) AS
        vExisteServicio NUMBER;
    BEGIN
        -- Validar que el servicio realizado existe
        SELECT COUNT(*) INTO vExisteServicio
        FROM Servicio_Cliente
        WHERE Servicio_Realizado = pServicioRealizadoID;

        IF vExisteServicio = 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'El servicio realizado no existe.');
        END IF;

        -- Insertar seguimiento
        INSERT INTO Seguimiento (
            Seguimiento_ID,
            Servicio_Realizado,
            Descripcion_Seguimiento,
            Fecha_Seguimiento
        ) VALUES (
            Seguimiento_SEQ.NEXTVAL,
            pServicioRealizadoID,
            pDescripcion,
            pFechaSeguimiento
        );

        DBMS_OUTPUT.PUT_LINE('Seguimiento insertado correctamente.');
    END InsertarSeguimiento;


    PROCEDURE ObtenerSeguimientoPorServicio(
        pServicioRealizadoID NUMBER
    ) AS
        vExisteServicio NUMBER;
    BEGIN
        -- Validar que el servicio realizado existe
        SELECT COUNT(*) INTO vExisteServicio
        FROM Servicio_Cliente
        WHERE Servicio_Realizado = pServicioRealizadoID;

        IF vExisteServicio = 0 THEN
            RAISE_APPLICATION_ERROR(-20011, 'No se encontró el servicio realizado.');
        END IF;

        -- Mostrar seguimientos asociados
        FOR r IN (
            SELECT Seguimiento_ID,
                   Descripcion_Seguimiento,
                   Fecha_Seguimiento
            FROM Seguimiento
            WHERE Servicio_Realizado = pServicioRealizadoID
            ORDER BY Fecha_Seguimiento
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || r.Seguimiento_ID ||
                ' | Fecha: ' || TO_CHAR(r.Fecha_Seguimiento, 'YYYY-MM-DD') ||
                ' | Descripción: ' || r.Descripcion_Seguimiento
            );
        END LOOP;
    END ObtenerSeguimientoPorServicio;

END pkg_seguimiento;



BEGIN
    pkg_seguimiento.InsertarSeguimiento(
        pServicioRealizadoID => 101,  -- ID de un servicio que ya exista
        pDescripcion         => 'Revisión final del equipo y entrega al cliente.',
        pFechaSeguimiento    => SYSDATE
    );
END;
/


BEGIN
    pkg_seguimiento.ObtenerSeguimientoPorServicio(
        pServicioRealizadoID => 10
    );
END;

