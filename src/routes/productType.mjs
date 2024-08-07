
import { prisma } from "../db.mjs";
import { Router } from "express";

const router = Router();


router.get('/products_types', async (req, res) => {
    const getProductTypes = await prisma.type.findMany({
        include: {
            products: true
        }
    })
    res.json(getProductTypes)
})

router.post("/products_types", async (req, res)  => {
    const postProductType = await prisma.type.create({
        data: req.body,
    })
    res.json(postProductType);
})
export default router;
