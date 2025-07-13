@echo off
setlocal

:: Crear carpeta bin si no existe
if not exist "bin" mkdir bin

:: Compilar
javac -cp "lib\ojdbc8.jar" -d bin "TECHEXPRESS\ConnectionBD\conexionBD.java"

:: Ejecutar
java -cp "lib\ojdbc8.jar;bin" TECHEXPRESS.ConnectionBD.conexionBD

pause
