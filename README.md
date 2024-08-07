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

