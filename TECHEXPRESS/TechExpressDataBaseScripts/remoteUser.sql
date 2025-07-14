-- Asegurarse de estar en el PDB
ALTER SESSION SET CONTAINER = ORCLPDB;

-- Crear el usuario con su contraseña
CREATE USER remoteUser IDENTIFIED BY DBFide1;

-- Permiso para iniciar sesión
GRANT CREATE SESSION TO remoteUser;

-- Permisos básicos de conexión y creación de objetos
GRANT CONNECT, RESOURCE TO remoteUser;

-- Desbloquear el usuario (por si acaso estuviera bloqueado)
ALTER USER remoteUser ACCOUNT UNLOCK;

-- Permitir que el usuario pueda conectarse aunque el PDB esté en modo RESTRICTED
GRANT RESTRICTED SESSION TO remoteUser;