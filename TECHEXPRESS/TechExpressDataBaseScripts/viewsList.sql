-- 1. Vista de servicios activos por técnico
CREATE OR REPLACE VIEW Vista_Servicios_Activos_Tecnico AS
SELECT 
    e.Nombre_Empleado || ' ' || e.Apellido_Empleado AS Tecnico,
    gs.Nombre_Servicio,
    sc.Fecha_ID,
    sc.Precio_Total
FROM Servicio_Cliente sc
JOIN Empleados e ON sc.Empleado_ID = e.Empleado_ID
JOIN Gestion_Servicios gs ON sc.Servicio_ID = gs.Servicio_ID
WHERE sc.Estado_ID IN (SELECT Estado_ID FROM Estado WHERE Nombre_Estado = 'Activo');

-- 2. Vista de inventario bajo (menos de 5 unidades)
CREATE OR REPLACE VIEW Vista_Inventario_Bajo AS
SELECT * 
FROM Inventario
WHERE Cantidad_Item < 5;

-- 3. Vista de historial de reparaciones por cliente
CREATE OR REPLACE VIEW Vista_Historial_Reparaciones AS
SELECT 
    c.Nombre_Cliente || ' ' || c.Apellido_Cliente AS Cliente,
    gs.Nombre_Servicio,
    sc.Fecha_ID,
    sc.Precio_Total
FROM Servicio_Cliente sc
JOIN Clientes c ON sc.Cliente_ID = c.Cliente_ID
JOIN Gestion_Servicios gs ON sc.Servicio_ID = gs.Servicio_ID;

-- 4. Vista de cotizaciones con detalle de servicio y técnico
CREATE OR REPLACE VIEW Vista_Cotizaciones_Detalle AS
SELECT 
    ct.Cotizacion_ID,
    gs.Nombre_Servicio,
    i.Nombre_Item,
    e.Nombre_Empleado || ' ' || e.Apellido_Empleado AS Tecnico,
    ct.Posible_Fecha_Servicio
FROM Cotizaciones ct
JOIN Gestion_Servicios gs ON ct.Servicio_ID = gs.Servicio_ID
JOIN Inventario i ON ct.Item_ID = i.Item_ID
JOIN Empleados e ON ct.Empleado_ID = e.Empleado_ID;

-- 5. Vista de pagos completados
CREATE OR REPLACE VIEW Vista_Pagos_Completados AS
SELECT 
    p.Pago_ID,
    c.Nombre_Cliente,
    gs.Nombre_Servicio,
    p.Precio_Total,
    p.Metodo_Pago
FROM Pagos p
JOIN Servicio_Cliente sc ON p.Servicio_Realizado = sc.Servicio_Realizado
JOIN Clientes c ON sc.Cliente_ID = c.Cliente_ID
JOIN Gestion_Servicios gs ON sc.Servicio_ID = gs.Servicio_ID
WHERE p.Estado_ID IN (SELECT Estado_ID FROM Estado WHERE Nombre_Estado = 'Pagado');
