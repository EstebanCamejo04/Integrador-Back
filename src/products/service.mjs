import { prisma } from "../db.mjs";


// PRODUCTS 
//
// Fetch all products with related data
export const getAllProducts = async () => {
    try {
        return prisma.product.findMany({
            include: {
                category: true,
                product_date: true,
                product_location: true
            }
        });
    } catch (error) {
        console.error("Error fetching all products:", error);
        throw new Error("Unable to fetch products. Please try again later.");
    }
};

// Fetch a product by ID with related data
export const productById = async (id) => {
    try {
        return prisma.product.findFirst({
            where: {
                id: parseInt(id, 10)
            },
            include: {
                category: true,
                product_date: true,
                product_feature: { // Tabla Intermedia de caracteristicas
                    include: {
                        feature: true //Incluir detalles de caracteristicas 
                    }
                }
            }
        });
    } catch (error) {
        console.error("Error fetching product by ID:", error);
        throw new Error("Unable to fetch product details. Please try again later.");
    }
};

// Create a new product
export const postProduct = async (productData) => {
    try {
        return prisma.product.create({
            data: productData
        });
    } catch (error) {
        console.error("Error creating product:", error);
        throw new Error("Unable to create product. Please try again later.");
    }
};

// PRODUCTS TYPES
export const getProductCategories = async () =>{

    try {
        return await prisma.product_category.findMany({
            include: {
                products: true,
            },
        });

    } catch (error) {
        console.error("Error fetching product categories:", error);
        throw new Error("Unable to fetch product categories. Please try again later.");

    }
}

export const postProductCategorie = async (req, res) => {

    try {

        return await prisma.product_category.create({
            data: req.body,
        });
    } catch (error) {
        console.error("Error posting product categories:", error);
        throw new Error("Unable to fetch product categories. Please try again later.");
    }
}
// PRODUCT DATES
export const getProductDates =async () => {
    try {
    return await prisma.product_date.findMany({
        include: {
            products: true,
        },
    });
    } catch (error) {
        console.error("Error fetching product dates:", error);
        throw new Error("Unable to fetch product dates. Please try again later.");
    }
}

export const postProductDate = async (req, res) =>  {
    return await prisma.product_date.create({
        data: req.body,
    });
}
// PRODUCT FEATURES
//
// Fetch all product features with related data
export const getAllProdFeatures = async () => {
    try {
        return prisma.feature.findMany({
            include: {
                product_feature: {
                    include: {
                        product: true
                    }
                }
            }
        });
    } catch (error) {
        console.error("Error fetching all product features:", error);
        throw new Error("Unable to fetch product features. Please try again later.");
    }
};
