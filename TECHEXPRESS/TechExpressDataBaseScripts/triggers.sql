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













