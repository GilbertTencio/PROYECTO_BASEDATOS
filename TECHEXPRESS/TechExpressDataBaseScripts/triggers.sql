--cuando se incerta un dato en seguimiento sin fecha, se agrega una fecha en seguimiento siquiente
CREATE OR REPLACE TRIGGER trg_asignar_fechas_seguimiento
BEFORE INSERT ON Seguimiento
FOR EACH ROW
BEGIN
    -- Si no se proporciona la fecha de seguimiento, se asigna la fecha actual
    IF :NEW.Fecha_Seguimiento IS NULL THEN
        :NEW.Fecha_Seguimiento := SYSDATE;
    END IF;

    -- Si no se proporciona la fecha del siguiente seguimiento, se suma 7 días
    IF :NEW.Seguimiento_Siguiente IS NULL THEN
        :NEW.Seguimiento_Siguiente := :NEW.Fecha_Seguimiento + 7;
    END IF;
END;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER trg_actualizar_estado_servicio_pago
AFTER INSERT ON Pagos
FOR EACH ROW
BEGIN
    -- Si el pago tiene estado 'Pagado' (13), cambiar estado del servicio a 'Finalizado' (4)
    IF :NEW.Estado_ID = 13 THEN
        UPDATE Servicio_Cliente
        SET Estado_ID = 6
        WHERE Servicio_Realizado = :NEW.Servicio_Realizado;
    END IF;
END;
/


INSERT INTO Pagos (Pago_ID,Servicio_Realizado,Estado_ID, Precio_Total, Metodo_Pago)
VALUES (4, 12,13, 200.00, '1');


SELECT Servicio_Realizado, Estado_ID
FROM Servicio_Cliente
WHERE Servicio_Realizado = 12;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace NONEDITIONABLE TRIGGER trg_asignar_fechas_seguimiento
BEFORE INSERT ON Seguimiento
FOR EACH ROW
BEGIN
    -- Si no se proporciona la fecha de seguimiento, se asigna la fecha actual
    IF :NEW.Fecha_Seguimiento IS NULL THEN
        :NEW.Fecha_Seguimiento := SYSDATE;
    END IF;

    -- Si no se proporciona la fecha del siguiente seguimiento, se suma 7 días
    IF :NEW.Seguimiento_Siguiente IS NULL THEN
        :NEW.Seguimiento_Siguiente := :NEW.Fecha_Seguimiento + 7;
    END IF;
END;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace NONEDITIONABLE TRIGGER trg_actualizar_stock_servicio
AFTER INSERT ON Servicio_Cliente
FOR EACH ROW
DECLARE
    v_item_id NUMBER;
BEGIN
    -- Buscar el Item_ID correspondiente al Servicio_ID insertado
    SELECT Item_ID
    INTO v_item_id
    FROM Gestion_Servicios
    WHERE Servicio_ID = :NEW.Servicio_ID;

    -- Actualizar el stock en Inventario restando la cantidad de servicios
    UPDATE Inventario
    SET Cantidad_Item = Cantidad_Item - :NEW.Cantidad_Servicios
    WHERE Item_ID = v_item_id;
END;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER trg_evitar_eliminar_cliente_con_servicios
BEFORE DELETE ON Clientes
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Contar servicios pendientes o en proceso asociados al cliente
    SELECT COUNT(*)
    INTO v_count
    FROM Servicio_Cliente
    WHERE Cliente_ID = :OLD.Cliente_ID
      AND Estado_ID IN (3, 4); -- 1: Pendiente, 2: En proceso (ajustar según tus datos)

    -- Si tiene servicios activos, cancelar la eliminación
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar el cliente porque tiene servicios activos.');
    END IF;
END;







