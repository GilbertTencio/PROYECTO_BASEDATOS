--Tablas 

CREATE TABLE Estado (
    Estado_ID NUMBER PRIMARY KEY,
    Nombre_Estado VARCHAR(10),
    Descripcion_Estado VARCHAR(20)
);

CREATE TABLE Clientes (
    Cliente_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Nombre_Cliente VARCHAR(1000),
    Apellido_Cliente VARCHAR(1000),
    Residencia_Cliente VARCHAR(1000),
    Email_Cliente VARCHAR(1000),
    CONSTRAINT FK_Clientes_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID)
);

CREATE TABLE Inventario (
    Item_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Nombre_Item VARCHAR(1000),
    Descripcion_Item VARCHAR(1000),
    Precio_Unitario NUMBER(10,3),
    Cantidad_Item NUMBER,
    CONSTRAINT FK_Inventario_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID)
);

CREATE TABLE Gestion_Servicios (
    Servicio_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Item_ID NUMBER,
    Nombre_Servicio VARCHAR(1000),
    Descripcion_Servicio VARCHAR(1000),
    CONSTRAINT FK_GS_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_GS_Item FOREIGN KEY (Item_ID) REFERENCES Inventario(Item_ID)
);

CREATE TABLE Empleados (
    Empleado_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Nombre_Empleado VARCHAR(1000),
    Apellido_Empleado VARCHAR(1000),
    Email_Empleado VARCHAR(1000),
    Puesto VARCHAR(50),
    Salario VARCHAR(1000),
    CONSTRAINT FK_Empleados_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID)
);

CREATE TABLE Cotizaciones (
    Cotizacion_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Item_ID NUMBER,
    Servicio_ID NUMBER,
    Empleado_ID NUMBER,
    Posible_Fecha_Servicio DATE,
    CONSTRAINT FK_Cot_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_Cot_Item FOREIGN KEY (Item_ID) REFERENCES Inventario(Item_ID),
    CONSTRAINT FK_Cot_Servicio FOREIGN KEY (Servicio_ID) REFERENCES Gestion_Servicios(Servicio_ID),
    CONSTRAINT FK_Cot_Empleado FOREIGN KEY (Empleado_ID) REFERENCES Empleados(Empleado_ID)
);

CREATE TABLE Categoria_Producto (
    Categoria_ID NUMBER PRIMARY KEY,
    Item_ID NUMBER,
    Estado_ID NUMBER,
    Nombre_Categoria VARCHAR(1000),
    Descripcion_Categoria VARCHAR(1000),
    CONSTRAINT FK_CP_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_CP_Item FOREIGN KEY (Item_ID) REFERENCES Inventario(Item_ID)
);

CREATE TABLE Servicio_Cliente (
    Servicio_Realizado NUMBER PRIMARY KEY,
    Empleado_ID NUMBER,
    Servicio_ID NUMBER,
    Cliente_ID NUMBER,
    Estado_ID NUMBER,
    Fecha_ID DATE,
    Cantidad_Servicios NUMBER,
    Precio_Total NUMBER(10,3),
    CONSTRAINT FK_SC_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_SC_Servicio FOREIGN KEY (Servicio_ID) REFERENCES Gestion_Servicios(Servicio_ID),
    CONSTRAINT FK_SC_Cliente FOREIGN KEY (Cliente_ID) REFERENCES Clientes(Cliente_ID),
    CONSTRAINT FK_SC_Empleado FOREIGN KEY (Empleado_ID) REFERENCES Empleados(Empleado_ID)
);

CREATE TABLE Seguimiento (
    Seguimiento_ID NUMBER PRIMARY KEY,
    Estado_ID NUMBER,
    Servicio_Realizado NUMBER,
    Fecha_Seguimiento DATE,
    Descripcion_Seguimiento VARCHAR(1000),
    Seguimiento_Siguiente DATE,
    CONSTRAINT FK_Seg_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_Seg_Servicio FOREIGN KEY (Servicio_Realizado) REFERENCES Servicio_Cliente(Servicio_Realizado)
);

CREATE TABLE Pagos (
    Pago_ID NUMBER PRIMARY KEY,
    Servicio_Realizado NUMBER,
    Estado_ID NUMBER,
    Precio_Total NUMBER(10,3),
    Metodo_Pago VARCHAR(5),
    CONSTRAINT FK_Pagos_Estado FOREIGN KEY (Estado_ID) REFERENCES Estado(Estado_ID),
    CONSTRAINT FK_Pagos_Servicio FOREIGN KEY (Servicio_Realizado) REFERENCES Servicio_Cliente(Servicio_Realizado)
);
