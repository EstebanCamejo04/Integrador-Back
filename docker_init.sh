# Nombre de la imagen del contenedor de la base de datos
DB_IMAGE_NAME="mysql:8"

docker-compose build
docker-compose up -d

echo "Waiting for MySQL Server..."
sleep 10
echo "Waiting for MySQL Server..."
sleep 10
echo "Waiting for MySQL Server..."
sleep 10
echo "Waiting for Prisma Generation"
sleep 15
echo "Waiting for Prisma Generation"
sleep 15

# Obtener el ID del contenedor basado en la imagen
DB_CONTAINER_ID=$(docker ps -q -f "ancestor=$DB_IMAGE_NAME")

# Si no se encuentra el contenedor, salir del script con un mensaje de error
if [ -z "$DB_CONTAINER_ID" ]; then
  echo "No se encontró el contenedor para la imagen $DB_IMAGE_NAME"
  exit 1
fi

# Ejecutar el script SQL dentro del contenedor
echo "Ejecutando script de datos.."
cat ./prisma/utils/data_for_test.sql | docker exec -i $DB_CONTAINER_ID mysql -h db -uroot -prootpassword fly_mountain
echo "Listo! La base de datos esta levantada y la api esta corriendo en el puerto 3000"
exit 1