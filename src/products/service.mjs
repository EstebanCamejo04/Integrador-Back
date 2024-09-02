import {
  S3Client,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
} from "@aws-sdk/client-s3";
import { prisma } from "../db.mjs";

import dotenv from "dotenv";
import multer from "multer";

dotenv.config();

// S3 Credentials
const bucket_name = process.env.BUCKET_NAME;
const bucket_region = process.env.BUCKET_REGION;
const access_key = process.env.ACCESS_KEY;
const secret_access_key = process.env.SECRET_ACCESS_KEY;

const s3 = new S3Client({
  credentials: {
    accessKeyId: access_key,
    secretAccessKey: secret_access_key,
  },
  region: bucket_region,
});

// Multer config for handling single Image
export const multerHandler = () => {
  const storage = multer.memoryStorage();

  console.log("paso por el multer");
  return multer({ storage }).single("image_url");
};

// PRODUCTS
//
// Create a new product
export const postProduct = async ({
  name,
  description,
  categoryId,
  price,
  available,
}) => {
  try {
    const newProduct = await prisma.product.create({
      data: {
        name,
        description,
        category: {
          connect: { id: categoryId },
        },
        price,
        available,
      },
    });
    return newProduct;
  } catch (error) {
    console.error("Error creating product:", error);
    throw new Error("Unable to create product. Please try again later.");
  }
};
// Fetch all products with related data
export const getAllProducts = async () => {
  try {
    return prisma.product.findMany({
      include: {
        category: true,
        product_date: true,
        product_location: true,
      },
    });
  } catch (error) {
    console.error("Error fetching all products:", error);
    throw new Error("Unable to fetch products. Please try again later.");
  }
};

// Serching  products
export const searchProducts = async (words, start, end) => {
  if (start && end) {
    start = new Date(start);
    end = new Date(end);
    start.setUTCHours(0, 0, 0, 0);
    end.setUTCHours(23, 59, 59, 999);
  }
  try {
    return await prisma.product.findMany({
      where: {
        AND: [
          {
            OR: [
              {
                name: {
                  contains: words,
                },
              },
              {
                description: {
                  contains: words,
                },
              },
              {
                category: {
                  name: {
                    contains: words,
                  },
                },
              },
              {
                product_location: {
                  some: {
                    location: {
                      name: {
                        contains: words,
                      },
                    },
                  },
                },
              },
            ],
          },
          start && end
            ? {
                product_date: {
                  some: {
                    date: {
                      date: {
                        gte: start,
                        lte: end,
                      },
                    },
                  },
                },
              }
            : {},
        ],
      },
      include: {
        category: true,
        product_date: {
          include: {
            date: true,
          },
        },
        product_location: {
          include: {
            location: true,
          },
        },
      },
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
        id: parseInt(id, 10),
      },
      include: {
        category: true,
        product_date: true,
        product_feature: {
          // Tabla Intermedia de caracteristicas
          include: {
            feature: true, //Incluir detalles de caracteristicas
          },
        },
      },
    });
  } catch (error) {
    console.error("Error fetching product by ID:", error);
    throw new Error("Unable to fetch product details. Please try again later.");
  }
};

// PRODUCTS TYPES
export const getProductCategories = async () => {
  try {
    return await prisma.product_category.findMany({
      include: {
        products: true,
      },
    });
  } catch (error) {
    console.error("Error fetching product categories:", error);
    throw new Error(
      "Unable to fetch product categories. Please try again later."
    );
  }
};

export const postProductCategorie = async (req, res) => {
  try {
    return await prisma.product_category.create({
      data: req.body,
    });
  } catch (error) {
    console.error("Error posting product categories:", error);
    throw new Error(
      "Unable to fetch product categories. Please try again later."
    );
  }
};
// PRODUCT DATES
export const getProductDates = async () => {
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
};

export const postProductDate = async (req, res) => {
  return await prisma.product_date.create({
    data: req.body,
  });
};
// PRODUCT FEATURES
//
// Fetch all product features with related data
export const getAllProdFeatures = async () => {
  try {
    return prisma.feature.findMany({
      include: {
        product_feature: {
          include: {
            product: true,
          },
        },
      },
    });
  } catch (error) {
    console.error("Error fetching all product features:", error);
    throw new Error(
      "Unable to fetch product features. Please try again later."
    );
  }
};
