import { Router } from "express";
import { getAllProdFeatures, getAllProducts, getProductCategories, getProductDates, postProduct, postProductCategorie, postProductDate, productById } from "./service.mjs"

export const productRouter = Router();

//  ENDPOINTS FOR PRODUCTS 

// GET products
productRouter.get("/products", async (req, res) => {
    try {
        const products = await getAllProducts();
        res.status(200).json(products);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});

// GET products by ID
productRouter.get("/products/:id", async (req, res) => {
    try {
        const id = req.params.id;

        const findProdByID = await productById(id);
        res.status(200).json(findProdByID);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});

// POST products
productRouter.post("/products", async (req, res) => {
    try {

        const newProduct = await postProduct(req.body);
        res.status(201).json(newProduct);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});

// ENDPOINTS FOR Categories

// GET products categories
productRouter.get("/products_categories", async (req, res) => {
    try {
        const getCategories = await getProductCategories();
        res.status(200).json(getCategories);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products categories", error: error.message})
    }
});

// POST product categories
productRouter.post("/products_categories", async (req, res) => {
    try {

        const postCategories  = await postProductCategorie(req.body);
        res.status(201).json(postCategories);
    } catch (error) {

        res.status(500).json({message:"Failed to fetch all products categories", error: error.message})
    }
});

// ENDPOINTS FOR PRODUCTS DATES

// GET products dates
productRouter.get("/products_dates", async (req, res) => {
    try {
        const getDates = await getProductDates();
        res.status(200).json(getDates);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products dates", error: error.message})
    }
});

// POST product dates
productRouter.post("/products_dates", async (req, res) => {
    try {
        const postDates = await postProductDate(req.body);      
        res.status(201).json(postDates);
    } catch (error) {
        res.status(500).json({message:"Failed to post products dates", error: error.message})

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


