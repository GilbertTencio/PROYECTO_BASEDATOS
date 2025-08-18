--------------------------------------------------------
--  File created - Monday-August-18-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_DETALLE_VENTA
--------------------------------------------------------

   CREATE SEQUENCE  "PROYECTO_DB"."SEQ_DETALLE_VENTA"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 7 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence SEQ_VENTAS
--------------------------------------------------------

   CREATE SEQUENCE  "PROYECTO_DB"."SEQ_VENTAS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table AUDITORIA_PRODUCTOS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."AUDITORIA_PRODUCTOS" 
   (	"ID_AUDITORIA" NUMBER(*,0), 
	"ID_PRODUCTO" NUMBER(*,0), 
	"ACCION" VARCHAR2(10 BYTE), 
	"PRECIO_ANTERIOR" NUMBER(10,2), 
	"PRECIO_NUEVO" NUMBER(10,2), 
	"USUARIO" VARCHAR2(50 BYTE), 
	"FECHA_CAMBIO" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CATEGORIAS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."CATEGORIAS" 
   (	"ID_CATEGORIA" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"DESCRIPCION" VARCHAR2(255 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CLIENTES
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."CLIENTES" 
   (	"ID_CLIENTE" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"APELLIDO" VARCHAR2(100 BYTE), 
	"EMAIL" VARCHAR2(100 BYTE), 
	"TELEFONO" VARCHAR2(15 BYTE), 
	"FECHA_NACIMIENTO" DATE, 
	"DIRECCION" VARCHAR2(200 BYTE), 
	"FECHA_REGISTRO" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DETALLES_VENTA
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."DETALLES_VENTA" 
   (	"ID_DETALLE" NUMBER(*,0), 
	"ID_VENTA" NUMBER(*,0), 
	"ID_PRODUCTO" NUMBER(*,0), 
	"CANTIDAD" NUMBER(*,0), 
	"PRECIO_UNITARIO" NUMBER(10,2), 
	"DESCUENTO" NUMBER(5,2) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table EMPLEADOS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."EMPLEADOS" 
   (	"ID_EMPLEADO" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"APELLIDO" VARCHAR2(100 BYTE), 
	"CARGO" VARCHAR2(100 BYTE), 
	"SALARIO" NUMBER(10,2), 
	"CONTRASENA" VARCHAR2(200 BYTE), 
	"FECHA_CONTRATACION" DATE DEFAULT SYSDATE, 
	"DEPARTAMENTO" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table INVENTARIO
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."INVENTARIO" 
   (	"ID_INVENTARIO" NUMBER(*,0), 
	"ID_PRODUCTO" NUMBER(*,0), 
	"CANTIDAD_ACTUAL" NUMBER(*,0), 
	"FECHA_ULTIMA_ACTUALIZACION" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PRODUCTOS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."PRODUCTOS" 
   (	"ID_PRODUCTO" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"DESCRIPCION" VARCHAR2(255 BYTE), 
	"PRECIO" NUMBER(10,2), 
	"STOCK" NUMBER(*,0), 
	"ID_PROVEEDOR" NUMBER(*,0), 
	"ID_CATEGORIA" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PROVEEDORES
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."PROVEEDORES" 
   (	"ID_PROVEEDOR" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"CONTACTO" VARCHAR2(100 BYTE), 
	"TELEFONO" VARCHAR2(15 BYTE), 
	"EMAIL" VARCHAR2(100 BYTE), 
	"DIRECCION" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table USUARIOS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."USUARIOS" 
   (	"ID_USUARIO" NUMBER, 
	"NOMBRE" VARCHAR2(100 BYTE), 
	"CORREO" VARCHAR2(100 BYTE), 
	"TELEFONO" VARCHAR2(15 BYTE), 
	"ROL" VARCHAR2(20 BYTE), 
	"APELLIDO" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table VENTAS
--------------------------------------------------------

  CREATE TABLE "PROYECTO_DB"."VENTAS" 
   (	"ID_VENTA" NUMBER(*,0), 
	"ID_CLIENTE" NUMBER(*,0), 
	"FECHA_VENTA" DATE, 
	"TOTAL" NUMBER(10,2), 
	"ID_EMPLEADO" NUMBER(*,0), 
	"ESTADO" VARCHAR2(20 BYTE) DEFAULT 'ACTIVA'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View VW_DETALLECOMPLETOVENTAS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_DETALLECOMPLETOVENTAS" ("ID_VENTA", "FECHA_VENTA", "CLIENTE", "EMPLEADO", "TOTAL", "PRODUCTOS") AS 
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
GROUP BY v.ID_Venta, v.Fecha_Venta, c.Nombre, c.Apellido, e.Nombre, e.Apellido, v.Total
;
--------------------------------------------------------
--  DDL for View VW_HISTORIALPRECIOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_HISTORIALPRECIOS" ("ID_PRODUCTO", "NOMBRE", "PRECIO_ANTERIOR", "PRECIO_NUEVO", "DIFERENCIA", "PORCENTAJE_CAMBIO", "USUARIO", "FECHA_CAMBIO") AS 
  SELECT ap.ID_Producto, p.Nombre,
       ap.Precio_Anterior, ap.Precio_Nuevo,
       (ap.Precio_Nuevo - ap.Precio_Anterior) AS Diferencia,
       ROUND(((ap.Precio_Nuevo - ap.Precio_Anterior)/ap.Precio_Anterior)*100,2) || '%' AS Porcentaje_Cambio,
       ap.Usuario, ap.Fecha_Cambio
FROM Auditoria_Productos ap
JOIN Productos p ON ap.ID_Producto = p.ID_Producto
ORDER BY ap.Fecha_Cambio DESC
;
--------------------------------------------------------
--  DDL for View VW_PRODUCTOSPORCATEGORIA
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_PRODUCTOSPORCATEGORIA" ("ID_CATEGORIA", "CATEGORIA", "CANTIDAD_PRODUCTOS", "STOCK_TOTAL", "PRECIO_MINIMO", "PRECIO_MAXIMO", "PRECIO_PROMEDIO") AS 
  SELECT c.ID_Categoria, c.Nombre AS Categoria,
       COUNT(p.ID_Producto) AS Cantidad_Productos,
       SUM(p.Stock) AS Stock_Total,
       MIN(p.Precio) AS Precio_Minimo,
       MAX(p.Precio) AS Precio_Maximo,
       AVG(p.Precio) AS Precio_Promedio
FROM Categorias c
LEFT JOIN Productos p ON c.ID_Categoria = p.ID_Categoria
GROUP BY c.ID_Categoria, c.Nombre
ORDER BY Cantidad_Productos DESC
;
--------------------------------------------------------
--  DDL for View VW_PRODUCTOSSTOCKCRITICO
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_PRODUCTOSSTOCKCRITICO" ("ID_PRODUCTO", "NOMBRE", "STOCK", "PROVEEDOR", "CATEGORIA", "PRECIO") AS 
  SELECT p.ID_Producto, p.Nombre, p.Stock, 
       pr.Nombre AS Proveedor, c.Nombre AS Categoria,
       p.Precio
FROM Productos p
JOIN Proveedores pr ON p.ID_Proveedor = pr.ID_Proveedor
JOIN Categorias c ON p.ID_Categoria = c.ID_Categoria
WHERE p.Stock < 5
ORDER BY p.Stock ASC
;
--------------------------------------------------------
--  DDL for View VW_PROVEEDORESCONPRODUCTOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_PROVEEDORESCONPRODUCTOS" ("ID_PROVEEDOR", "NOMBRE", "CANTIDAD_PRODUCTOS", "STOCK_TOTAL", "MINIMO_STOCK", "PRECIO_MAXIMO") AS 
  SELECT pr.ID_Proveedor, pr.Nombre,
       COUNT(p.ID_Producto) AS Cantidad_Productos,
       SUM(p.Stock) AS Stock_Total,
       MIN(p.Stock) AS Minimo_Stock,
       MAX(p.Precio) AS Precio_Maximo
FROM Proveedores pr
LEFT JOIN Productos p ON pr.ID_Proveedor = p.ID_Proveedor
GROUP BY pr.ID_Proveedor, pr.Nombre
ORDER BY Cantidad_Productos DESC
;
--------------------------------------------------------
--  DDL for View VW_RENDIMIENTOEMPLEADOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_RENDIMIENTOEMPLEADOS" ("ID_EMPLEADO", "EMPLEADO", "CARGO", "VENTAS_REALIZADAS", "MONTO_TOTAL", "PROMEDIO_VENTA") AS 
  SELECT e.ID_Empleado, 
       e.Nombre || ' ' || e.Apellido AS Empleado,
       e.Cargo,
       COUNT(v.ID_Venta) AS Ventas_Realizadas,
       SUM(v.Total) AS Monto_Total,
       NVL(SUM(v.Total)/NULLIF(COUNT(v.ID_Venta),0),0) AS Promedio_Venta
FROM Empleados e
LEFT JOIN Ventas v ON e.ID_Empleado = v.ID_Empleado
GROUP BY e.ID_Empleado, e.Nombre, e.Apellido, e.Cargo
ORDER BY Monto_Total DESC
;
--------------------------------------------------------
--  DDL for View VW_RESUMENMENSUAL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_RESUMENMENSUAL" ("ANIO", "MES", "NOMBRE_MES", "NUMERO_VENTAS", "TOTAL_VENTAS", "PROMEDIO_VENTA", "MINIMA_VENTA", "MAXIMA_VENTA") AS 
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
ORDER BY Anio DESC, Mes DESC
;
--------------------------------------------------------
--  DDL for View VW_RESUMENVENTASDIARIAS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_RESUMENVENTASDIARIAS" ("FECHA", "NUMERO_VENTAS", "TOTAL_VENTAS", "PROMEDIO_VENTA") AS 
  SELECT TRUNC(Fecha_Venta) AS Fecha,
       COUNT(ID_Venta) AS Numero_Ventas,
       SUM(Total) AS Total_Ventas,
       AVG(Total) AS Promedio_Venta
FROM Ventas
GROUP BY TRUNC(Fecha_Venta)
ORDER BY Fecha DESC
;
--------------------------------------------------------
--  DDL for View VW_TOPPRODUCTOSVENDIDOS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_TOPPRODUCTOSVENDIDOS" ("ID_PRODUCTO", "NOMBRE", "TOTAL_VENDIDO", "VALOR_TOTAL") AS 
  SELECT p.ID_Producto, p.Nombre, 
       SUM(dv.Cantidad) AS Total_Vendido,
       SUM(dv.Cantidad * dv.Precio_Unitario) AS Valor_Total
FROM Productos p
JOIN Detalles_Venta dv ON p.ID_Producto = dv.ID_Producto
GROUP BY p.ID_Producto, p.Nombre
ORDER BY Total_Vendido DESC
;
--------------------------------------------------------
--  DDL for View VW_VENTASPORCLIENTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "PROYECTO_DB"."VW_VENTASPORCLIENTE" ("ID_CLIENTE", "CLIENTE", "NUMERO_VENTAS", "TOTAL_COMPRADO", "ULTIMA_COMPRA") AS 
  SELECT c.ID_Cliente, 
       c.Nombre || ' ' || c.Apellido AS Cliente,
       COUNT(v.ID_Venta) AS Numero_Ventas,
       SUM(v.Total) AS Total_Comprado,
       MAX(v.Fecha_Venta) AS Ultima_Compra
FROM Clientes c
LEFT JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente, c.Nombre, c.Apellido
ORDER BY Total_Comprado DESC
;
REM INSERTING into PROYECTO_DB.AUDITORIA_PRODUCTOS
SET DEFINE OFF;
REM INSERTING into PROYECTO_DB.CATEGORIAS
SET DEFINE OFF;
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (1,'Cerámica','Productos de cerámica artesanal');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (2,'Joyería','Joyería hecha a mano con materiales naturales');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (3,'Textiles','Ropa y accesorios de tela artesanal');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (4,'Madera','Artículos de madera tallada');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (5,'Pintura','Obras de arte pintadas a mano');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (6,'Cuero','Productos artesanales de cuero');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (7,'Metal','Esculturas y objetos de metal');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (8,'Papel','Arte en papel y origami');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (9,'Vidrio','Productos de vidrio soplado');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (10,'Velas','Velas decorativas artesanales');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (11,'Bisutería','Accesorios de moda artesanales');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (12,'Decohogar','Decoración para el hogar');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (13,'Instrumentos Musicales','Instrumentos musicales artesanales');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (14,'Juguetes','Juguetes artesanales educativos');
Insert into PROYECTO_DB.CATEGORIAS (ID_CATEGORIA,NOMBRE,DESCRIPCION) values (15,'Navidad','Adornos y decoraciones navideñas');
REM INSERTING into PROYECTO_DB.CLIENTES
SET DEFINE OFF;
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (1,'CarlosA','Sánchez','carlos.sanchez@example.com','555-1111',to_date('15-MAY-85','DD-MON-RR'),'Calle 1, Ciudad',to_date('16-AUG-25','DD-MON-RR'));
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (2,'María','López','maria.lopez@example.com','555-2222',to_date('20-AUG-90','DD-MON-RR'),'Calle 2, Ciudad',to_date('16-AUG-25','DD-MON-RR'));
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (3,'José','García','jose.garcia@example.com','555-3333',to_date('30-DEC-88','DD-MON-RR'),'Calle 3, Ciudad',to_date('16-AUG-25','DD-MON-RR'));
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (4,'Laura','Martínez','laura.martinez@example.com','555-4444',to_date('10-MAR-95','DD-MON-RR'),'Calle 4, Ciudad',to_date('16-AUG-25','DD-MON-RR'));
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (5,'Pedro','Hernández','pedro.hernandez@example.com','555-5555',to_date('25-JUL-82','DD-MON-RR'),'Calle 5, Ciudad',to_date('16-AUG-25','DD-MON-RR'));
Insert into PROYECTO_DB.CLIENTES (ID_CLIENTE,NOMBRE,APELLIDO,EMAIL,TELEFONO,FECHA_NACIMIENTO,DIRECCION,FECHA_REGISTRO) values (6,'Gilbert','Tencio','josuetenciocampo@gmail.com','12389178312',null,'asdawdaw',null);
REM INSERTING into PROYECTO_DB.DETALLES_VENTA
SET DEFINE OFF;
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (3,10,11,1,23,0);
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (4,10,11,1,23,0);
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (5,10,11,1,23,0);
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (1,1,1,2,15,0);
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (2,1,3,1,20,0);
Insert into PROYECTO_DB.DETALLES_VENTA (ID_DETALLE,ID_VENTA,ID_PRODUCTO,CANTIDAD,PRECIO_UNITARIO,DESCUENTO) values (6,14,3,1,20,0);
REM INSERTING into PROYECTO_DB.EMPLEADOS
SET DEFINE OFF;
Insert into PROYECTO_DB.EMPLEADOS (ID_EMPLEADO,NOMBRE,APELLIDO,CARGO,SALARIO,CONTRASENA,FECHA_CONTRATACION,DEPARTAMENTO) values (1,'Ana','Pérez','Vendedora',1500,'contrasena123',to_date('16-AUG-25','DD-MON-RR'),'Ventas');
Insert into PROYECTO_DB.EMPLEADOS (ID_EMPLEADO,NOMBRE,APELLIDO,CARGO,SALARIO,CONTRASENA,FECHA_CONTRATACION,DEPARTAMENTO) values (2,'Luis','Gómez','Gerente',2500,'contrasena456',to_date('16-AUG-25','DD-MON-RR'),'Administración');
Insert into PROYECTO_DB.EMPLEADOS (ID_EMPLEADO,NOMBRE,APELLIDO,CARGO,SALARIO,CONTRASENA,FECHA_CONTRATACION,DEPARTAMENTO) values (3,'Sofía','Martínez','Diseñadora',2000,'contrasena789',to_date('16-AUG-25','DD-MON-RR'),'Diseño');
REM INSERTING into PROYECTO_DB.INVENTARIO
SET DEFINE OFF;
REM INSERTING into PROYECTO_DB.PRODUCTOS
SET DEFINE OFF;
Insert into PROYECTO_DB.PRODUCTOS (ID_PRODUCTO,NOMBRE,DESCRIPCION,PRECIO,STOCK,ID_PROVEEDOR,ID_CATEGORIA) values (1,'Taza de Cerámicaaaaaaa','Taza hecha a mano con diseño único',15,48,1,1);
Insert into PROYECTO_DB.PRODUCTOS (ID_PRODUCTO,NOMBRE,DESCRIPCION,PRECIO,STOCK,ID_PROVEEDOR,ID_CATEGORIA) values (3,'Bufanda de Lana','Bufanda tejida a manoas',20,16,1,3);
Insert into PROYECTO_DB.PRODUCTOS (ID_PRODUCTO,NOMBRE,DESCRIPCION,PRECIO,STOCK,ID_PROVEEDOR,ID_CATEGORIA) values (11,'a','asd',23,5,7,11);
REM INSERTING into PROYECTO_DB.PROVEEDORES
SET DEFINE OFF;
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (1,'Artisan Supplies Co.','Juan Pérez','555-1234','contacto@artisansupplies.com','Calle Falsa 123');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (2,'Creativos Andinos','María Pérez','3002223344','info@creativosandinos.com','Carrera 10 #34-56');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (3,'Mundo Artesanal','José Ramírez','3003334455','contacto@mundoartesanal.com','Av. Principal #67-89');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (4,'Manos Mágicas','Luisa Gómez','3004445566','ventas@manosmagicas.com','Diagonal 15 #12-34');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (5,'Tierra Nativa','Ana Fernández','3005556677','info@tierranativa.com','Calle 20 #45-67');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (6,'Raíces Culturales','Pedro López','3006667788','contacto@raicesculturales.com','Carrera 5 #78-90');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (7,'Arte Original','Sofía Castro','3007778899','ventas@arteoriginal.com','Av. Central #10-20');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (8,'Saberes Ancestrales','David Suárez','3008889900','info@saberesancestrales.com','Calle 30 #33-44');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (9,'Creatividad Pura','Laura Torres','3009990011','contacto@creatividadpura.com','Carrera 15 #55-66');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (10,'Expresión Artesanal','Miguel Ángel','3101011122','ventas@expresionartesanal.com','Diagonal 25 #77-88');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (11,'Arte en Maderas','Juan Carlos','3111213141','info@arteenmaderas.com','Calle 40 #99-00');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (12,'Cerámica Virreinal','Patricia Ruiz','3121314151','ventas@ceramicavirreinal.com','Carrera 20 #11-22');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (13,'Joyas Nativas','Camilo Ortega','3131415161','contacto@joyasnativas.com','Av. Norte #33-55');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (14,'Textiles Andinos','Mariana Duque','3141516171','info@textilesandinos.com','Calle 50 #66-77');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (15,'Cuero Elegante','Ricardo Morales','3151617181','ventas@cueroelegante.com','Carrera 25 #88-99');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (16,'Metal Art','Alejandro Vargas','3161718191','contacto@metalart.com','Av. Sur #44-66');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (17,'Papel Creativo','Carolina Ríos','3171819202','info@papelcreativo.com','Diagonal 30 #12-34');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (18,'Vidrios del Sol','Fernando Castro','3181920212','ventas@vidriosdelsol.com','Calle 60 #55-77');
Insert into PROYECTO_DB.PROVEEDORES (ID_PROVEEDOR,NOMBRE,CONTACTO,TELEFONO,EMAIL,DIRECCION) values (19,'Velas Aromáticas','Diana Pérez','3192021223','info@velasaromaticas.com','Carrera 30 #33-44');
REM INSERTING into PROYECTO_DB.USUARIOS
SET DEFINE OFF;
REM INSERTING into PROYECTO_DB.VENTAS
SET DEFINE OFF;
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (6,3,to_date('16-AUG-25','DD-MON-RR'),0,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (7,1,to_date('16-AUG-25','DD-MON-RR'),0,2,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (8,1,to_date('16-AUG-25','DD-MON-RR'),0,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (1,1,to_date('16-AUG-25','DD-MON-RR'),95,1,'ANULADA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (2,2,to_date('16-AUG-25','DD-MON-RR'),25,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (3,3,to_date('16-AUG-25','DD-MON-RR'),100,2,'ANULADA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (4,4,to_date('16-AUG-25','DD-MON-RR'),20,1,'ANULADA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (5,5,to_date('16-AUG-25','DD-MON-RR'),15,3,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (11,6,to_date('18-AUG-25','DD-MON-RR'),0,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (12,6,to_date('18-AUG-25','DD-MON-RR'),0,2,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (13,1,to_date('18-AUG-25','DD-MON-RR'),0,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (14,1,to_date('18-AUG-25','DD-MON-RR'),20,1,'ACTIVA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (9,1,to_date('18-AUG-25','DD-MON-RR'),0,1,'ANULADA');
Insert into PROYECTO_DB.VENTAS (ID_VENTA,ID_CLIENTE,FECHA_VENTA,TOTAL,ID_EMPLEADO,ESTADO) values (10,6,to_date('18-AUG-25','DD-MON-RR'),69,1,'ACTIVA');
--------------------------------------------------------
--  DDL for Trigger ACTUALIZAR_STOCK_AL_INSERTAR_DETALLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROYECTO_DB"."ACTUALIZAR_STOCK_AL_INSERTAR_DETALLE" 
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET Stock = Stock - :NEW.Cantidad
    WHERE ID_Producto = :NEW.ID_Producto;
END;

/
ALTER TRIGGER "PROYECTO_DB"."ACTUALIZAR_STOCK_AL_INSERTAR_DETALLE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger AUDITAR_CAMBIOS_EN_PRODUCTOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROYECTO_DB"."AUDITAR_CAMBIOS_EN_PRODUCTOS" 
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    -- Aquí puedes agregar la lógica para auditar cambios
    DBMS_OUTPUT.PUT_LINE('Producto actualizado: ' || :NEW.Nombre);
END;

/
ALTER TRIGGER "PROYECTO_DB"."AUDITAR_CAMBIOS_EN_PRODUCTOS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CALCULAR_TOTAL_VENTA_AL_INSERTAR_DETALLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROYECTO_DB"."CALCULAR_TOTAL_VENTA_AL_INSERTAR_DETALLE" 
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
BEGIN
    UPDATE Ventas
    SET Total = Total + (:NEW.Cantidad * :NEW.Precio_Unitario)
    WHERE ID_Venta = :NEW.ID_Venta;
END;

/
ALTER TRIGGER "PROYECTO_DB"."CALCULAR_TOTAL_VENTA_AL_INSERTAR_DETALLE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger NOTIFICAR_PROVEEDOR_CUANDO_STOCK_BAJO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROYECTO_DB"."NOTIFICAR_PROVEEDOR_CUANDO_STOCK_BAJO" 
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF :NEW.Stock < 5 THEN
        -- Aquí puedes agregar la lógica para notificar al proveedor
        DBMS_OUTPUT.PUT_LINE('Stock bajo para el producto: ' || :NEW.Nombre);
    END IF;
END;

/
ALTER TRIGGER "PROYECTO_DB"."NOTIFICAR_PROVEEDOR_CUANDO_STOCK_BAJO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger REGISTRAR_FECHA_ULTIMA_ACTUALIZACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROYECTO_DB"."REGISTRAR_FECHA_ULTIMA_ACTUALIZACION" 
BEFORE UPDATE ON Inventario
FOR EACH ROW
BEGIN
    :NEW.Fecha_Ultima_Actualizacion := SYSDATE;
END;

/
ALTER TRIGGER "PROYECTO_DB"."REGISTRAR_FECHA_ULTIMA_ACTUALIZACION" ENABLE;
--------------------------------------------------------
--  DDL for Procedure SP_ACTUALIZARCLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_ACTUALIZARCLIENTE" (
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
--------------------------------------------------------
--  DDL for Procedure SP_ACTUALIZARPRECIOPRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_ACTUALIZARPRECIOPRODUCTO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_ACTUALIZARPRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_ACTUALIZARPRODUCTO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_ACTUALIZARSTOCK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_ACTUALIZARSTOCK" (
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
--------------------------------------------------------
--  DDL for Procedure SP_AGREGARDETALLEVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_AGREGARDETALLEVENTA" (
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
    SELECT seq_detalle_venta.NEXTVAL INTO v_Prox_ID_Detalle FROM dual;

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
--------------------------------------------------------
--  DDL for Procedure SP_BUSCARPRODUCTOSPORNOMBRE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_BUSCARPRODUCTOSPORNOMBRE" (
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
--------------------------------------------------------
--  DDL for Procedure SP_CALCULARPROMEDIOVENTAMENSUAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_CALCULARPROMEDIOVENTAMENSUAL" (
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
--------------------------------------------------------
--  DDL for Procedure SP_CALCULARTOTALVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_CALCULARTOTALVENTA" (
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
--------------------------------------------------------
--  DDL for Procedure SP_CONTARPRODUCTOSPORCATEGORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_CONTARPRODUCTOSPORCATEGORIA" (
    p_ID_Categoria IN INT,
    p_Conteo OUT INT
) AS
BEGIN
    SELECT COUNT(*) INTO p_Conteo 
    FROM Productos 
    WHERE ID_Categoria = p_ID_Categoria;
END;

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
--------------------------------------------------------
--  DDL for Procedure SP_CREARCATEGORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_CREARCATEGORIA" (
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
--------------------------------------------------------
--  DDL for Procedure SP_ELIMINARPRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_ELIMINARPRODUCTO" (
    p_ID_Producto IN INT
) AS
BEGIN
    DELETE FROM Productos WHERE ID_Producto = p_ID_Producto;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_INSERTARPRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_INSERTARPRODUCTO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_MARCARVENTACOMOANULADA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_MARCARVENTACOMOANULADA" (
    p_ID_Venta IN INT
) AS
BEGIN
    UPDATE Ventas
    SET Estado = 'ANULADA'
    WHERE ID_Venta = p_ID_Venta;
    COMMIT;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERDETALLEVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERDETALLEVENTA" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERPRODUCTOSMASVENDIDOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERPRODUCTOSMASVENDIDOS" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERPRODUCTOSSTOCKBAJO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERPRODUCTOSSTOCKBAJO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERREPORTEINVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERREPORTEINVENTARIO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERTOPCLIENTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERTOPCLIENTES" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERVENTASDELDIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERVENTASDELDIA" (
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
--------------------------------------------------------
--  DDL for Procedure SP_OBTENERVENTASPORRANGOFECHAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_OBTENERVENTASPORRANGOFECHAS" (
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
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_AUDITORIA_PRODUCTOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_AUDITORIA_PRODUCTOS" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Auditoria_Productos;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_CATEGORIAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_CATEGORIAS" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Categorias;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_CLIENTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_CLIENTES" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Clientes;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_CLIENTES_FRECUENTES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_CLIENTES_FRECUENTES" (
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
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_DETALLES_VENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_DETALLES_VENTA" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Detalles_Venta;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_EMPLEADOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_EMPLEADOS" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Empleados;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_INVENTARIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_INVENTARIO" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Inventario;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_PRODUCTOS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_PRODUCTOS" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_PRODUCTOS_POR_CATEGORIA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_PRODUCTOS_POR_CATEGORIA" (
    p_ID_Categoria IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos WHERE ID_Categoria = p_ID_Categoria;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_PRODUCTOS_STOCK_BAJO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_PRODUCTOS_STOCK_BAJO" (
    p_Umbral IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Productos WHERE Stock < p_Umbral;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_PROVEEDORES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_PROVEEDORES" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Proveedores;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_VENTAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_VENTAS" (
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_VENTAS_POR_EMPLEADO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_VENTAS_POR_EMPLEADO" (
    p_ID_Empleado IN INT,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas WHERE ID_Empleado = p_ID_Empleado;
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_VENTAS_POR_FECHA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_VENTAS_POR_FECHA" (
    p_Fecha IN DATE,
    p_Cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_Cursor FOR SELECT * FROM Ventas WHERE TRUNC(Fecha_Venta) = TRUNC(p_Fecha);
END;

/
--------------------------------------------------------
--  DDL for Procedure SP_RECORRER_VENTAS_TOTALES_POR_PRODUCTO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_RECORRER_VENTAS_TOTALES_POR_PRODUCTO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_REGISTRARCLIENTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_REGISTRARCLIENTE" (
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
--------------------------------------------------------
--  DDL for Procedure SP_REGISTRAREMPLEADO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_REGISTRAREMPLEADO" (
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
--------------------------------------------------------
--  DDL for Procedure SP_REGISTRARPROVEEDOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_REGISTRARPROVEEDOR" (
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
--------------------------------------------------------
--  DDL for Procedure SP_REGISTRARVENTA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_REGISTRARVENTA" (
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
--------------------------------------------------------
--  DDL for Procedure SP_TRANSFERIRSTOCK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROYECTO_DB"."SP_TRANSFERIRSTOCK" (
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
--------------------------------------------------------
--  DDL for Package PKG_AUDITORIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_AUDITORIA" AS
    PROCEDURE Registrar_Auditoria(
        p_ID_Producto IN INT,
        p_Accion IN VARCHAR,
        p_Precio_Anterior IN DECIMAL,
        p_Precio_Nuevo IN DECIMAL,
        p_Usuario IN VARCHAR
    );

    FUNCTION Obtener_Historial_Auditoria(
        p_ID_Producto IN INT
    ) RETURN SYS_REFCURSOR;
END pkg_auditoria;

/
--------------------------------------------------------
--  DDL for Package PKG_CLIENTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_CLIENTES" AS
    PROCEDURE Registrar_Cliente(
        p_ID_Cliente IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    );

    PROCEDURE Actualizar_Cliente(
        p_ID_Cliente IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    );

    PROCEDURE Eliminar_Cliente(
        p_ID_Cliente IN INT
    );

    FUNCTION Obtener_Cliente(
        p_ID_Cliente IN INT
    ) RETURN SYS_REFCURSOR;
END pkg_clientes;

/
--------------------------------------------------------
--  DDL for Package PKG_EMPLEADOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_EMPLEADOS" AS
    PROCEDURE Registrar_Empleado(
        p_ID_Empleado IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Cargo IN VARCHAR,
        p_Salario IN DECIMAL,
        p_Departamento IN VARCHAR
    );

    PROCEDURE Actualizar_Empleado(
        p_ID_Empleado IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Cargo IN VARCHAR,
        p_Salario IN DECIMAL,
        p_Departamento IN VARCHAR
    );

    FUNCTION Obtener_Empleado(
        p_ID_Empleado IN INT
    ) RETURN SYS_REFCURSOR;
END pkg_empleados;

/
--------------------------------------------------------
--  DDL for Package PKG_INFORMES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_INFORMES" AS
    FUNCTION Generar_Informe_Ventas(
        p_Fecha_Inicio IN DATE,
        p_Fecha_Fin IN DATE
    ) RETURN CLOB;

    FUNCTION Generar_Informe_Inventario() RETURN CLOB;
END pkg_informes;

/
--------------------------------------------------------
--  DDL for Package PKG_PRODUCTOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_PRODUCTOS" AS
    PROCEDURE insertar_producto (
        p_id_producto  IN INT,
        p_nombre       IN VARCHAR,
        p_descripcion  IN VARCHAR,
        p_precio       IN DECIMAL,
        p_stock        IN INT,
        p_id_proveedor IN INT,
        p_id_categoria IN INT
    );

    PROCEDURE actualizar_producto (
        p_id_producto IN INT,
        p_nombre      IN VARCHAR,
        p_descripcion IN VARCHAR,
        p_precio      IN DECIMAL,
        p_stock       IN INT
    );

    PROCEDURE eliminar_producto (
        p_id_producto IN INT
    );

    FUNCTION obtener_stock_producto (
        p_id_producto IN INT
    ) RETURN INT;

    FUNCTION obtener_informacion_producto (
        p_id_producto IN INT
    ) RETURN VARCHAR2;

    FUNCTION calcular_valor_producto (
        p_id_producto IN INT
    ) RETURN DECIMAL;

END pkg_productos;

/
--------------------------------------------------------
--  DDL for Package PKG_PROVEEDORES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_PROVEEDORES" AS
    PROCEDURE Registrar_Proveedor(
        p_ID_Proveedor IN INT,
        p_Nombre IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    );

    PROCEDURE Actualizar_Proveedor(
        p_ID_Proveedor IN INT,
        p_Nombre IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    );

    PROCEDURE Eliminar_Proveedor(
        p_ID_Proveedor IN INT
    );

    FUNCTION Obtener_Proveedor(
        p_ID_Proveedor IN INT
    ) RETURN SYS_REFCURSOR;
END pkg_proveedores;

/
--------------------------------------------------------
--  DDL for Package PKG_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_REPORTES" AS
    FUNCTION Generar_Reporte_Clientes_Frecuentes() RETURN SYS_REFCURSOR;
    FUNCTION Generar_Reporte_Ventas_Mensuales() RETURN SYS_REFCURSOR;
END pkg_reportes;

/
--------------------------------------------------------
--  DDL for Package PKG_VENTAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PROYECTO_DB"."PKG_VENTAS" AS
    PROCEDURE registrar_venta (
        p_id_venta    IN INT,
        p_id_cliente  IN INT,
        p_id_empleado IN INT,
        p_fecha_venta IN DATE
    );

    PROCEDURE agregar_detalle_venta (
        p_id_venta    IN INT,
        p_id_producto IN INT,
        p_cantidad    IN INT,
        p_descuento   IN DECIMAL DEFAULT 0
    );

    FUNCTION calcular_total_venta (
        p_id_venta IN INT
    ) RETURN DECIMAL;

    FUNCTION obtener_detalle_venta (
        p_id_venta IN INT
    ) RETURN SYS_REFCURSOR;

END pkg_ventas;

/
--------------------------------------------------------
--  DDL for Package Body PKG_AUDITORIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_AUDITORIA" AS
    PROCEDURE Registrar_Auditoria(
        p_ID_Producto IN INT,
        p_Accion IN VARCHAR,
        p_Precio_Anterior IN DECIMAL,
        p_Precio_Nuevo IN DECIMAL,
        p_Usuario IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Auditoria_Productos (ID_Producto, Accion, Precio_Anterior, Precio_Nuevo, Usuario)
        VALUES (p_ID_Producto, p_Accion, p_Precio_Anterior, p_Precio_Nuevo, p_Usuario);
        COMMIT;
    END;

    FUNCTION Obtener_Historial_Auditoria(
        p_ID_Producto IN INT
    ) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT * FROM Auditoria_Productos WHERE ID_Producto = p_ID_Producto ORDER BY Fecha_Cambio DESC;

        RETURN v_Cursor;
    END;
END pkg_auditoria;

/
--------------------------------------------------------
--  DDL for Package Body PKG_CLIENTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_CLIENTES" AS

    PROCEDURE Registrar_Cliente(
        p_ID_Cliente IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Clientes (ID_Cliente, Nombre, Apellido, Email, Telefono, Direccion)
        VALUES (p_ID_Cliente, p_Nombre, p_Apellido, p_Email, p_Telefono, p_Direccion);
        COMMIT;
    END Registrar_Cliente;

    PROCEDURE Actualizar_Cliente(
        p_ID_Cliente IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    ) IS
    BEGIN
        UPDATE Clientes
        SET Nombre = p_Nombre, 
            Apellido = p_Apellido, 
            Email = p_Email, 
            Telefono = p_Telefono, 
            Direccion = p_Direccion
        WHERE ID_Cliente = p_ID_Cliente;
        COMMIT;
    END Actualizar_Cliente;

    PROCEDURE Eliminar_Cliente(
        p_ID_Cliente IN INT
    ) IS
    BEGIN
        DELETE FROM Clientes
        WHERE ID_Cliente = p_ID_Cliente;
        COMMIT;
    END Eliminar_Cliente;

    FUNCTION Obtener_Cliente(
        p_ID_Cliente IN INT
    ) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT * FROM Clientes WHERE ID_Cliente = p_ID_Cliente;
        RETURN v_Cursor;
    END Obtener_Cliente;

END pkg_clientes;

/
--------------------------------------------------------
--  DDL for Package Body PKG_EMPLEADOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_EMPLEADOS" AS
    PROCEDURE Registrar_Empleado(
        p_ID_Empleado IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Cargo IN VARCHAR,
        p_Salario IN DECIMAL,
        p_Departamento IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Empleados (ID_Empleado, Nombre, Apellido, Cargo, Salario, Departamento, Fecha_Contratacion)
        VALUES (p_ID_Empleado, p_Nombre, p_Apellido, p_Cargo, p_Salario, p_Departamento, SYSDATE);
        COMMIT;
    END;

    PROCEDURE Actualizar_Empleado(
        p_ID_Empleado IN INT,
        p_Nombre IN VARCHAR,
        p_Apellido IN VARCHAR,
        p_Cargo IN VARCHAR,
        p_Salario IN DECIMAL,
        p_Departamento IN VARCHAR
    ) IS
    BEGIN
        UPDATE Empleados
        SET Nombre = p_Nombre, Apellido = p_Apellido, Cargo = p_Cargo, Salario = p_Salario, Departamento = p_Departamento
        WHERE ID_Empleado = p_ID_Empleado;
        COMMIT;
    END;

    FUNCTION Obtener_Empleado(
        p_ID_Empleado IN INT
    ) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT * FROM Empleados WHERE ID_Empleado = p_ID_Empleado;

        RETURN v_Cursor;
    END;
END pkg_empleados;

/
--------------------------------------------------------
--  DDL for Package Body PKG_INFORMES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_INFORMES" AS
    FUNCTION Generar_Informe_Ventas(
        p_Fecha_Inicio IN DATE,
        p_Fecha_Fin IN DATE
    ) RETURN CLOB IS
        v_Informe CLOB;
    BEGIN
        -- Lógica para generar informe de ventas
        v_Informe := 'Informe de Ventas desde ' || TO_CHAR(p_Fecha_Inicio, 'DD/MM/YYYY') || 
                     ' hasta ' || TO_CHAR(p_Fecha_Fin, 'DD/MM/YYYY') || CHR(10);

        -- Aquí se agregarían los detalles de las ventas
        RETURN v_Informe;
    END;

    FUNCTION Generar_Informe_Inventario() RETURN CLOB IS
        v_Informe CLOB;
    BEGIN
        -- Lógica para generar informe de inventario
        v_Informe := 'Informe de Inventario' || CHR(10);

        -- Aquí se agregarían los detalles del inventario
        RETURN v_Informe;
    END;
END pkg_informes;

/
--------------------------------------------------------
--  DDL for Package Body PKG_PRODUCTOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_PRODUCTOS" AS

    PROCEDURE insertar_producto (
        p_id_producto  IN INT,
        p_nombre       IN VARCHAR,
        p_descripcion  IN VARCHAR,
        p_precio       IN DECIMAL,
        p_stock        IN INT,
        p_id_proveedor IN INT,
        p_id_categoria IN INT
    ) IS
    BEGIN
        INSERT INTO productos (
            id_producto,
            nombre,
            descripcion,
            precio,
            stock,
            id_proveedor,
            id_categoria
        ) VALUES ( p_id_producto,
                   p_nombre,
                   p_descripcion,
                   p_precio,
                   p_stock,
                   p_id_proveedor,
                   p_id_categoria );

        COMMIT;
    END;

    PROCEDURE actualizar_producto (
        p_id_producto IN INT,
        p_nombre      IN VARCHAR,
        p_descripcion IN VARCHAR,
        p_precio      IN DECIMAL,
        p_stock       IN INT
    ) IS
    BEGIN
        UPDATE productos
        SET
            nombre = p_nombre,
            descripcion = p_descripcion,
            precio = p_precio,
            stock = p_stock
        WHERE
            id_producto = p_id_producto;

        COMMIT;
    END;

    PROCEDURE eliminar_producto (
        p_id_producto IN INT
    ) IS
    BEGIN
        DELETE FROM productos
        WHERE
            id_producto = p_id_producto;

        COMMIT;
    END;

    FUNCTION obtener_stock_producto (
        p_id_producto IN INT
    ) RETURN INT IS
        v_stock INT;
    BEGIN
        SELECT
            stock
        INTO v_stock
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_stock;
    END;

    FUNCTION obtener_informacion_producto (
        p_id_producto IN INT
    ) RETURN VARCHAR2 IS
        v_informacion VARCHAR2(255);
    BEGIN
        SELECT
            nombre
            || ' - '
            || descripcion
        INTO v_informacion
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_informacion;
    END;

    FUNCTION calcular_valor_producto (
        p_id_producto IN INT
    ) RETURN DECIMAL IS
        v_valor DECIMAL(10, 2);
    BEGIN
        SELECT
            precio * stock
        INTO v_valor
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        RETURN v_valor;
    END;

END pkg_productos;

/
--------------------------------------------------------
--  DDL for Package Body PKG_PROVEEDORES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_PROVEEDORES" AS

    PROCEDURE Registrar_Proveedor(
        p_ID_Proveedor IN INT,
        p_Nombre IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    ) IS
    BEGIN
        INSERT INTO Proveedores (ID_Proveedor, Nombre, Email, Telefono, Direccion)
        VALUES (p_ID_Proveedor, p_Nombre, p_Email, p_Telefono, p_Direccion);
        COMMIT;
    END Registrar_Proveedor;

    PROCEDURE Actualizar_Proveedor(
        p_ID_Proveedor IN INT,
        p_Nombre IN VARCHAR,
        p_Email IN VARCHAR,
        p_Telefono IN VARCHAR,
        p_Direccion IN VARCHAR
    ) IS
    BEGIN
        UPDATE Proveedores
        SET Nombre = p_Nombre,
            Email = p_Email,
            Telefono = p_Telefono,
            Direccion = p_Direccion
        WHERE ID_Proveedor = p_ID_Proveedor;
        COMMIT;
    END Actualizar_Proveedor;

    PROCEDURE Eliminar_Proveedor(
        p_ID_Proveedor IN INT
    ) IS
    BEGIN
        DELETE FROM Proveedores
        WHERE ID_Proveedor = p_ID_Proveedor;
        COMMIT;
    END Eliminar_Proveedor;

    FUNCTION Obtener_Proveedor(
        p_ID_Proveedor IN INT
    ) RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
            SELECT * FROM Proveedores WHERE ID_Proveedor = p_ID_Proveedor;
        RETURN v_Cursor;
    END Obtener_Proveedor;

END pkg_proveedores;

/
--------------------------------------------------------
--  DDL for Package Body PKG_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_REPORTES" AS
    FUNCTION Generar_Reporte_Clientes_Frecuentes() RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT c.ID_Cliente, c.Nombre || ' ' || c.Apellido AS Cliente,
               COUNT(v.ID_Venta) AS Total_Ventas, SUM(v.Total) AS Total_Comprado
        FROM Clientes c
        JOIN Ventas v ON c.ID_Cliente = v.ID_Cliente
        GROUP BY c.ID_Cliente, c.Nombre, c.Apellido
        ORDER BY Total_Comprado DESC;

        RETURN v_Cursor;
    END;

    FUNCTION Generar_Reporte_Ventas_Mensuales() RETURN SYS_REFCURSOR IS
        v_Cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_Cursor FOR
        SELECT EXTRACT(YEAR FROM Fecha_Venta) AS Anio,
               EXTRACT(MONTH FROM Fecha_Venta) AS Mes,
               COUNT(ID_Venta) AS Numero_Ventas,
               SUM(Total) AS Total_Ventas
        FROM Ventas
        GROUP BY EXTRACT(YEAR FROM Fecha_Venta), EXTRACT(MONTH FROM Fecha_Venta)
        ORDER BY Anio DESC, Mes DESC;

        RETURN v_Cursor;
    END;
END pkg_reportes;

/
--------------------------------------------------------
--  DDL for Package Body PKG_VENTAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PROYECTO_DB"."PKG_VENTAS" AS

    PROCEDURE registrar_venta (
        p_id_venta    IN INT,
        p_id_cliente  IN INT,
        p_id_empleado IN INT,
        p_fecha_venta IN DATE
    ) IS
    BEGIN
        INSERT INTO ventas (
            id_venta,
            id_cliente,
            id_empleado,
            fecha_venta,
            total
        ) VALUES ( p_id_venta,
                   p_id_cliente,
                   p_id_empleado,
                   p_fecha_venta,
                   0 );

        COMMIT;
    END;

    PROCEDURE agregar_detalle_venta (
        p_id_venta    IN INT,
        p_id_producto IN INT,
        p_cantidad    IN INT,
        p_descuento   IN DECIMAL DEFAULT 0
    ) IS
        v_precio_unitario DECIMAL(10, 2);
    BEGIN
        SELECT
            precio
        INTO v_precio_unitario
        FROM
            productos
        WHERE
            id_producto = p_id_producto;

        INSERT INTO detalles_venta (
            id_detalle,
            id_venta,
            id_producto,
            cantidad,
            precio_unitario,
            descuento
        ) VALUES ( seq_detalle_venta.NEXTVAL,
                   p_id_venta,
                   p_id_producto,
                   p_cantidad,
                   v_precio_unitario,
                   p_descuento );

        COMMIT;
    END;

    FUNCTION calcular_total_venta (
        p_id_venta IN INT
    ) RETURN DECIMAL IS
        v_total DECIMAL(10, 2);
    BEGIN
        SELECT
            SUM(cantidad * precio_unitario *(1 - nvl(descuento, 0) / 100))
        INTO v_total
        FROM
            detalles_venta
        WHERE
            id_venta = p_id_venta;

        UPDATE ventas
        SET
            total = v_total
        WHERE
            id_venta = p_id_venta;

        COMMIT;
        RETURN v_total;
    END;

    FUNCTION obtener_detalle_venta (
        p_id_venta IN INT
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR SELECT
                                                p.nombre,
                                                dv.cantidad,
                                                dv.precio_unitario,
                                                ( dv.cantidad * dv.precio_unitario * ( 1 - nvl(dv.descuento, 0) / 100 ) ) AS subtotal
                                            FROM
                                                     detalles_venta dv
                                                JOIN productos p ON dv.id_producto = p.id_producto
                          WHERE
                              dv.id_venta = p_id_venta;

        RETURN v_cursor;
    END;

END pkg_ventas;

/
--------------------------------------------------------
--  DDL for Function FN_CALCULARCOMISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_CALCULARCOMISION" (
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
--------------------------------------------------------
--  DDL for Function FN_CALCULAREDADCLIENTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_CALCULAREDADCLIENTE" (
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
--------------------------------------------------------
--  DDL for Function FN_CALCULARIMPUESTO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_CALCULARIMPUESTO" (
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
--------------------------------------------------------
--  DDL for Function FN_DESCUENTOFIDELIDAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_DESCUENTOFIDELIDAD" (
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
--------------------------------------------------------
--  DDL for Function FN_DIASDESDEULTIMACOMPRA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_DIASDESDEULTIMACOMPRA" (
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
--------------------------------------------------------
--  DDL for Function FN_FORMATEARFECHA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_FORMATEARFECHA" (
    p_Fecha IN DATE
) RETURN VARCHAR2
AS
BEGIN
    RETURN TO_CHAR(p_Fecha, 'DD "de" Month "de" YYYY, HH24:MI');
END;

/
--------------------------------------------------------
--  DDL for Function FN_GENERARCODIGOPRODUCTO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_GENERARCODIGOPRODUCTO" (
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
--------------------------------------------------------
--  DDL for Function FN_GENERARFACTURATEXTO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_GENERARFACTURATEXTO" (
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
--------------------------------------------------------
--  DDL for Function FN_NOMBRECOMPLETOCLIENTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_NOMBRECOMPLETOCLIENTE" (
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
--------------------------------------------------------
--  DDL for Function FN_OBTENERPRODUCTOSRELACIONADOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_OBTENERPRODUCTOSRELACIONADOS" (
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
--------------------------------------------------------
--  DDL for Function FN_TOTALVALORINVENTARIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_TOTALVALORINVENTARIO" 
RETURN DECIMAL
AS
    v_Total DECIMAL(15,2);
BEGIN
    SELECT SUM(Stock * Precio) INTO v_Total
    FROM Productos;

    RETURN v_Total;
END;

/
--------------------------------------------------------
--  DDL for Function FN_VALIDAREMAIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_VALIDAREMAIL" (
    p_Email IN VARCHAR2
) RETURN BOOLEAN
AS
    v_Regex VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
    RETURN REGEXP_LIKE(p_Email, v_Regex);
END;

/
--------------------------------------------------------
--  DDL for Function FN_VALORIZACIONINVENTARIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_VALORIZACIONINVENTARIO" (
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
--------------------------------------------------------
--  DDL for Function FN_VERIFICARCREDENCIALES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_VERIFICARCREDENCIALES" (
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
--------------------------------------------------------
--  DDL for Function FN_VERIFICARDISPONIBILIDAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PROYECTO_DB"."FN_VERIFICARDISPONIBILIDAD" (
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
--------------------------------------------------------
--  Constraints for Table PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."PRODUCTOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."PRODUCTOS" MODIFY ("PRECIO" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."PRODUCTOS" MODIFY ("STOCK" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."PRODUCTOS" ADD PRIMARY KEY ("ID_PRODUCTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table AUDITORIA_PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."AUDITORIA_PRODUCTOS" ADD PRIMARY KEY ("ID_AUDITORIA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CATEGORIAS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."CATEGORIAS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."CATEGORIAS" ADD PRIMARY KEY ("ID_CATEGORIA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENTES
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."CLIENTES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."CLIENTES" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."CLIENTES" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."CLIENTES" ADD PRIMARY KEY ("ID_CLIENTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table USUARIOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."USUARIOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."USUARIOS" MODIFY ("CORREO" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."USUARIOS" ADD CHECK (ROL IN ('ADMIN', 'USUARIO')) ENABLE;
  ALTER TABLE "PROYECTO_DB"."USUARIOS" ADD PRIMARY KEY ("ID_USUARIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "PROYECTO_DB"."USUARIOS" ADD UNIQUE ("CORREO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table INVENTARIO
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."INVENTARIO" MODIFY ("CANTIDAD_ACTUAL" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."INVENTARIO" ADD PRIMARY KEY ("ID_INVENTARIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table VENTAS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."VENTAS" MODIFY ("FECHA_VENTA" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."VENTAS" ADD PRIMARY KEY ("ID_VENTA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table PROVEEDORES
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."PROVEEDORES" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."PROVEEDORES" ADD PRIMARY KEY ("ID_PROVEEDOR")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "PROYECTO_DB"."PROVEEDORES" MODIFY ("DIRECCION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EMPLEADOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."EMPLEADOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."EMPLEADOS" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."EMPLEADOS" ADD PRIMARY KEY ("ID_EMPLEADO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table DETALLES_VENTA
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."DETALLES_VENTA" MODIFY ("CANTIDAD" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."DETALLES_VENTA" MODIFY ("PRECIO_UNITARIO" NOT NULL ENABLE);
  ALTER TABLE "PROYECTO_DB"."DETALLES_VENTA" ADD PRIMARY KEY ("ID_DETALLE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table AUDITORIA_PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."AUDITORIA_PRODUCTOS" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "PROYECTO_DB"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DETALLES_VENTA
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."DETALLES_VENTA" ADD FOREIGN KEY ("ID_VENTA")
	  REFERENCES "PROYECTO_DB"."VENTAS" ("ID_VENTA") ENABLE;
  ALTER TABLE "PROYECTO_DB"."DETALLES_VENTA" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "PROYECTO_DB"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INVENTARIO
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."INVENTARIO" ADD FOREIGN KEY ("ID_PRODUCTO")
	  REFERENCES "PROYECTO_DB"."PRODUCTOS" ("ID_PRODUCTO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRODUCTOS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."PRODUCTOS" ADD FOREIGN KEY ("ID_PROVEEDOR")
	  REFERENCES "PROYECTO_DB"."PROVEEDORES" ("ID_PROVEEDOR") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table VENTAS
--------------------------------------------------------

  ALTER TABLE "PROYECTO_DB"."VENTAS" ADD FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "PROYECTO_DB"."CLIENTES" ("ID_CLIENTE") ENABLE;
  ALTER TABLE "PROYECTO_DB"."VENTAS" ADD CONSTRAINT "FK_VENTAS_EMPLEADO" FOREIGN KEY ("ID_EMPLEADO")
	  REFERENCES "PROYECTO_DB"."EMPLEADOS" ("ID_EMPLEADO") ENABLE;
