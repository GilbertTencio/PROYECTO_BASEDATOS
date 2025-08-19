-- 1. Vista de Productos con Stock Crítico
CREATE OR REPLACE VIEW vw_ProductosStockCritico AS
SELECT p.ID_Producto, p.Nombre, p.Stock, 
       pr.Nombre AS Proveedor, c.Nombre AS Categoria,
       p.Precio
FROM Productos p
JOIN Proveedores pr ON p.ID_Proveedor = pr.ID_Proveedor
JOIN Categorias c ON p.ID_Categoria = c.ID_Categoria
WHERE p.Stock < 5
ORDER BY p.Stock ASC;

-- 2. Vista de Ventas por Cliente
CREATE OR REPLACE VIEW vw_VentasPorCliente AS
SELECT c.ID_Cliente, 
       c.Nombre || ' ' || c.Apellido AS Cliente,
       COUNT(v.ID_Venta) AS Numero_Ventas,
       SUM(v.Total) AS Total_Comprado,
       MAX(v.Fecha_Venta) AS Ultima_Compra
FROM Clientes c
LEFT JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente, c.Nombre, c.Apellido
ORDER BY Total_Comprado DESC;

-- 3. Vista de Resumen Ventas Diarias
CREATE OR REPLACE VIEW vw_ResumenVentasDiarias AS
SELECT TRUNC(Fecha_Venta) AS Fecha,
       COUNT(ID_Venta) AS Numero_Ventas,
       SUM(Total) AS Total_Ventas,
       AVG(Total) AS Promedio_Venta
FROM Ventas
GROUP BY TRUNC(Fecha_Venta)
ORDER BY Fecha DESC;

-- 4. Vista de Top Productos Vendidos
CREATE OR REPLACE VIEW vw_TopProductosVendidos AS
SELECT p.ID_Producto, p.Nombre, 
       SUM(dv.Cantidad) AS Total_Vendido,
       SUM(dv.Cantidad * dv.Precio_Unitario) AS Valor_Total
FROM Productos p
JOIN Detalles_Venta dv ON p.ID_Producto = dv.ID_Producto
GROUP BY p.ID_Producto, p.Nombre
ORDER BY Total_Vendido DESC;

-- 5. Vista de Proveedores con Productos
CREATE OR REPLACE VIEW vw_ProveedoresConProductos AS
SELECT pr.ID_Proveedor, pr.Nombre,
       COUNT(p.ID_Producto) AS Cantidad_Productos,
       SUM(p.Stock) AS Stock_Total,
       MIN(p.Stock) AS Minimo_Stock,
       MAX(p.Precio) AS Precio_Maximo
FROM Proveedores pr
LEFT JOIN Productos p ON pr.ID_Proveedor = p.ID_Proveedor
GROUP BY pr.ID_Proveedor, pr.Nombre
ORDER BY Cantidad_Productos DESC;

-- 6. Vista de Detalle Completo de Ventas
CREATE OR REPLACE VIEW vw_DetalleCompletoVentas AS
SELECT v.ID_Venta, v.Fecha_Venta, 
       c.Nombre || ' ' || c.Apellido AS Cliente,
       e.Nombre || ' ' || e.Apellido AS Empleado,
       v.Total,
       LISTAGG(p.Nombre, ', ') WITHIN GROUP (ORDER BY p.Nombre) AS Productos
FROM Ventas v
JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente
LEFT JOIN Empleados e ON v.ID_Empleado = e.ID_Empleado
JOIN Detalles_Venta dv ON v.ID_Venta = dv.ID_Venta
JOIN Productos p ON dv.ID_Producto = p.ID_Producto
GROUP BY v.ID_Venta, v.Fecha_Venta, c.Nombre, c.Apellido, e.Nombre, e.Apellido, v.Total;

-- 7. Vista de Rendimiento de Empleados
CREATE OR REPLACE VIEW vw_RendimientoEmpleados AS
SELECT e.ID_Empleado, 
       e.Nombre || ' ' || e.Apellido AS Empleado,
       e.Cargo,
       COUNT(v.ID_Venta) AS Ventas_Realizadas,
       SUM(v.Total) AS Monto_Total,
       NVL(SUM(v.Total)/NULLIF(COUNT(v.ID_Venta),0),0) AS Promedio_Venta
FROM Empleados e
LEFT JOIN Ventas v ON e.ID_Empleado = v.ID_Empleado
GROUP BY e.ID_Empleado, e.Nombre, e.Apellido, e.Cargo
ORDER BY Monto_Total DESC;

-- 8. Vista de Productos por Categoría
CREATE OR REPLACE VIEW vw_ProductosPorCategoria AS
SELECT c.ID_Categoria, c.Nombre AS Categoria,
       COUNT(p.ID_Producto) AS Cantidad_Productos,
       SUM(p.Stock) AS Stock_Total,
       MIN(p.Precio) AS Precio_Minimo,
       MAX(p.Precio) AS Precio_Maximo,
       AVG(p.Precio) AS Precio_Promedio
FROM Categorias c
LEFT JOIN Productos p ON c.ID_Categoria = p.ID_Categoria
GROUP BY c.ID_Categoria, c.Nombre
ORDER BY Cantidad_Productos DESC;

-- 9. Vista de Historial de Precios
CREATE OR REPLACE VIEW vw_HistorialPrecios AS
SELECT ap.ID_Producto, p.Nombre,
       ap.Precio_Anterior, ap.Precio_Nuevo,
       (ap.Precio_Nuevo - ap.Precio_Anterior) AS Diferencia,
       ROUND(((ap.Precio_Nuevo - ap.Precio_Anterior)/ap.Precio_Anterior)*100,2) || '%' AS Porcentaje_Cambio,
       ap.Usuario, ap.Fecha_Cambio
FROM Auditoria_Productos ap
JOIN Productos p ON ap.ID_Producto = p.ID_Producto
ORDER BY ap.Fecha_Cambio DESC;

-- 10. Vista de Resumen Mensual
CREATE OR REPLACE VIEW vw_ResumenMensual AS
SELECT EXTRACT(YEAR FROM Fecha_Venta) AS Anio,
       EXTRACT(MONTH FROM Fecha_Venta) AS Mes,
       TO_CHAR(Fecha_Venta, 'Month') AS Nombre_Mes,
       COUNT(ID_Venta) AS Numero_Ventas,
       SUM(Total) AS Total_Ventas,
       AVG(Total) AS Promedio_Venta,
       MIN(Total) AS Minima_Venta,
       MAX(Total) AS Maxima_Venta
FROM Ventas
GROUP BY EXTRACT(YEAR FROM Fecha_Venta), 
         EXTRACT(MONTH FROM Fecha_Venta),
         TO_CHAR(Fecha_Venta, 'Month')
ORDER BY Anio DESC, Mes DESC;