-- Paquete para manejo de productos
CREATE OR REPLACE PACKAGE pkg_productos AS
    PROCEDURE insertar_producto (
        p_id_producto  IN INT,
        p_nombre       IN VARCHAR,
        p_descripcion  IN VARCHAR,
        p_precio       IN DECIMAL,
        p_stock        IN INT,
        p_id_proveedor IN INT,
        p_id_categoria IN INT
    );

    PROCEDURE actualizar_producto (
        p_id_producto IN INT,
        p_nombre      IN VARCHAR,
        p_descripcion IN VARCHAR,
        p_precio      IN DECIMAL,
        p_stock       IN INT
    );

    PROCEDURE eliminar_producto (
        p_id_producto IN INT
    );

    FUNCTION obtener_stock_producto (
        p_id_producto IN INT
    ) RETURN INT;

    FUNCTION obtener_informacion_producto (
        p_id_producto IN INT
    ) RETURN VARCHAR2;

    FUNCTION calcular_valor_producto (
        p_id_producto IN INT
    ) RETURN DECIMAL;

END pkg_productos;
/

CREATE OR REPLACE PACKAGE BODY pkg_productos AS

    PROCEDURE insertar_producto (
        p_id_producto  IN INT,
        p_nombre       IN VARCHAR,
        p_descripcion  IN VARCHAR,
        p_precio       IN DECIMAL,
        p_stock        IN INT,
        p_id_proveedor IN INT,
        p_id_categoria IN INT
    ) IS
    BEGIN
        INSERT INTO productos (
            id_producto,
            nombre,
            descripcion,
            precio,
            stock,
            id_proveedor,
            id_categoria
        ) VALUES ( p_id_producto,
                   p_nombre,
                   p_descripcion,
                   p_precio,
                   p_stock,
                   p_id_proveedor,
                   p_id_categoria );

        COMMIT;
    END;

    PROCEDURE actualizar_producto (
        p_id_producto IN INT,
        p_nombre      IN VARCHAR,
        p_descripcion IN VARCHAR,
        p_precio      IN DECIMAL,
        p_stock       IN INT
    ) IS
    BEGIN
        UPDATE productos
        SET
            nombre = p_nombre,
            descripcion = p_descripcion,
            precio = p_precio,
            stock = p_stock
        WHERE
            id_producto = p_id_producto;

        COMMIT;
    END;

    PROCEDURE eliminar_producto (
        p_id_producto IN INT
    ) IS
    BEGIN
        DELETE FROM productos
        WHERE
            id_producto = p_id_producto;

        COMMIT;
    END;

    FUNCTION obtener_stock_producto (
        p_id_producto IN INT
    ) RETURN INT IS
        v_stock INT;
    BEGIN
        SELECT
            stock
        INTO v_stock
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_stock;
    END;

    FUNCTION obtener_informacion_producto (
        p_id_producto IN INT
    ) RETURN VARCHAR2 IS
        v_informacion VARCHAR2(255);
    BEGIN
        SELECT
            nombre
            || ' - '
            || descripcion
        INTO v_informacion
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_informacion;
    END;

    FUNCTION calcular_valor_producto (
        p_id_producto IN INT
    ) RETURN DECIMAL IS
        v_valor DECIMAL(10, 2);
    BEGIN
        SELECT
            precio * stock
        INTO v_valor
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_valor;
    END;

END pkg_productos;
/

-- Paquete para manejo de ventas
CREATE OR REPLACE PACKAGE pkg_ventas AS
    PROCEDURE registrar_venta (
        p_id_venta    IN INT,
        p_id_cliente  IN INT,
        p_id_empleado IN INT,
        p_fecha_venta IN DATE
    );

    PROCEDURE agregar_detalle_venta (
        p_id_venta    IN INT,
        p_id_producto IN INT,
        p_cantidad    IN INT,
        p_descuento   IN DECIMAL DEFAULT 0
    );

    FUNCTION calcular_total_venta (
        p_id_venta IN INT
    ) RETURN DECIMAL;

    FUNCTION obtener_detalle_venta (
        p_id_venta IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_ventas;
/

CREATE OR REPLACE PACKAGE BODY pkg_ventas AS

    PROCEDURE registrar_venta (
        p_id_venta    IN INT,
        p_id_cliente  IN INT,
        p_id_empleado IN INT,
        p_fecha_venta IN DATE
    ) IS
    BEGIN
        INSERT INTO ventas (
            id_venta,
            id_cliente,
            id_empleado,
            fecha_venta,
            total
        ) VALUES ( p_id_venta,
                   p_id_cliente,
                   p_id_empleado,
                   p_fecha_venta,
                   0 );

        COMMIT;
    END;

    PROCEDURE agregar_detalle_venta (
        p_id_venta    IN INT,
        p_id_producto IN INT,
        p_cantidad    IN INT,
        p_descuento   IN DECIMAL DEFAULT 0
    ) IS
        v_precio_unitario DECIMAL(10, 2);
    BEGIN
        SELECT
            precio
        INTO v_precio_unitario
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        INSERT INTO detalles_venta (
            id_detalle,
            id_venta,
            id_producto,
            cantidad,
            precio_unitario,
            descuento
        ) VALUES ( seq_detalle_venta.NEXTVAL,
                   p_id_venta,
                   p_id_producto,
                   p_cantidad,
                   v_precio_unitario,
                   p_descuento );

        COMMIT;
    END;

    FUNCTION calcular_total_venta (
        p_id_venta IN INT
    ) RETURN DECIMAL IS
        v_total DECIMAL(10, 2);
    BEGIN
        SELECT
            SUM(cantidad * precio_unitario *(1 - nvl(descuento, 0) / 100))
        INTO v_total
        FROM
            detalles_venta
        WHERE
            id_venta = p_id_venta;

        UPDATE ventas
        SET
            total = v_total
        WHERE
            id_venta = p_id_venta;

        COMMIT;
        RETURN v_total;
    END;

    FUNCTION obtener_detalle_venta (
        p_id_venta IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                p.nombre,
                                                dv.cantidad,
                                                dv.precio_unitario,
                                                ( dv.cantidad * dv.precio_unitario * ( 1 - nvl(dv.descuento, 0) / 100 ) ) AS subtotal
                                            FROM
                                                     detalles_venta dv
                                                JOIN productos p ON dv.id_producto = p.id_producto
                          WHERE
                              dv.id_venta = p_id_venta;

        RETURN v_cursor;
    END;

END pkg_ventas;
/



--Secuencia para ventas
CREATE SEQUENCE seq_detalle_venta START WITH 1 INCREMENT BY 1 NOCACHE;


-- Paquete para manejo de clientes
CREATE OR REPLACE PACKAGE pkg_clientes AS
    PROCEDURE registrar_cliente (
        p_id_cliente IN INT,
        p_nombre     IN VARCHAR,
        p_apellido   IN VARCHAR,
        p_email      IN VARCHAR,
        p_telefono   IN VARCHAR,
        p_direccion  IN VARCHAR
    );

    PROCEDURE actualizar_cliente (
        p_id_cliente IN INT,
        p_nombre     IN VARCHAR,
        p_apellido   IN VARCHAR,
        p_email      IN VARCHAR,
        p_telefono   IN VARCHAR,
        p_direccion  IN VARCHAR
    );

    PROCEDURE eliminar_cliente (
        p_id_cliente IN INT
    );

    FUNCTION obtener_cliente (
        p_id_cliente IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_clientes;
/

CREATE OR REPLACE PACKAGE BODY pkg_clientes AS

    PROCEDURE registrar_cliente (
        p_id_cliente IN INT,
        p_nombre     IN VARCHAR,
        p_apellido   IN VARCHAR,
        p_email      IN VARCHAR,
        p_telefono   IN VARCHAR,
        p_direccion  IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO clientes (
            id_cliente,
            nombre,
            apellido,
            email,
            telefono,
            direccion
        ) VALUES ( p_id_cliente,
                   p_nombre,
                   p_apellido,
                   p_email,
                   p_telefono,
                   p_direccion );

        COMMIT;
    END registrar_cliente;

    PROCEDURE actualizar_cliente (
        p_id_cliente IN INT,
        p_nombre     IN VARCHAR,
        p_apellido   IN VARCHAR,
        p_email      IN VARCHAR,
        p_telefono   IN VARCHAR,
        p_direccion  IN VARCHAR
    ) IS
    BEGIN
        UPDATE clientes
        SET
            nombre = p_nombre,
            apellido = p_apellido,
            email = p_email,
            telefono = p_telefono,
            direccion = p_direccion
        WHERE
            id_cliente = p_id_cliente;

        COMMIT;
    END actualizar_cliente;

    PROCEDURE eliminar_cliente (
        p_id_cliente IN INT
    ) IS
    BEGIN
        DELETE FROM clientes
        WHERE
            id_cliente = p_id_cliente;

        COMMIT;
    END eliminar_cliente;

    FUNCTION obtener_cliente (
        p_id_cliente IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                *
                                            FROM
                                                clientes
                          WHERE
                              id_cliente = p_id_cliente;

        RETURN v_cursor;
    END obtener_cliente;

END pkg_clientes;
/


-- Paquete para manejo de proveedores
CREATE OR REPLACE PACKAGE pkg_proveedores AS
    PROCEDURE registrar_proveedor (
        p_id_proveedor IN INT,
        p_nombre       IN VARCHAR,
        p_email        IN VARCHAR,
        p_telefono     IN VARCHAR,
        p_direccion    IN VARCHAR
    );

    PROCEDURE actualizar_proveedor (
        p_id_proveedor IN INT,
        p_nombre       IN VARCHAR,
        p_email        IN VARCHAR,
        p_telefono     IN VARCHAR,
        p_direccion    IN VARCHAR
    );

    PROCEDURE eliminar_proveedor (
        p_id_proveedor IN INT
    );

    FUNCTION obtener_proveedor (
        p_id_proveedor IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_proveedores;
/

CREATE OR REPLACE PACKAGE BODY pkg_proveedores AS

    PROCEDURE registrar_proveedor (
        p_id_proveedor IN INT,
        p_nombre       IN VARCHAR,
        p_email        IN VARCHAR,
        p_telefono     IN VARCHAR,
        p_direccion    IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO proveedores (
            id_proveedor,
            nombre,
            email,
            telefono,
            direccion
        ) VALUES ( p_id_proveedor,
                   p_nombre,
                   p_email,
                   p_telefono,
                   p_direccion );

        COMMIT;
    END registrar_proveedor;

    PROCEDURE actualizar_proveedor (
        p_id_proveedor IN INT,
        p_nombre       IN VARCHAR,
        p_email        IN VARCHAR,
        p_telefono     IN VARCHAR,
        p_direccion    IN VARCHAR
    ) IS
    BEGIN
        UPDATE proveedores
        SET
            nombre = p_nombre,
            email = p_email,
            telefono = p_telefono,
            direccion = p_direccion
        WHERE
            id_proveedor = p_id_proveedor;

        COMMIT;
    END actualizar_proveedor;

    PROCEDURE eliminar_proveedor (
        p_id_proveedor IN INT
    ) IS
    BEGIN
        DELETE FROM proveedores
        WHERE
            id_proveedor = p_id_proveedor;

        COMMIT;
    END eliminar_proveedor;

    FUNCTION obtener_proveedor (
        p_id_proveedor IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                *
                                            FROM
                                                proveedores
                          WHERE
                              id_proveedor = p_id_proveedor;

        RETURN v_cursor;
    END obtener_proveedor;

END pkg_proveedores;
/

-- Paquete para manejo de empleados
CREATE OR REPLACE PACKAGE pkg_empleados AS
    PROCEDURE registrar_empleado (
        p_id_empleado  IN INT,
        p_nombre       IN VARCHAR,
        p_apellido     IN VARCHAR,
        p_cargo        IN VARCHAR,
        p_salario      IN DECIMAL,
        p_departamento IN VARCHAR
    );

    PROCEDURE actualizar_empleado (
        p_id_empleado  IN INT,
        p_nombre       IN VARCHAR,
        p_apellido     IN VARCHAR,
        p_cargo        IN VARCHAR,
        p_salario      IN DECIMAL,
        p_departamento IN VARCHAR
    );

    FUNCTION obtener_empleado (
        p_id_empleado IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_empleados;
/

CREATE OR REPLACE PACKAGE BODY pkg_empleados AS

    PROCEDURE registrar_empleado (
        p_id_empleado  IN INT,
        p_nombre       IN VARCHAR,
        p_apellido     IN VARCHAR,
        p_cargo        IN VARCHAR,
        p_salario      IN DECIMAL,
        p_departamento IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO empleados (
            id_empleado,
            nombre,
            apellido,
            cargo,
            salario,
            departamento,
            fecha_contratacion
        ) VALUES ( p_id_empleado,
                   p_nombre,
                   p_apellido,
                   p_cargo,
                   p_salario,
                   p_departamento,
                   sysdate );

        COMMIT;
    END;

    PROCEDURE actualizar_empleado (
        p_id_empleado  IN INT,
        p_nombre       IN VARCHAR,
        p_apellido     IN VARCHAR,
        p_cargo        IN VARCHAR,
        p_salario      IN DECIMAL,
        p_departamento IN VARCHAR
    ) IS
    BEGIN
        UPDATE empleados
        SET
            nombre = p_nombre,
            apellido = p_apellido,
            cargo = p_cargo,
            salario = p_salario,
            departamento = p_departamento
        WHERE
            id_empleado = p_id_empleado;

        COMMIT;
    END;

    FUNCTION obtener_empleado (
        p_id_empleado IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                *
                                            FROM
                                                empleados
                          WHERE
                              id_empleado = p_id_empleado;

        RETURN v_cursor;
    END;

END pkg_empleados;
/

-- Paquete para manejo de auditoría
CREATE OR REPLACE PACKAGE pkg_auditoria AS
    PROCEDURE registrar_auditoria (
        p_id_producto     IN INT,
        p_accion          IN VARCHAR,
        p_precio_anterior IN DECIMAL,
        p_precio_nuevo    IN DECIMAL,
        p_usuario         IN VARCHAR
    );

    FUNCTION obtener_historial_auditoria (
        p_id_producto IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_auditoria;
/

CREATE OR REPLACE PACKAGE BODY pkg_auditoria AS

    PROCEDURE registrar_auditoria (
        p_id_producto     IN INT,
        p_accion          IN VARCHAR,
        p_precio_anterior IN DECIMAL,
        p_precio_nuevo    IN DECIMAL,
        p_usuario         IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO auditoria_productos (
            id_producto,
            accion,
            precio_anterior,
            precio_nuevo,
            usuario
        ) VALUES ( p_id_producto,
                   p_accion,
                   p_precio_anterior,
                   p_precio_nuevo,
                   p_usuario );

        COMMIT;
    END;

    FUNCTION obtener_historial_auditoria (
        p_id_producto IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                *
                                            FROM
                                                auditoria_productos
                          WHERE
                              id_producto = p_id_producto
                          ORDER BY
                              fecha_cambio DESC;

        RETURN v_cursor;
    END;

END pkg_auditoria;
/

-- Paquete para manejo de informes
CREATE OR REPLACE PACKAGE pkg_informes AS
    FUNCTION Generar_Informe_Ventas(
        p_Fecha_Inicio IN DATE,
        p_Fecha_Fin IN DATE
    ) RETURN CLOB;
    
    FUNCTION Generar_Informe_Inventario() RETURN CLOB;
END pkg_informes;
/

CREATE OR REPLACE PACKAGE BODY pkg_informes AS
    FUNCTION Generar_Informe_Ventas(
        p_Fecha_Inicio IN DATE,
        p_Fecha_Fin IN DATE
    ) RETURN CLOB IS
        v_Informe CLOB;
    BEGIN
        -- Lógica para generar informe de ventas
        v_Informe := 'Informe de Ventas desde ' || TO_CHAR(p_Fecha_Inicio, 'DD/MM/YYYY') || 
                     ' hasta ' || TO_CHAR(p_Fecha_Fin, 'DD/MM/YYYY') || CHR(10);
        
        -- Aquí se agregarían los detalles de las ventas
        RETURN v_Informe;
    END;

    FUNCTION Generar_Informe_Inventario() RETURN CLOB IS
        v_Informe CLOB;
    BEGIN
        -- Lógica para generar informe de inventario
        v_Informe := 'Informe de Inventario' || CHR(10);
        
        -- Aquí se agregarían los detalles del inventario
        RETURN v_Informe;
    END;
END pkg_informes;
/

-- Paquete para manejo de reportes
CREATE OR REPLACE PACKAGE pkg_reportes AS
    FUNCTION Generar_Reporte_Clientes_Frecuentes() RETURN SYS_REFCURSOR;
    FUNCTION Generar_Reporte_Ventas_Mensuales() RETURN SYS_REFCURSOR;
END pkg_reportes;
/

CREATE OR REPLACE PACKAGE BODY pkg_reportes AS
    FUNCTION Generar_Reporte_Clientes_Frecuentes() RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
    select
    c.id_cliente, c.nombre
    || ' '
    || c.apellido
    as
    cliente, count ( v.id_venta )
    as
    total_ventas, sum ( v.total )
    as
    total_comprado
    from
    clientes
    c
    join
    ventas
    v
    on
    c.id_cliente = v.id_cliente
    group
    by
    c.id_cliente, c.nombre, c.apellido
    order
    by
    total_comprado
        desc;
        RETURN v_cursor;
        end;
    FUNCTION generar_reporte_ventas_mensuales ( )
        RETURN sys_refcursor
    is
    v_cursor
        sys_refcursor;
    BEGIN
        OPEN v_Cursor FOR
        SELECT EXTRACT(YEAR FROM Fecha_Venta) AS Anio,
               EXTRACT(MONTH FROM Fecha_Venta) AS Mes,
               COUNT(ID_Venta) AS Numero_Ventas,
               SUM(Total) AS Total_Ventas
        FROM Ventas
        GROUP BY EXTRACT(YEAR FROM Fecha_Venta), EXTRACT(MONTH FROM Fecha_Venta)
        ORDER BY Anio DESC, Mes DESC;
        
        RETURN v_Cursor;
    END;
END pkg_reportes;
/

