
-- 1
CREATE OR REPLACE FUNCTION fn_ServiciosActivosTecnico
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM Vista_Servicios_Activos_Tecnico;
    RETURN c;
END;
/
-- 2
CREATE OR REPLACE FUNCTION fn_InventarioBajo
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM Vista_Inventario_Bajo;
    RETURN c;
END;
/
-- 3
CREATE OR REPLACE FUNCTION fn_HistorialReparaciones
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM Vista_Historial_Reparaciones;
    RETURN c;
END;
/
-- 4
CREATE OR REPLACE FUNCTION fn_CotizacionesDetalle
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM Vista_Cotizaciones_Detalle;
    RETURN c;
END;
/
-- 5
CREATE OR REPLACE FUNCTION fn_PagosCompletados
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM Vista_Pagos_Completados;
    RETURN c;
END;
/
-- 6
CREATE OR REPLACE FUNCTION fn_ClientesActivos
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM V_CLIENTES_ACTIVOS;
    RETURN c;
END;
/
-- 7
CREATE OR REPLACE FUNCTION fn_InventarioPrecioAlto
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM VW_INVENTARIO_PRECIO_ALTO;
    RETURN c;
END;
/
-- 8
CREATE OR REPLACE FUNCTION fn_ServiciosRealizadosFecha
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM VW_SERVICIOS_REALIZADOS_FECHA;
    RETURN c;
END;
/
-- 9
CREATE OR REPLACE FUNCTION fn_EmpleadosTecnicos
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM VW_EMPLEADOS_TECNICOS;
    RETURN c;
END;
/
-- 10
CREATE OR REPLACE FUNCTION fn_PagosEfectivo
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * FROM VW_PAGOS_EFECTIVO;
    RETURN c;
END;
/
-- 11
CREATE OR REPLACE FUNCTION fn_ServiciosPorTecnico
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT e.Nombre_Empleado || ' ' || e.Apellido_Empleado AS Tecnico,
           gs.Nombre_Servicio,
           sc.Fecha_ID,
           sc.Precio_Total
    FROM Servicio_Cliente sc
    JOIN Empleados e ON sc.Empleado_ID = e.Empleado_ID
    JOIN Gestion_Servicios gs ON sc.Servicio_ID = gs.Servicio_ID;
    RETURN c;
END;
/
-- 12
CREATE OR REPLACE FUNCTION fn_HistorialPagosCliente
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT c.Nombre_Cliente || ' ' || c.Apellido_Cliente AS Cliente,
           gs.Nombre_Servicio,
           p.Precio_Total,
           p.Metodo_Pago
    FROM Pagos p
    JOIN Servicio_Cliente sc ON p.Servicio_Realizado = sc.Servicio_Realizado
    JOIN Clientes c ON sc.Cliente_ID = c.Cliente_ID
    JOIN Gestion_Servicios gs ON sc.Servicio_ID = gs.Servicio_ID;
    RETURN c;
END;
/
-- 13
CREATE OR REPLACE FUNCTION fn_InventarioConCategoria
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT i.Item_ID, i.Nombre_Item, i.Precio_Unitario, cp.Nombre_Categoria
    FROM Inventario i
    JOIN Categoria_Producto cp ON i.Item_ID = cp.Item_ID;
    RETURN c;
END;
/
-- 14
CREATE OR REPLACE FUNCTION fn_CotizacionesPendientes
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT * 
    FROM Cotizaciones
    WHERE Estado_ID = (SELECT Estado_ID FROM Estado WHERE Nombre_Estado = 'Activo');
    RETURN c;
END;
/
-- 15
CREATE OR REPLACE FUNCTION fn_ClientesRecientes
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR 
    SELECT DISTINCT c.Cliente_ID, c.Nombre_Cliente, c.Apellido_Cliente
    FROM Clientes c
    JOIN Servicio_Cliente sc ON c.Cliente_ID = sc.Cliente_ID
    WHERE sc.Fecha_ID >= SYSDATE - 30;
    RETURN c;
END;
/
--16
CREATE OR REPLACE FUNCTION fn_ListarEstados
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR
    SELECT * FROM Estado;
    RETURN c;
END;

/
--17
CREATE OR REPLACE FUNCTION fn_ListarServicios
RETURN SYS_REFCURSOR IS
    c SYS_REFCURSOR;
BEGIN
    OPEN c FOR
    SELECT * FROM Gestion_Servicios;
    RETURN c;
END;
/




