import { Prisma, PrismaClient } from "@prisma/client";

// Este es el middleware que usa prisma para conectar con la BD.
export const prisma = new PrismaClient();
