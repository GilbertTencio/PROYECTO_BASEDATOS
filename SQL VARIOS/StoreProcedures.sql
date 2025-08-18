-- 1. Insertar Producto
CREATE OR REPLACE PROCEDURE sp_InsertarProducto(
    p_ID_Producto IN INT,
    p_Nombre IN VARCHAR,
    p_Descripcion IN VARCHAR,
    p_Precio IN DECIMAL,
    p_Stock IN INT,
    p_ID_Proveedor IN INT,
    p_ID_Categoria IN INT
) AS
BEGIN
    INSERT INTO Productos (ID_Producto, Nombre, Descripcion, Precio, Stock, ID_Proveedor, ID_Categoria)
    VALUES (p_ID_Producto, p_Nombre, p_Descripcion, p_Precio, p_Stock, p_ID_Proveedor, p_ID_Categoria);
    COMMIT;
END;
/

-- 2. Actualizar Producto
CREATE OR REPLACE PROCEDURE sp_ActualizarProducto(
    p_ID_Producto IN INT,
    p_Nombre IN VARCHAR,
    p_Descripcion IN VARCHAR,
    p_Precio IN DECIMAL,
    p_Stock IN INT
) AS
BEGIN
    UPDATE Productos
    SET Nombre = p_Nombre, Descripcion = p_Descripcion, Precio = p_Precio, Stock = p_Stock
    WHERE ID_Producto = p_ID_Producto;
    COMMIT;
END;
/


-- 3. Eliminar Producto
CREATE OR REPLACE PROCEDURE sp_EliminarProducto(
    p_ID_Producto IN INT
) AS
BEGIN
    DELETE FROM Productos WHERE ID_Producto = p_ID_Producto;
    COMMIT;
END;
/

-- 4. Registrar Venta
CREATE OR REPLACE PROCEDURE sp_RegistrarVenta(
    p_ID_Venta IN INT,
    p_ID_Cliente IN INT,
    p_ID_Empleado IN INT,
    p_Fecha_Venta IN DATE
) AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Ventas
    WHERE ID_Venta = p_ID_Venta;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El ID de la venta ya existe');
    ELSE
        INSERT INTO Ventas (ID_Venta, ID_Cliente, ID_Empleado, Fecha_Venta, Total)
        VALUES (p_ID_Venta, p_ID_Cliente, p_ID_Empleado, p_Fecha_Venta, 0);
    END IF;

    COMMIT;
END;
/

-- 5. Agregar Detalle Venta
CREATE OR REPLACE PROCEDURE sp_AgregarDetalleVenta(
    p_ID_Venta IN NUMBER,
    p_ID_Producto IN NUMBER,
    p_Cantidad IN NUMBER,
    p_Descuento IN NUMBER DEFAULT 0
) AS
    v_Precio_Unitario NUMBER(10,2);
    v_Prox_ID_Detalle NUMBER;
    v_Stock_Actual NUMBER;
BEGIN
    -- 1. Verificar que el producto existe y obtener precio
    BEGIN
        SELECT Precio, Stock INTO v_Precio_Unitario, v_Stock_Actual
        FROM Productos 
        WHERE ID_Producto = p_ID_Producto;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Producto no encontrado con ID: ' || p_ID_Producto);
    END;
    
    -- 2. Verificar stock disponible
    IF v_Stock_Actual < p_Cantidad THEN
        RAISE_APPLICATION_ERROR(-20003, 'Stock insuficiente. Disponible: ' || v_Stock_Actual || ', Solicitado: ' || p_Cantidad);
    END IF;
    
    -- 3. Obtener próximo ID_Detalle (secuencial por venta)
    SELECT NVL(MAX(ID_Detalle), 0) + 1 INTO v_Prox_ID_Detalle
    FROM Detalles_Venta
    WHERE ID_Venta = p_ID_Venta;
    
    -- 4. Insertar el detalle
    INSERT INTO Detalles_Venta (
        ID_Detalle, ID_Venta, ID_Producto, 
        Cantidad, Precio_Unitario, Descuento
    ) VALUES (
        v_Prox_ID_Detalle, p_ID_Venta, p_ID_Producto,
        p_Cantidad, v_Precio_Unitario, p_Descuento
    );
    
    -- 5. Actualizar stock
    UPDATE Productos
    SET Stock = Stock - p_Cantidad
    WHERE ID_Producto = p_ID_Producto;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

-- 6. Registrar Cliente
CREATE OR REPLACE PROCEDURE sp_RegistrarCliente(
    p_ID_Cliente IN INT,
    p_Nombre IN VARCHAR,
    p_Apellido IN VARCHAR,
    p_Email IN VARCHAR,
    p_Telefono IN VARCHAR,
    p_Direccion IN VARCHAR
) AS
BEGIN
    INSERT INTO Clientes (ID_Cliente, Nombre, Apellido, Email, Telefono, Direccion)
    VALUES (p_ID_Cliente, p_Nombre, p_Apellido, p_Email, p_Telefono, p_Direccion);
    COMMIT;
END;
/

-- 7. Actualizar Cliente
CREATE OR REPLACE PROCEDURE sp_ActualizarCliente(
    p_ID_Cliente IN INT,
    p_Nombre IN VARCHAR,
    p_Apellido IN VARCHAR,
    p_Email IN VARCHAR,
    p_Telefono IN VARCHAR,
    p_Direccion IN VARCHAR
) AS
BEGIN
    UPDATE Clientes
    SET Nombre = p_Nombre, Apellido = p_Apellido, Email = p_Email, Telefono = p_Telefono, Direccion = p_Direccion
    WHERE ID_Cliente = p_ID_Cliente;
    COMMIT;
END;
/

-- 8. Registrar Proveedor
CREATE OR REPLACE PROCEDURE sp_RegistrarProveedor(
    p_ID_Proveedor IN INT,
    p_Nombre IN VARCHAR,
    p_Contacto IN VARCHAR,
    p_Telefono IN VARCHAR,
    p_Direccion IN VARCHAR,
    p_Email IN VARCHAR
) AS
BEGIN
    INSERT INTO Proveedores (ID_Proveedor, Nombre, Contacto, Telefono, Direccion, Email)
    VALUES (p_ID_Proveedor, p_Nombre, p_Contacto, p_Telefono, p_Direccion, p_Email);
    COMMIT;
END;
/

-- 9. Actualizar Stock
CREATE OR REPLACE PROCEDURE sp_ActualizarStock(
    p_ID_Producto IN INT,
    p_Cantidad IN INT
) AS
BEGIN
    UPDATE Productos
    SET Stock = Stock + p_Cantidad
    WHERE ID_Producto = p_ID_Producto;
    COMMIT;
END;
/

-- 10. Crear Categoria
CREATE OR REPLACE PROCEDURE sp_CrearCategoria(
    p_ID_Categoria IN INT,
    p_Nombre IN VARCHAR,
    p_Descripcion IN VARCHAR
) AS
BEGIN
    INSERT INTO Categorias (ID_Categoria, Nombre, Descripcion)
    VALUES (p_ID_Categoria, p_Nombre, p_Descripcion);
    COMMIT;
END;
/

-- 11. Contar Productos por Categoria
CREATE OR REPLACE PROCEDURE sp_ContarProductosPorCategoria(
    p_ID_Categoria IN INT,
    p_Conteo OUT INT
) AS
BEGIN
    SELECT COUNT(*) INTO p_Conteo 
    FROM Productos 
    WHERE ID_Categoria = p_ID_Categoria;
END;
/

-- 12. Obtener Ventas del Dia
CREATE OR REPLACE PROCEDURE sp_ObtenerVentasDelDia(
    p_Fecha IN DATE,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR 
    SELECT v.ID_Venta, c.Nombre || ' ' || c.Apellido AS Cliente, v.Total
    FROM Ventas v
    JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente
    WHERE TRUNC(v.Fecha_Venta) = TRUNC(p_Fecha);
END;
/

-- 13. Actualizar Precio Producto
CREATE OR REPLACE PROCEDURE sp_ActualizarPrecioProducto(
    p_ID_Producto IN INT,
    p_Precio_Nuevo IN DECIMAL
) AS
BEGIN
    UPDATE Productos
    SET Precio = p_Precio_Nuevo
    WHERE ID_Producto = p_ID_Producto;
    COMMIT;
END;
/

-- 14. Obtener Productos con Stock Bajo
CREATE OR REPLACE PROCEDURE sp_ObtenerProductosStockBajo(
    p_Umbral IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR 
    SELECT p.ID_Producto, p.Nombre, p.Stock, pr.Nombre AS Proveedor
    FROM Productos p
    JOIN Proveedores pr ON p.ID_Proveedor = pr.ID_Proveedor
    WHERE p.Stock < p_Umbral
    ORDER BY p.Stock ASC;
END;
/

-- 15. Calcular Total Venta
CREATE OR REPLACE PROCEDURE sp_CalcularTotalVenta(
    p_ID_Venta IN INT,
    p_Total OUT DECIMAL
) AS
BEGIN
    SELECT SUM(Cantidad * Precio_Unitario * (1 - NVL(Descuento, 0)/100)) 
    INTO p_Total
    FROM Detalles_Venta
    WHERE ID_Venta = p_ID_Venta;
    
    UPDATE Ventas SET Total = p_Total WHERE ID_Venta = p_ID_Venta;
    COMMIT;
END;
/

-- 16. Obtener Top Clientes
CREATE OR REPLACE PROCEDURE sp_ObtenerTopClientes(
    p_Limite IN INT,
    p_Periodo IN INT, -- meses atrás
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT c.ID_Cliente, c.Nombre || ' ' || c.Apellido AS Cliente,
           COUNT(v.ID_Venta) AS Num_Ventas, SUM(v.Total) AS Total_Comprado
    FROM Clientes c
    JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
    WHERE v.Fecha_Venta >= ADD_MONTHS(SYSDATE, -p_Periodo)
    GROUP BY c.ID_Cliente, c.Nombre, c.Apellido
    ORDER BY Total_Comprado DESC
    FETCH FIRST p_Limite ROWS ONLY;
END;
/

-- 17. Buscar Productos por Nombre
CREATE OR REPLACE PROCEDURE sp_BuscarProductosPorNombre(
    p_Busqueda IN VARCHAR,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT p.ID_Producto, p.Nombre, p.Descripcion, p.Precio, p.Stock, 
           c.Nombre AS Categoria, pr.Nombre AS Proveedor
    FROM Productos p
    JOIN Categorias c ON p.ID_Categoria = c.ID_Categoria
    JOIN Proveedores pr ON p.ID_Proveedor = pr.ID_Proveedor
    WHERE UPPER(p.Nombre) LIKE '%' || UPPER(p_Busqueda) || '%'
    ORDER BY p.Nombre;
END;
/

-- 18. Obtener Detalle Venta
CREATE OR REPLACE PROCEDURE sp_ObtenerDetalleVenta(
    p_ID_Venta IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT d.ID_Detalle, p.Nombre AS Producto, d.Cantidad, 
           d.Precio_Unitario, d.Descuento,
           (d.Cantidad * d.Precio_Unitario * (1 - NVL(d.Descuento,0)/100)) AS Subtotal
    FROM Detalles_Venta d
    JOIN Productos p ON d.ID_Producto = p.ID_Producto
    WHERE d.ID_Venta = p_ID_Venta
    ORDER BY d.ID_Detalle;
END;
/

-- 19. Registrar Empleado
CREATE OR REPLACE PROCEDURE sp_RegistrarEmpleado(
    p_ID_Empleado IN INT,
    p_Nombre IN VARCHAR,
    p_Apellido IN VARCHAR,
    p_Cargo IN VARCHAR,
    p_Salario IN DECIMAL,
    p_Departamento IN VARCHAR
) AS
BEGIN
    INSERT INTO Empleados (ID_Empleado, Nombre, Apellido, Cargo, Salario, Departamento, Fecha_Contratacion)
    VALUES (p_ID_Empleado, p_Nombre, p_Apellido, p_Cargo, p_Salario, p_Departamento, SYSDATE);
    COMMIT;
END;
/

-- 20. Obtener Ventas por Rango de Fechas
CREATE OR REPLACE PROCEDURE sp_ObtenerVentasPorRangoFechas(
    p_Fecha_Inicio IN DATE,
    p_Fecha_Fin IN DATE,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT v.ID_Venta, v.Fecha_Venta, 
           c.Nombre || ' ' || c.Apellido AS Cliente,
           e.Nombre || ' ' || e.Apellido AS Empleado,
           v.Total
    FROM Ventas v
    JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente
    LEFT JOIN Empleados e ON v.ID_Empleado = e.ID_Empleado
    WHERE v.Fecha_Venta BETWEEN p_Fecha_Inicio AND p_Fecha_Fin
    ORDER BY v.Fecha_Venta DESC;
END;
/

-- 21. Calcular Promedio Venta Mensual
CREATE OR REPLACE PROCEDURE sp_CalcularPromedioVentaMensual(
    p_Anio IN NUMBER,
    p_Promedio OUT DECIMAL
) AS
BEGIN
    SELECT AVG(Total) INTO p_Promedio
    FROM (
        SELECT TO_CHAR(Fecha_Venta, 'MM') AS Mes, SUM(Total) AS Total
        FROM Ventas
        WHERE EXTRACT(YEAR FROM Fecha_Venta) = p_Anio
        GROUP BY TO_CHAR(Fecha_Venta, 'MM')
    );
END;
/

-- 22. Obtener Productos Mas Vendidos
CREATE OR REPLACE PROCEDURE sp_ObtenerProductosMasVendidos(
    p_Limite IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT p.ID_Producto, p.Nombre, SUM(d.Cantidad) AS Total_Vendido
    FROM Detalles_Venta d
    JOIN Productos p ON d.ID_Producto = p.ID_Producto
    GROUP BY p.ID_Producto, p.Nombre
    ORDER BY Total_Vendido DESC
    FETCH FIRST p_Limite ROWS ONLY;
END;
/

-- 23. Marcar Venta ComoAnulada
CREATE OR REPLACE PROCEDURE sp_MarcarVentaComoAnulada(
    p_ID_Venta IN INT
) AS
BEGIN
    UPDATE Ventas
    SET Estado = 'ANULADA'
    WHERE ID_Venta = p_ID_Venta;
    COMMIT;
END;
/

-- 24. Obtener ReporteInventario
CREATE OR REPLACE PROCEDURE sp_ObtenerReporteInventario(
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR
    SELECT p.ID_Producto, p.Nombre, p.Precio, p.Stock,
           pr.Nombre AS Proveedor, c.Nombre AS Categoria,
           CASE 
               WHEN p.Stock < 5 THEN 'CRÍTICO'
               WHEN p.Stock < 10 THEN 'BAJO'
               ELSE 'NORMAL'
           END AS Estado_Stock
    FROM Productos p
    JOIN Proveedores pr ON p.ID_Proveedor = pr.ID_Proveedor
    JOIN Categorias c ON p.ID_Categoria = c.ID_Categoria
    ORDER BY p.Stock ASC;
END;
/

-- 25. Transferir Stock
CREATE OR REPLACE PROCEDURE sp_TransferirStock(
    p_ID_Producto_Origen IN INT,
    p_ID_Producto_Destino IN INT,
    p_Cantidad IN INT
) AS
    v_Stock_Actual INT;
BEGIN
    -- Verificar stock disponible
    SELECT Stock INTO v_Stock_Actual FROM Productos WHERE ID_Producto = p_ID_Producto_Origen;
    
    IF v_Stock_Actual >= p_Cantidad THEN
        -- Reducir stock origen
        UPDATE Productos SET Stock = Stock - p_Cantidad WHERE ID_Producto = p_ID_Producto_Origen;
        
        -- Aumentar stock destino
        UPDATE Productos SET Stock = Stock + p_Cantidad WHERE ID_Producto = p_ID_Producto_Destino;
        
        COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para realizar la transferencia');
    END IF;
END;
/