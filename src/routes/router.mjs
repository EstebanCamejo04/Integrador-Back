import { Router } from "express";
import { getAllProdFeatures, getAllProducts, postProduct, productById } from "./service.mjs"

export const productRouter = Router();

//  ENDPOINTS FOR PRODUCTS 

productRouter.get("/products", async (req, res) => {
    try {
        const products = await getAllProducts();
        res.status(200).json(products);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});


productRouter.get("/products/:id", async (req, res) => {
    try {
        const id = req.params.id;

        const findProdByID = await productById(id);
        res.status(200).json(findProdByID);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});

productRouter.post("/products", async (req, res) => {
    try {

        const newProduct = await postProduct(req.body);
        res.status(201).json(newProduct);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});


// ENDPOINTS FOR FEATURES
productRouter.get("/products_features", async (req,res) => {
    try {
        const productFeatures = await getAllProdFeatures();
        res.status(200).json(productFeatures);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all features", error: error.message})
    }

})


