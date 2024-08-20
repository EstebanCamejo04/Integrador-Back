import { prisma } from "../db.mjs";
import { Router } from "express";

const router = Router();

router.get("/products_categories", async (req, res) => {
  const getProductTypes = await prisma.product_category.findMany({
    include: {
      products: true,
    },
  });
  res.json(getProductTypes);
});

router.post("/products_categories", async (req, res) => {
  const postProductType = await prisma.product_category.create({
    data: req.body,
  });
  res.json(postProductType);
});
export default router;
