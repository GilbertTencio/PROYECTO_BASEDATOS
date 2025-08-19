CREATE OR REPLACE TRIGGER Actualizar_Stock_al_Insertar_Detalle
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET Stock = Stock - :NEW.Cantidad
    WHERE ID_Producto = :NEW.ID_Producto;
END;
/

CREATE OR REPLACE TRIGGER Notificar_Proveedor_Cuando_Stock_Bajo
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF :NEW.Stock < 5 THEN
        -- Aquí puedes agregar la lógica para notificar al proveedor
        DBMS_OUTPUT.PUT_LINE('Stock bajo para el producto: ' || :NEW.Nombre);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER Registrar_Fecha_Ultima_Actualizacion
BEFORE UPDATE ON Inventario
FOR EACH ROW
BEGIN
    :NEW.Fecha_Ultima_Actualizacion := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER Calcular_Total_Venta_al_Insertar_Detalle
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
BEGIN
    UPDATE Ventas
    SET Total = Total + (:NEW.Cantidad * :NEW.Precio_Unitario)
    WHERE ID_Venta = :NEW.ID_Venta;
END;
/

CREATE OR REPLACE TRIGGER Auditar_Cambios_en_Productos
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Producto actualizado: ' || :NEW.Nombre);
END;
/