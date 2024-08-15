import { prisma } from "../db.mjs";
import { Router } from "express";

const router = Router();

// GET products

router.get("/products", async (req, res) => {
  // guardo la consulta en la una constante
  const getAllProducts = await prisma.product.findMany({
    // el include se usa para mostrar datos consultados a otra tabla.
    include: {
      // type y productDate hace referencia a las otras tablas.. dejarlo en true para que se vean sus datos
      type: true,
      productDate: true,
    },
  });
  // retorno la constante con el valor de la consulta ya almacenado
  res.json(getAllProducts);
});

router.get("/products/:id", async (req, res) => {
  const productById = await prisma.product.findFirst({
    where: {
      // para poder usar el id que viene por los headers hace falta pasarlo a Int..
      id: parseInt(req.params.id),
    },
    include: {
      type: true,
      productDate: true,
    },
  });
  return res.json(productById);
});

router.post("/products", async (req, res) => {
  const postProduct = await prisma.product.create({
    // req.body es todo lo que llega en el cuerpo de la respuesta.. tambien se puede hacer por cada campo de la tabla
    data: req.body,
  });
  res.json(postProduct);
});

// exportamos las rutas a la app.
export default router;
