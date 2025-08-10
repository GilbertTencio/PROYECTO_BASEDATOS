    CURSOR cur_clientes_activos IS
        SELECT Cliente_ID, Nombre_Cliente, Apellido_Cliente, Email_Cliente
        FROM Clientes
        WHERE Estado_ID = 1;

    CURSOR cur_inventario_bajo IS
        SELECT Item_ID, Nombre_Item, Cantidad_Item
        FROM Inventario
        WHERE Cantidad_Item < 5;

--estos primeros 2 cursores estan dentro del ultimo paquete, no deberian ponerlo en la base desde acá
