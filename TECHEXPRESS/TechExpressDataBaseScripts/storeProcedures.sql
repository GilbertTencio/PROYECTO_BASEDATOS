--Ejecutar los scipts en el orden que están

--Secuencias necesarias dentro de las tablas para los SP
CREATE SEQUENCE Estado_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Estado_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Clientes_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Inventario_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE GestionServicios_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Empleados_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Cotizaciones_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE CategoriaProducto_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE ServicioCliente_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Seguimiento_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE Pagos_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
¨
--Lista de SP

--ActualizarEstado
CREATE OR REPLACE PROCEDURE ActualizarEstado(pEstadoID NUMBER, pNombre VARCHAR, pDescripcion VARCHAR) AS
BEGIN
    UPDATE Estado
    SET Nombre_Estado = pNombre,
        Descripcion_Estado = pDescripcion
    WHERE Estado_ID = pEstadoID;
END;

--EliminarEstado.
CREATE OR REPLACE PROCEDURE EliminarEstado(pEstadoID NUMBER) AS
BEGIN
    DELETE FROM Estado WHERE Estado_ID = pEstadoID;
END;

--InsertarCliente
CREATE OR REPLACE PROCEDURE InsertarCliente(pEstadoID NUMBER, pNombre VARCHAR, pApellido VARCHAR, pResidencia VARCHAR, pEmail VARCHAR) AS
BEGIN
    INSERT INTO Clientes (Cliente_ID, Estado_ID, Nombre_Cliente, Apellido_Cliente, Residencia_Cliente, Email_Cliente)
    VALUES (Clientes_SEQ.NEXTVAL, pEstadoID, pNombre, pApellido, pResidencia, pEmail);
END;

--ActualizarCliente
CREATE OR REPLACE PROCEDURE ActualizarCliente(pClienteID NUMBER, pNombre VARCHAR, pApellido VARCHAR, pResidencia VARCHAR, pEmail VARCHAR) AS
BEGIN
    UPDATE Clientes
    SET Nombre_Cliente = pNombre,
        Apellido_Cliente = pApellido,
        Residencia_Cliente = pResidencia,
        Email_Cliente = pEmail
    WHERE Cliente_ID = pClienteID;
END;

--EliminarCliente
CREATE OR REPLACE PROCEDURE EliminarCliente(pClienteID NUMBER) AS
BEGIN
    DELETE FROM Clientes WHERE Cliente_ID = pClienteID;
END;

--InsertarInventario
CREATE OR REPLACE PROCEDURE InsertarInventario(pEstadoID NUMBER, pNombre VARCHAR, pDescripcion VARCHAR, pPrecio NUMBER, pCantidad NUMBER) AS
BEGIN
    INSERT INTO Inventario (Item_ID, Estado_ID, Nombre_Item, Descripcion_Item, Precio_Unitario, Cantidad_Item)
    VALUES (Inventario_SEQ.NEXTVAL, pEstadoID, pNombre, pDescripcion, pPrecio, pCantidad);
END;

--InsertarEmpleado
CREATE OR REPLACE PROCEDURE InsertarEmpleado(pEstadoID NUMBER, pNombre VARCHAR, pApellido VARCHAR, pEmail VARCHAR, pPuesto VARCHAR, pSalario VARCHAR) AS
BEGIN
    INSERT INTO Empleados (Empleado_ID, Estado_ID, Nombre_Empleado, Apellido_Empleado, Email_Empleado, Puesto, Salario)
    VALUES (Empleados_SEQ.NEXTVAL, pEstadoID, pNombre, pApellido, pEmail, pPuesto, pSalario);
END;

--InsertarCotizacion
CREATE OR REPLACE PROCEDURE InsertarCotizacion(pEstadoID NUMBER, pItemID NUMBER, pServicioID NUMBER, pEmpleadoID NUMBER, pFechaServicio DATE) AS
BEGIN
    INSERT INTO Cotizaciones (Cotizacion_ID, Estado_ID, Item_ID, Servicio_ID, Empleado_ID, Posible_Fecha_Servicio)
    VALUES (Cotizaciones_SEQ.NEXTVAL, pEstadoID, pItemID, pServicioID, pEmpleadoID, pFechaServicio);
END;

--ConsultarCotizacionesPorFecha
CREATE OR REPLACE PROCEDURE ConsultarCotizacionesPorFecha(pFechaInicio DATE, pFechaFin DATE) AS
BEGIN
    FOR r IN (SELECT * FROM Cotizaciones WHERE Posible_Fecha_Servicio BETWEEN pFechaInicio AND pFechaFin)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Cotizacion ID: ' || r.Cotizacion_ID);
    END LOOP;
END;

--InsertarServicioCliente
CREATE OR REPLACE PROCEDURE InsertarServicioCliente(pEmpleadoID NUMBER, pServicioID NUMBER, pClienteID NUMBER, pEstadoID NUMBER, pFecha DATE, pCantidad NUMBER, pPrecioTotal NUMBER) AS
BEGIN
    INSERT INTO Servicio_Cliente (Servicio_Realizado, Empleado_ID, Servicio_ID, Cliente_ID, Estado_ID, Fecha_ID, Cantidad_Servicios, Precio_Total)
    VALUES (ServicioCliente_SEQ.NEXTVAL, pEmpleadoID, pServicioID, pClienteID, pEstadoID, pFecha, pCantidad, pPrecioTotal);
END;

--RegistrarPago
CREATE OR REPLACE PROCEDURE RegistrarPago(pServicioRealizado NUMBER, pEstadoID NUMBER, pPrecioTotal NUMBER, pMetodoPago VARCHAR) AS
BEGIN
    INSERT INTO Pagos (Pago_ID, Servicio_Realizado, Estado_ID, Precio_Total, Metodo_Pago)
    VALUES (Pagos_SEQ.NEXTVAL, pServicioRealizado, pEstadoID, pPrecioTotal, pMetodoPago);
END;

--InsertarSeguimiento
CREATE OR REPLACE PROCEDURE InsertarSeguimiento(pEstadoID NUMBER, pServicioRealizado NUMBER, pFechaSeguimiento DATE, pDescripcion VARCHAR, pSiguienteSeguimiento DATE) AS
BEGIN
    INSERT INTO Seguimiento (Seguimiento_ID, Estado_ID, Servicio_Realizado, Fecha_Seguimiento, Descripcion_Seguimiento, Seguimiento_Siguiente)
    VALUES (Seguimiento_SEQ.NEXTVAL, pEstadoID, pServicioRealizado, pFechaSeguimiento, pDescripcion, pSiguienteSeguimiento);
END;

--ActualizarCantidadInventario
CREATE OR REPLACE PROCEDURE ActualizarCantidadInventario(pItemID NUMBER, pNuevaCantidad NUMBER) AS
BEGIN
    UPDATE Inventario
    SET Cantidad_Item = pNuevaCantidad
    WHERE Item_ID = pItemID;
END;

--ActualizarEstadoCliente
CREATE OR REPLACE PROCEDURE ActualizarEstadoCliente(pClienteID NUMBER, pNuevoEstadoID NUMBER) AS
BEGIN
    UPDATE Clientes
    SET Estado_ID = pNuevoEstadoID
    WHERE Cliente_ID = pClienteID;
END;

--EliminarInventario
CREATE OR REPLACE PROCEDURE EliminarInventario(pItemID NUMBER) AS
BEGIN
    DELETE FROM Inventario
    WHERE Item_ID = pItemID;
END;

--EliminarCliente
CREATE OR REPLACE PROCEDURE EliminarCliente(pClienteID NUMBER) AS
BEGIN
    DELETE FROM Clientes
    WHERE Cliente_ID = pClienteID;
END;

----------------------------------------------------------------------------------------------------------------------------

-- Buscar cliente por correo
CREATE OR REPLACE PROCEDURE BuscarClientePorEmail(pEmail VARCHAR) AS
BEGIN
    FOR r IN (SELECT * FROM Clientes WHERE Email_Cliente = pEmail) LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || r.Nombre_Cliente || ' ' || r.Apellido_Cliente);
    END LOOP;
END;

-- Actualizar email de empleado
CREATE OR REPLACE PROCEDURE ActualizarEmailEmpleado(pEmpleadoID NUMBER, pNuevoEmail VARCHAR) AS
BEGIN
    UPDATE Empleados SET Email_Empleado = pNuevoEmail WHERE Empleado_ID = pEmpleadoID;
END;

-- Insertar nuevo estado
CREATE OR REPLACE PROCEDURE InsertarEstado(pNombre VARCHAR, pDescripcion VARCHAR) AS
BEGIN
    INSERT INTO Estado (Estado_ID, Nombre_Estado, Descripcion_Estado)
    VALUES (Estado_SEQ.NEXTVAL, pNombre, pDescripcion);
END;

-- Actualizar estado de un servicio realizado
CREATE OR REPLACE PROCEDURE ActualizarEstadoServicioRealizado(pServicioRealizado NUMBER, pEstadoID NUMBER) AS
BEGIN
    UPDATE Servicio_Cliente SET Estado_ID = pEstadoID WHERE Servicio_Realizado = pServicioRealizado;
END;

-- Insertar nueva categoría de producto
CREATE OR REPLACE PROCEDURE InsertarCategoriaProducto(pItemID NUMBER, pEstadoID NUMBER, pNombreCat VARCHAR, pDescripcionCat VARCHAR) AS
BEGIN
    INSERT INTO Categoria_Producto (Categoria_ID, Item_ID, Estado_ID, Nombre_Categoria, Descripcion_Categoria)
    VALUES (CategoriaProducto_SEQ.NEXTVAL, pItemID, pEstadoID, pNombreCat, pDescripcionCat);
END;

-- Consultar servicios realizados por fecha
CREATE OR REPLACE PROCEDURE ConsultarServiciosPorFecha(pInicio DATE, pFin DATE) AS
BEGIN
    FOR r IN (SELECT * FROM Servicio_Cliente WHERE Fecha_ID BETWEEN pInicio AND pFin) LOOP
        DBMS_OUTPUT.PUT_LINE('Servicio ID: ' || r.Servicio_Realizado);
    END LOOP;
END;

-- Eliminar cotización
CREATE OR REPLACE PROCEDURE EliminarCotizacion(pCotizacionID NUMBER) AS
BEGIN
    DELETE FROM Cotizaciones WHERE Cotizacion_ID = pCotizacionID;
END;

-- Actualizar salario de empleado
CREATE OR REPLACE PROCEDURE ActualizarSalarioEmpleado(pEmpleadoID NUMBER, pNuevoSalario VARCHAR) AS
BEGIN
    UPDATE Empleados SET Salario = pNuevoSalario WHERE Empleado_ID = pEmpleadoID;
END;

-- Obtener seguimiento por servicio
CREATE OR REPLACE PROCEDURE ConsultarSeguimientoServicio(pServicioRealizado NUMBER) AS
BEGIN
    FOR r IN (SELECT * FROM Seguimiento WHERE Servicio_Realizado = pServicioRealizado) LOOP
        DBMS_OUTPUT.PUT_LINE('Seguimiento: ' || r.Descripcion_Seguimiento);
    END LOOP;
END;

-- Actualizar descripción del inventario
CREATE OR REPLACE PROCEDURE ActualizarDescripcionInventario(pItemID NUMBER, pNuevaDescripcion VARCHAR) AS
BEGIN
    UPDATE Inventario SET Descripcion_Item = pNuevaDescripcion WHERE Item_ID = pItemID;
END;
