-- 1. Cursor para recorrer todas las ventas
CREATE OR REPLACE PROCEDURE sp_Recorrer_Ventas(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas;
END;
/

-- 2. Cursor para recorrer todos los productos
CREATE OR REPLACE PROCEDURE sp_Recorrer_Productos(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos;
END;
/

-- 3. Cursor para recorrer todos los clientes
CREATE OR REPLACE PROCEDURE sp_Recorrer_Clientes(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Clientes;
END;
/

-- 4. Cursor para recorrer todos los proveedores
CREATE OR REPLACE PROCEDURE sp_Recorrer_Proveedores(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Proveedores;
END;
/

-- 5. Cursor para recorrer todos los detalles de ventas
CREATE OR REPLACE PROCEDURE sp_Recorrer_Detalles_Venta(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Detalles_Venta;
END;
/

-- 6. Cursor para recorrer todos los empleados
CREATE OR REPLACE PROCEDURE sp_Recorrer_Empleados(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Empleados;
END;
/

-- 7. Cursor para recorrer el inventario
CREATE OR REPLACE PROCEDURE sp_Recorrer_Inventario(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Inventario;
END;
/

-- 8. Cursor para recorrer todas las categorías
CREATE OR REPLACE PROCEDURE sp_Recorrer_Categorias(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Categorias;
END;
/

-- 9. Cursor para recorrer ventas por fecha
CREATE OR REPLACE PROCEDURE sp_Recorrer_Ventas_Por_Fecha(
    p_Fecha IN DATE,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas WHERE TRUNC(Fecha_Venta) = TRUNC(p_Fecha);
END;
/

-- 10. Cursor para recorrer productos por categoría
CREATE OR REPLACE PROCEDURE sp_Recorrer_Productos_Por_Categoria(
    p_ID_Categoria IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos WHERE ID_Categoria = p_ID_Categoria;
END;
/

-- 11. Cursor para recorrer clientes frecuentes
CREATE OR REPLACE PROCEDURE sp_Recorrer_Clientes_Frecuentes(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT c.ID_Cliente, c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Ventas
    FROM Clientes c
    JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
    GROUP BY c.ID_Cliente, c.Nombre, c.Apellido
    HAVING COUNT(v.ID_Venta) > 5; -- Por ejemplo, clientes con más de 5 compras
END;
/

-- 12. Cursor para recorrer ventas totales por producto
CREATE OR REPLACE PROCEDURE sp_Recorrer_Ventas_Totales_Por_Producto(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT p.ID_Producto, p.Nombre, SUM(dv.Cantidad) AS Total_Vendido
    FROM Detalles_Venta dv
    JOIN Productos p ON dv.ID_Producto = p.ID_Producto
    GROUP BY p.ID_Producto, p.Nombre;
END;
/

-- 13. Cursor para recorrer auditoría de productos
CREATE OR REPLACE PROCEDURE sp_Recorrer_Auditoria_Productos(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Auditoria_Productos;
END;
/

-- 14. Cursor para recorrer ventas por empleado
CREATE OR REPLACE PROCEDURE sp_Recorrer_Ventas_Por_Empleado(
    p_ID_Empleado IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas WHERE ID_Empleado = p_ID_Empleado;
END;
/

-- 15. Cursor para recorrer productos en stock bajo
CREATE OR REPLACE PROCEDURE sp_Recorrer_Productos_Stock_Bajo(
    p_Umbral IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos WHERE Stock < p_Umbral;
END;
/