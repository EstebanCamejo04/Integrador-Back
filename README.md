# Slack Line Tours Project

Este proyecto es una aplicación de tours desarrollada con Node.js y Prisma.

## Requisitos

- Node.js (versión 19 o superior)
- Prisma (instalado como dependencia del proyecto)
- Base de datos compatible con Prisma (PostgreSQL, MySQL, SQLite, etc.)

## Instalación

Sigue estos pasos para instalar y ejecutar el proyecto en tu máquina local.

### Clonar el repositorio

```bash
git clone https://github.com/EstebanCamejo04/Integrador-Back.git
cd Integrador-Back
```

### Instalar las dependencias

```bash
npm install
```

## Prisma

La base de datos se guarda en un archivo dev.db en la carpeta raiz del proyecto.
Para generarla de manera local:

```bash
npx prisma migrate dev
```

En caso de realizar algun cambio al modelado de la base de datos, hace falta volver a correr:

```bash
npx prisma migrate dev
```

Para ver la base de datos:

```bash
npx prisma studio
```

Nota:
Es importante para usar los comandos de prisma, estar parados en el folder raiz del proyecto `(./Integrador-Back)`

# Documentación de Configuración y Ejecución de la Aplicación en Docker

## Prerrequisitos

Antes de comenzar, asegúrate de tener instalados los siguientes componentes:

1. **Docker Desktop**: Descárgalo e instálalo desde [aquí](https://www.docker.com/products/docker-desktop). Docker Desktop es necesario para ejecutar y gestionar contenedores Docker en tu máquina local.

2. **Git Bash o Visual Studio Code**: Para ejecutar scripts de Bash, puedes usar Git Bash o la terminal integrada en Visual Studio Code.

## Estructura del Proyecto

Este proyecto utiliza Docker para contenerizar una aplicación Node.js y una base de datos MySQL. A continuación se describen los archivos clave:

- **`docker-compose.yml`**: Archivo de configuración para Docker Compose que define los servicios (aplicación y base de datos), redes y volúmenes necesarios.
- **`Dockerfile`**: Archivo de configuración para construir la imagen Docker de la aplicación Node.js.
- **`docker_init.sh`**: Script que inicializa la base de datos y configura la aplicación.

## Pasos para Ejecutar la Aplicación

### Correr el script

**`./docker_init.sh`**

Corre ese script desde la consola de git bash de visual studio code.
Va a demorar un poco, aproximadamente 2 minutos en levantar todo la primera vez. Una vez que termino de correr el script, tendras la api corriendo en el puerto 3000, podras acceder al endpoint inicial en el navegador yendo a "localhost:3000".

Despues de que termino de correr el script, puedes verificar en el docker desktop que tanto la bd como la api esten corriendo bien.
Luego este script solo lo ejecutaras cuando bajes cambios de Github, si no bajas cambios solo alcanza con ir a docker desktop e iniciar los servicios.
Puedes loguearte en la bd en MySQL Workbench apuntando al puerto 3309 y con los datos "root" y "rootpassword"

Este script ya ejecuta algunos datos default que tenemos en `./prisma/utils/data_for_test.sql`
