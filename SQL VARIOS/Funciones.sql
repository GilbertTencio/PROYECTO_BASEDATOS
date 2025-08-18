-- 1. Función para calcular el valor total del inventario
CREATE OR REPLACE FUNCTION fn_TotalValorInventario 
RETURN DECIMAL
AS
    v_Total DECIMAL(15,2);
BEGIN
    SELECT SUM(Stock * Precio) INTO v_Total
    FROM Productos;
    
    RETURN v_Total;
END;
/

-- 2. Función para obtener el nombre completo del cliente
CREATE OR REPLACE FUNCTION fn_NombreCompletoCliente(
    p_ID_Cliente IN INT
) RETURN VARCHAR2
AS
    v_Nombre_Completo VARCHAR2(200);
BEGIN
    SELECT Nombre || ' ' || Apellido INTO v_Nombre_Completo
    FROM Clientes
    WHERE ID_Cliente = p_ID_Cliente;
    
    RETURN v_Nombre_Completo;
END;
/

-- 3. Función para calcular el descuento por fidelidad
CREATE OR REPLACE FUNCTION fn_DescuentoFidelidad(
    p_ID_Cliente IN INT
) RETURN DECIMAL
AS
    v_Numero_Ventas INT;
    v_Descuento DECIMAL(5,2);
BEGIN
    SELECT COUNT(*) INTO v_Numero_Ventas
    FROM Ventas
    WHERE ID_Cliente = p_ID_Cliente;
    
    IF v_Numero_Ventas > 20 THEN
        v_Descuento := 15;
    ELSIF v_Numero_Ventas > 10 THEN
        v_Descuento := 10;
    ELSIF v_Numero_Ventas > 5 THEN
        v_Descuento := 5;
    ELSE
        v_Descuento := 0;
    END IF;
    
    RETURN v_Descuento;
END;
/

-- 4. Función para verificar disponibilidad de producto
CREATE OR REPLACE FUNCTION fn_VerificarDisponibilidad(
    p_ID_Producto IN INT,
    p_Cantidad IN INT
) RETURN VARCHAR2
AS
    v_Stock INT;
    v_Resultado VARCHAR2(50);
BEGIN
    SELECT Stock INTO v_Stock
    FROM Productos
    WHERE ID_Producto = p_ID_Producto;
    
    IF v_Stock >= p_Cantidad THEN
        v_Resultado := 'DISPONIBLE';
    ELSIF v_Stock > 0 THEN
        v_Resultado := 'STOCK_INSUFICIENTE';
    ELSE
        v_Resultado := 'AGOTADO';
    END IF;
    
    RETURN v_Resultado;
END;
/

-- 5. Función para calcular días desde última compra
CREATE OR REPLACE FUNCTION fn_DiasDesdeUltimaCompra(
    p_ID_Cliente IN INT
) RETURN INT
AS
    v_Ultima_Compra DATE;
    v_Dias INT;
BEGIN
    SELECT MAX(Fecha_Venta) INTO v_Ultima_Compra
    FROM Ventas
    WHERE ID_Cliente = p_ID_Cliente;
    
    IF v_Ultima_Compra IS NULL THEN
        v_Dias := -1; -- Nunca ha comprado
    ELSE
        v_Dias := TRUNC(SYSDATE) - TRUNC(v_Ultima_Compra);
    END IF;
    
    RETURN v_Dias;
END;
/

-- 6. Función para generar código de producto
CREATE OR REPLACE FUNCTION fn_GenerarCodigoProducto(
    p_Nombre IN VARCHAR2
) RETURN VARCHAR2
AS
    v_Codigo VARCHAR2(10);
BEGIN
    v_Codigo := UPPER(SUBSTR(REPLACE(p_Nombre, ' ', ''), 1, 3)) || 
                TO_CHAR(SYSDATE, 'DD') ||
                DBMS_RANDOM.STRING('X', 3);
    
    RETURN v_Codigo;
END;
/

-- 7. Función para calcular comisión de empleado
CREATE OR REPLACE FUNCTION fn_CalcularComision(
    p_ID_Empleado IN INT,
    p_Mes IN INT,
    p_Anio IN INT
) RETURN DECIMAL
AS
    v_Total_Ventas DECIMAL(15,2);
    v_Comision DECIMAL(15,2);
BEGIN
    SELECT SUM(Total) INTO v_Total_Ventas
    FROM Ventas
    WHERE ID_Empleado = p_ID_Empleado
    AND EXTRACT(MONTH FROM Fecha_Venta) = p_Mes
    AND EXTRACT(YEAR FROM Fecha_Venta) = p_Anio;
    
    IF v_Total_Ventas > 10000 THEN
        v_Comision := v_Total_Ventas * 0.1;
    ELSIF v_Total_Ventas > 5000 THEN
        v_Comision := v_Total_Ventas * 0.07;
    ELSIF v_Total_Ventas > 1000 THEN
        v_Comision := v_Total_Ventas * 0.05;
    ELSE
        v_Comision := 0;
    END IF;
    
    RETURN v_Comision;
END;
/

-- 8. Función para formatear fecha con estilo
CREATE OR REPLACE FUNCTION fn_FormatearFecha(
    p_Fecha IN DATE
) RETURN VARCHAR2
AS
BEGIN
    RETURN TO_CHAR(p_Fecha, 'DD "de" Month "de" YYYY, HH24:MI');
END;
/

-- 9. Función para validar email
CREATE OR REPLACE FUNCTION fn_ValidarEmail(
    p_Email IN VARCHAR2
) RETURN BOOLEAN
AS
    v_Regex VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
    RETURN REGEXP_LIKE(p_Email, v_Regex);
END;
/

-- 10. Función para obtener productos relacionados
CREATE OR REPLACE FUNCTION fn_ObtenerProductosRelacionados(
    p_ID_Producto IN INT
) RETURN SYS_REFCURSOR
AS
    v_Resultado SYS_REFCURSOR;
    v_ID_Categoria INT;
BEGIN
    -- Obtener categoría del producto
    SELECT ID_Categoria INTO v_ID_Categoria
    FROM Productos
    WHERE ID_Producto = p_ID_Producto;
    
    -- Abrir cursor con productos de la misma categoría
    OPEN v_Resultado FOR
    SELECT ID_Producto, Nombre, Precio
    FROM Productos
    WHERE ID_Categoria = v_ID_Categoria
    AND ID_Producto != p_ID_Producto
    FETCH FIRST 5 ROWS ONLY;
    
    RETURN v_Resultado;
END;
/

-- 11. Función para calcular edad del cliente
CREATE OR REPLACE FUNCTION fn_CalcularEdadCliente(
    p_ID_Cliente IN INT
) RETURN INT
AS
    v_Fecha_Nacimiento DATE;
    v_Edad INT;
BEGIN
    -- Asumiendo que hay una columna Fecha_Nacimiento en Clientes
    SELECT Fecha_Nacimiento INTO v_Fecha_Nacimiento
    FROM Clientes
    WHERE ID_Cliente = p_ID_Cliente;
    
    v_Edad := TRUNC(MONTHS_BETWEEN(SYSDATE, v_Fecha_Nacimiento)/12);
    
    RETURN v_Edad;
END;
/

-- 12. Función para calcular impuesto de venta
CREATE OR REPLACE FUNCTION fn_CalcularImpuesto(
    p_Valor IN DECIMAL,
    p_ID_Producto IN INT DEFAULT NULL
) RETURN DECIMAL
AS
    v_Tipo_Producto VARCHAR2(20) := 'GENERAL';
    v_Impuesto DECIMAL(5,2);
BEGIN
    -- Determinar tipo de producto si se proporciona ID
    IF p_ID_Producto IS NOT NULL THEN
        SELECT 
            CASE 
                WHEN p.ID_Categoria IN (1, 2) THEN 'ALIMENTO'
                WHEN p.ID_Categoria IN (3, 4) THEN 'MEDICINA'
                ELSE 'GENERAL'
            END INTO v_Tipo_Producto
        FROM Productos p
        WHERE p.ID_Producto = p_ID_Producto;
    END IF;
    
    -- Aplicar impuesto según tipo
    CASE v_Tipo_Producto
        WHEN 'ALIMENTO' THEN v_Impuesto := p_Valor * 0.05;
        WHEN 'MEDICINA' THEN v_Impuesto := p_Valor * 0;
        ELSE v_Impuesto := p_Valor * 0.19;
    END CASE;
    
    RETURN v_Impuesto;
END;
/

-- 13. Función para generar factura en texto
CREATE OR REPLACE FUNCTION fn_GenerarFacturaTexto(
    p_ID_Venta IN INT
) RETURN CLOB
AS
    v_Cliente VARCHAR2(200);
    v_Fecha DATE;
    v_Total DECIMAL(15,2);
    v_Factura CLOB;
    v_Cursor SYS_REFCURSOR;
    v_Nombre_Producto VARCHAR2(100);
    v_Cantidad INT;
    v_Precio_Unitario DECIMAL(10,2);
    v_Subtotal DECIMAL(15,2);
BEGIN
    -- Obtener datos generales de la venta
    SELECT 
        c.Nombre || ' ' || c.Apellido,
        v.Fecha_Venta,
        v.Total
    INTO v_Cliente, v_Fecha, v_Total
    FROM Ventas v
    JOIN Clientes c ON v.ID_Cliente = c.ID_Cliente
    WHERE v.ID_Venta = p_ID_Venta;
    
    -- Crear encabezado de la factura
    v_Factura := 'FACTURA #' || p_ID_Venta || CHR(10) ||
                 'Cliente: ' || v_Cliente || CHR(10) ||
                 'Fecha: ' || TO_CHAR(v_Fecha, 'DD/MM/YYYY HH24:MI') || CHR(10) ||
                 '----------------------------------------' || CHR(10) ||
                 'PRODUCTO                         CANT   PRECIO   SUBTOTAL' || CHR(10);
    
    -- Obtener detalles de la venta
    OPEN v_Cursor FOR
    SELECT 
        p.Nombre, 
        dv.Cantidad, 
        dv.Precio_Unitario,
        dv.Cantidad * dv.Precio_Unitario AS Subtotal
    FROM Detalles_Venta dv
    JOIN Productos p ON dv.ID_Producto = p.ID_Producto
    WHERE dv.ID_Venta = p_ID_Venta;
    
    -- Agregar cada producto al CLOB
    LOOP
        FETCH v_Cursor INTO v_Nombre_Producto, v_Cantidad, v_Precio_Unitario, v_Subtotal;
        EXIT WHEN v_Cursor%NOTFOUND;
        
        v_Factura := v_Factura || 
                     RPAD(SUBSTR(v_Nombre_Producto, 1, 30), 30) || ' ' ||
                     LPAD(v_Cantidad, 5) || ' ' ||
                     LPAD(TO_CHAR(v_Precio_Unitario, '999,990.00'), 10) || ' ' ||
                     LPAD(TO_CHAR(v_Subtotal, '999,990.00'), 10) || CHR(10);
    END LOOP;
    CLOSE v_Cursor;
    
    -- Agregar total
    v_Factura := v_Factura || '----------------------------------------' || CHR(10) ||
                 'TOTAL: ' || TO_CHAR(v_Total, '999,990.00') || CHR(10);
    
    RETURN v_Factura;
END;
/

-- 14. Función para calcular valorización de inventario
CREATE OR REPLACE FUNCTION fn_ValorizacionInventario(
    p_ID_Categoria IN INT DEFAULT NULL
) RETURN DECIMAL
AS
    v_Total DECIMAL(15,2);
BEGIN
    IF p_ID_Categoria IS NULL THEN
        SELECT SUM(Stock * Precio) INTO v_Total
        FROM Productos;
    ELSE
        SELECT SUM(Stock * Precio) INTO v_Total
        FROM Productos
        WHERE ID_Categoria = p_ID_Categoria;
    END IF;
    
    RETURN v_Total;
END;
/

-- 15. Función para verificar credenciales
CREATE OR REPLACE FUNCTION fn_VerificarCredenciales(
    p_Usuario IN VARCHAR2,
    p_Contrasena IN VARCHAR2
) RETURN BOOLEAN
AS
    v_Contador INT;
BEGIN
    -- Esta es una versión básica, en producción usaría hash y sal
    SELECT COUNT(*) INTO v_Contador
    FROM Empleados
    WHERE UPPER(Nombre) = UPPER(p_Usuario)
    AND CONTRASENA = p_Contrasena;
    
    RETURN v_Contador > 0;
END;
/