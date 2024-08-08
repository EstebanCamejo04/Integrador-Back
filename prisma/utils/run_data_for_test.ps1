# Nombre de la base de datos
$databaseName = "fly_mountain"

# Ruta al archivo SQL
$sqlFilePath = ".\data_for_test.sql"

# Usuario y contraseña de MySQL
. .\config.ps1

# Construir el comando para ejecutar el archivo SQL usando cmd.exe
$command = "mysql -u $mysqlUser --password=$mysqlPassword --database=$databaseName < $sqlFilePath"

# Ejecutar el comando usando cmd.exe para manejar la redirección
$fullCommand = "cmd.exe /c `$command"
Invoke-Expression $fullCommand

# Verificar si ocurrió un error
if ($?) {
    Write-Host "Script SQL ejecutado con éxito en la base de datos '$databaseName'."
} else {
    Write-Host "Error al ejecutar el script SQL."
}