-- Tabla Proveedores
CREATE TABLE Proveedores (
    ID_Proveedor INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100),
    Telefono VARCHAR(15),
    Direccion VARCHAR(200),
    Email VARCHAR(100)
);

-- Tabla Categorias
CREATE TABLE Categorias (
    ID_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Tabla Productos
CREATE TABLE Productos (
    ID_Producto INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(500),
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    ID_Proveedor INT,
    ID_Categoria INT,
    Fecha_Creacion DATE DEFAULT SYSDATE,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
);

ALTER TABLE Productos 
ADD ID_Categoria INT;


-- Tabla Clientes
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Telefono VARCHAR(15),
    Direccion VARCHAR(200),
    Fecha_Registro DATE DEFAULT SYSDATE
);
ALTER TABLE Clientes ADD Fecha_Nacimiento DATE;

-- Tabla Ventas
CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    ID_Cliente INT,
    ID_Empleado INT,
    Fecha_Venta DATE NOT NULL,
    Total DECIMAL(10, 2),
    Estado VARCHAR(20) DEFAULT 'COMPLETADA',
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);

ALTER TABLE Ventas 
ADD ID_Empleado INT;

ALTER TABLE Ventas
ADD CONSTRAINT fk_ventas_empleado
FOREIGN KEY (ID_Empleado)
REFERENCES Empleados(ID_Empleado);


-- Tabla Detalles_Venta
CREATE TABLE Detalles_Venta (
    ID_Detalle INT PRIMARY KEY,
    ID_Venta INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10, 2) NOT NULL,
    Descuento DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    ID_Empleado INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Cargo VARCHAR(100),
    Salario DECIMAL(10, 2),
    Fecha_Contratacion DATE,
    Departamento VARCHAR(50)
);
ALTER TABLE Empleados ADD Contrasena VARCHAR2(200);


-- Tabla Auditoria_Productos
CREATE TABLE Auditoria_Productos (
    ID_Auditoria INT PRIMARY KEY,
    ID_Producto INT,
    Accion VARCHAR(10),
    Precio_Anterior DECIMAL(10, 2),
    Precio_Nuevo DECIMAL(10, 2),
    Usuario VARCHAR(50),
    Fecha_Cambio DATE DEFAULT SYSDATE,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto)
);


-- Agregar columna Fecha_Nacimiento a Clientes
ALTER TABLE Clientes 
ADD Fecha_Nacimiento DATE;

-- Agregar columna Contrasena a Empleados
ALTER TABLE Empleados 
ADD Contrasena VARCHAR2(200);

ALTER TABLE Detalles_Venta
ADD Descuento NUMBER(5,2) DEFAULT 0;
ALTER TABLE Clientes
ADD Direccion VARCHAR2(200);
ALTER TABLE Proveedores
ADD Email VARCHAR2(100);
ALTER TABLE Empleados
ADD Fecha_Contratacion DATE DEFAULT SYSDATE;
ALTER TABLE Empleados
ADD Departamento VARCHAR2(100);
ALTER TABLE Ventas
ADD Estado VARCHAR2(20) DEFAULT 'ACTIVA';




