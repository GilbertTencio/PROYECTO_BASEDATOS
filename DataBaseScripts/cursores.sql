    CURSOR cur_clientes_activos IS
        SELECT Cliente_ID, Nombre_Cliente, Apellido_Cliente, Email_Cliente
        FROM Clientes
        WHERE Estado_ID = 1;

    CURSOR cur_inventario_bajo IS
        SELECT Item_ID, Nombre_Item, Cantidad_Item
        FROM Inventario
        WHERE Cantidad_Item < 5;

--estos primeros 2 cursores estan dentro del ultimo paquete, no deberian ponerlo en la base desde acá


DECLARE
    -- Cursor para obtener todos los servicios activos por técnico
    CURSOR c_servicios_activos_tecnico IS
        SELECT Tecnico, Nombre_Servicio, Fecha_ID, Precio_Total
        FROM Vista_Servicios_Activos_Tecnico;

    -- Variables para almacenar cada fila del cursor
    v_tecnico       VARCHAR2(200);
    v_servicio      VARCHAR2(200);
    v_fecha         DATE;
    v_precio_total  NUMBER;
BEGIN
    -- Abrimos el cursor y recorremos cada registro
    OPEN c_servicios_activos_tecnico;
    LOOP
        FETCH c_servicios_activos_tecnico 
        INTO v_tecnico, v_servicio, v_fecha, v_precio_total;

        EXIT WHEN c_servicios_activos_tecnico%NOTFOUND;

        -- Aquí podrías generar alertas o registros de reporte
        DBMS_OUTPUT.PUT_LINE(
            'Técnico: ' || v_tecnico ||
            ' | Servicio: ' || v_servicio ||
            ' | Fecha: ' || v_fecha ||
            ' | Precio Total: ' || v_precio_total
        );
    END LOOP;
    CLOSE c_servicios_activos_tecnico;
END;




-- Cursor para recorrer productos con menos de 5 unidades
DECLARE
    CURSOR c_inventario_bajo IS
        SELECT *
        FROM Vista_Inventario_Bajo;

    -- Registro para almacenar los datos de cada fila
    v_item Vista_Inventario_Bajo%ROWTYPE;

BEGIN
    OPEN c_inventario_bajo;

    LOOP
        FETCH c_inventario_bajo INTO v_item;
        EXIT WHEN c_inventario_bajo%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ALERTA: Producto "' || v_item.Nombre_Item || 
            '" con stock bajo (' || v_item.Cantidad_Item || ' unidades).'
        );
    END LOOP;

    CLOSE c_inventario_bajo;
END;




-- Cursor de historial de reparaciones por cliente
DECLARE
    CURSOR c_historial_reparaciones IS
        SELECT * FROM Vista_Historial_Reparaciones;

    v_cliente         VARCHAR2(200);
    v_nombre_servicio VARCHAR2(200);
    v_fecha_id        DATE;          -- Cambio aquí: DATE en vez de NUMBER
    v_precio_total    NUMBER;
BEGIN
    OPEN c_historial_reparaciones;
    LOOP
        FETCH c_historial_reparaciones 
        INTO v_cliente, v_nombre_servicio, v_fecha_id, v_precio_total;

        EXIT WHEN c_historial_reparaciones%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Cliente: ' || v_cliente ||
            ' | Servicio: ' || v_nombre_servicio ||
            ' | Fecha ID: ' || TO_CHAR(v_fecha_id, 'DD/MM/YYYY') ||
            ' | Precio Total: ' || v_precio_total
        );
    END LOOP;
    CLOSE c_historial_reparaciones;
END;




--Cursor de cotizaciones con detalle
DECLARE
    CURSOR c_cotizaciones_detalle IS
        SELECT * FROM Vista_Cotizaciones_Detalle;

    v_cotizacion_id       Cotizaciones.Cotizacion_ID%TYPE;
    v_nombre_servicio     Gestion_Servicios.Nombre_Servicio%TYPE;
    v_nombre_item         Inventario.Nombre_Item%TYPE;
    v_tecnico             VARCHAR2(200);
    v_fecha_servicio      Cotizaciones.Posible_Fecha_Servicio%TYPE;
BEGIN
    OPEN c_cotizaciones_detalle;
    LOOP
        FETCH c_cotizaciones_detalle 
        INTO v_cotizacion_id, v_nombre_servicio, v_nombre_item, v_tecnico, v_fecha_servicio;

        EXIT WHEN c_cotizaciones_detalle%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Cotización ID: ' || v_cotizacion_id ||
            ' | Servicio: ' || v_nombre_servicio ||
            ' | Item: ' || v_nombre_item ||
            ' | Técnico: ' || v_tecnico ||
            ' | Fecha Servicio: ' || TO_CHAR(v_fecha_servicio, 'DD/MM/YYYY')
        );
    END LOOP;
    CLOSE c_cotizaciones_detalle;
END;




--Cursor de pagos completados
DECLARE
    CURSOR c_pagos_completados IS
        SELECT * FROM Vista_Pagos_Completados;

    v_pago_id        Pagos.Pago_ID%TYPE;
    v_cliente        Clientes.Nombre_Cliente%TYPE;
    v_servicio       Gestion_Servicios.Nombre_Servicio%TYPE;
    v_precio_total   Pagos.Precio_Total%TYPE;
    v_metodo_pago    Pagos.Metodo_Pago%TYPE;
BEGIN
    OPEN c_pagos_completados;
    LOOP
        FETCH c_pagos_completados
        INTO v_pago_id, v_cliente, v_servicio, v_precio_total, v_metodo_pago;

        EXIT WHEN c_pagos_completados%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Pago ID: ' || v_pago_id ||
            ' | Cliente: ' || v_cliente ||
            ' | Servicio: ' || v_servicio ||
            ' | Total: ' || v_precio_total ||
            ' | Método: ' || v_metodo_pago
        );
    END LOOP;
    CLOSE c_pagos_completados;
END;




--Cursor de clientes activos
DECLARE
    CURSOR c_clientes_activos IS
        SELECT * FROM V_CLIENTES_ACTIVOS;

    v_cliente_id    Clientes.Cliente_ID%TYPE;
    v_nombre       Clientes.Nombre_Cliente%TYPE;
    v_apellido     Clientes.Apellido_Cliente%TYPE;
    v_email        Clientes.Email_Cliente%TYPE;
BEGIN
    OPEN c_clientes_activos;
    LOOP
        FETCH c_clientes_activos INTO v_cliente_id, v_nombre, v_apellido, v_email;
        EXIT WHEN c_clientes_activos%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Cliente ID: ' || v_cliente_id ||
            ' | Nombre: ' || v_nombre || ' ' || v_apellido ||
            ' | Email: ' || v_email
        );
    END LOOP;
    CLOSE c_clientes_activos;
END;




DECLARE
    CURSOR c_inventario_precio_alto IS
        SELECT * FROM VW_INVENTARIO_PRECIO_ALTO;

    v_item_id     Inventario.Item_ID%TYPE;
    v_nombre_item Inventario.Nombre_Item%TYPE;
    v_precio      Inventario.Precio_Unitario%TYPE;
    v_cantidad    Inventario.Cantidad_Item%TYPE;
BEGIN
    OPEN c_inventario_precio_alto;
    LOOP
        FETCH c_inventario_precio_alto INTO v_item_id, v_nombre_item, v_precio, v_cantidad;
        EXIT WHEN c_inventario_precio_alto%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Producto ID: ' || v_item_id ||
            ' | Nombre: ' || v_nombre_item ||
            ' | Precio: ' || TO_CHAR(v_precio, '999,999,999.00') ||
            ' | Cantidad: ' || v_cantidad
        );
    END LOOP;
    CLOSE c_inventario_precio_alto;
END;




DECLARE
    CURSOR c_pagos_efectivo IS
        SELECT * FROM VW_PAGOS_EFECTIVO;

    v_pago_id          Pagos.Pago_ID%TYPE;
    v_servicio_realizado Pagos.Servicio_Realizado%TYPE;
    v_precio_total     Pagos.Precio_Total%TYPE;
    v_metodo_pago      Pagos.Metodo_Pago%TYPE;
BEGIN
    OPEN c_pagos_efectivo;
    LOOP
        FETCH c_pagos_efectivo INTO v_pago_id, v_servicio_realizado, v_precio_total, v_metodo_pago;
        EXIT WHEN c_pagos_efectivo%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Pago ID: ' || v_pago_id ||
            ' | Servicio Realizado: ' || v_servicio_realizado ||
            ' | Precio Total: ' || TO_CHAR(v_precio_total, '999,999,999.00') ||
            ' | Método de Pago: ' || v_metodo_pago
        );
    END LOOP;
    CLOSE c_pagos_efectivo;
END;



