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










