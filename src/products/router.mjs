import { Router } from "express";
import {
  getAllProdFeatures,
  getAllProducts,
  getProductCategories,
  getProductDates,
  multerHandler,
  postProduct,
  postProductCategorie,
  postProductDate,
  productById,
  searchProducts,
} from "./service.mjs";

export const productRouter = Router();

//  ENDPOINTS FOR PRODUCTS

// GET products
productRouter.get("/products", async (req, res) => {
  try {
    const products = await getAllProducts();
    res.status(200).json(products);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch all products", error: error.message });
  }
});

// GET products by ID
productRouter.get("/products/:id", async (req, res) => {
  try {
    const id = req.params.id;

    const findProdByID = await productById(id);
    res.status(200).json(findProdByID);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch all products", error: error.message });
  }
});

// POST products
productRouter.post("/products", multerHandler(), async (req, res) => {
  try {
    console.log("Body data", req.body);
    console.log("??", req.file);

        // Extraemos los datos del cuerpo y el archivo
        const image = req.file ? req.file : null;
         if (image) {
            console.log("Image Details:", {
                fieldname: image.fieldname,
                originalname: image.originalname,
                mimetype: image.mimetype,
                size: image.size,
                buffer: image.buffer
            });
        } else {
            console.log("No image file uploaded.");

        }  
        // Queda para cuando sean mas imagenes

        const { name, description, category_id, price, available} = req.body;
        //const imageUrl = req.file ? req.file.buffer.toString('base64') : null;
        // Convertimos `available` a booleano si es necesario
        const parsedAvailable = JSON.parse(available.replace(/^"|"$/g, '')); // Si sacan esto se rompe el campo de boolean 👍🏼
            console.log("parsedAvailable ",parsedAvailable);

        // Llamamos a la función para crear el producto
        const newProduct = await postProduct({
            name: name,
            description: description,
            categoryId: parseInt(category_id, 10), 
            price: parseInt(price, 10),           
            available: parsedAvailable,
        }, image);
        res.status(201).json(newProduct);
    } catch (error) {
        res.status(500).json({message:"Failed to fetch all products", error: error.message})
    }
});
// POST search-products
productRouter.get("/search-products", async (req, res) => {
  const words = req.query.words;
  const start = req.query.start;
  const end = req.query.end;
  if (!words && !start && !end) {
    return res.status(400).json({
      error:
        "Debes buscar por al menos un criterio (rango de fechas o palabras)",
    });
  }

  try {
    const newProduct = await searchProducts(words, start, end);
    res.status(200).json(newProduct);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to searching products", error: error.message });
  }
});
// ENDPOINTS FOR Categories

// GET products categories
productRouter.get("/products_categories", async (req, res) => {
  try {
    const getCategories = await getProductCategories();
    res.status(200).json(getCategories);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch all products categories",
      error: error.message,
    });
  }
});

// POST product categories
productRouter.post("/products_categories", async (req, res) => {
  try {
    const postCategories = await postProductCategorie(req.body);
    res.status(201).json(postCategories);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch all products categories",
      error: error.message,
    });
  }
});

// ENDPOINTS FOR PRODUCTS DATES

// GET products dates
productRouter.get("/products_dates", async (req, res) => {
  try {
    const getDates = await getProductDates();
    res.status(200).json(getDates);
  } catch (error) {
    res.status(500).json({
      message: "Failed to fetch all products dates",
      error: error.message,
    });
  }
});

// POST product dates
productRouter.post("/products_dates", async (req, res) => {
  try {
    const postDates = await postProductDate(req.body);
    res.status(201).json(postDates);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to post products dates", error: error.message });
  }
});

// ENDPOINTS FOR FEATURES
productRouter.get("/products_features", async (req, res) => {
  try {
    const productFeatures = await getAllProdFeatures();
    res.status(200).json(productFeatures);
  } catch (error) {
    res
      .status(500)
      .json({ message: "Failed to fetch all features", error: error.message });
  }
});
