# Datos de Prueba

Este folder contiene un archivo SQL y un script de PowerShell para insertar datos de prueba en una base de datos MySQL. Los datos de prueba son esenciales para configurar y probar la aplicación.

## Pre-requisitos

- Tener la base de datos con las migraciones de prisma al dia.

## Contenido

- **`data_for_test.sql`**: Contiene datos de prueba básicos para la aplicación, incluyendo usuarios, roles, categorías de productos, fechas de productos y productos.

- **`run_data_for_test.ps1`**: Un script de PowerShell que permite ejecutar el archivo SQL en una base de datos MySQL. Debes configurar las variables de autenticación de MySQL en el script para que funcione correctamente.

## Uso

### Ejecutar el Script de PowerShell -Opcion 1-

1. **Configurar Variables de Autenticación**

   Copia el archivo `config.ps1.example` pero sin el ".example" y configura las credenciales para tu servidor mysql. Deberia quedarte el archivo `config.ps1` con los valores de tus credenciales.

   Abre el archivo `run_data_for_test.ps1` y ajusta las siguientes variables **en caso de que sea necesario**:

   - `$databaseName`: El nombre de la base de datos.
   - `$sqlFilePath`: La ruta al archivo SQL. --la default deberia estar bien--

2. **Ejecutar el Script de PowerShell**

   Abre PowerShell, navega al directorio que contiene `run_data_for_test.ps1`, y ejecuta el script con el siguiente comando:

   ```powershell
   .\run_data_for_test.ps1
   ```

Esto ejecutará el archivo SQL en la base de datos especificada.

### Ejecutar el Archivo SQL Directamente en MySQL Workbench -Opcion 2-

1. **Abrir MySQL Workbench**

   Abre MySQL Workbench e inicia sesión en tu servidor MySQL.

2. **Cargar el Archivo SQL**

   Ve a File > Open SQL Script.
   Selecciona el archivo data_for_test.sql.

3. **Ejecutar el Script**

   Haz clic en el botón de Execute (el rayo) para ejecutar el script.
   Esto insertará los datos de prueba en la base de datos activa.

#### Notas

Asegúrate de que MySQL esté en funcionamiento antes de ejecutar el script de PowerShell o el archivo SQL directamente.  
Verifica que el archivo SQL esté en el mismo directorio que el script de PowerShell si usas la ruta relativa.
