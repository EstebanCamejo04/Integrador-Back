import { prisma } from "../db.mjs";
import { Router } from "express";

const router = Router();

router.get('/products_dates', async (req, res) => {
    const getProductTypes = await prisma.product_date.findMany({
        include:{
           product: true 
        }
    })
    res.json(getProductTypes)
})

router.post("/products_dates", async (req, res)  => {
    const postProductType = await prisma.product_date.create({
        data: req.body,
    })
    res.json(postProductType);
})
export default router;
