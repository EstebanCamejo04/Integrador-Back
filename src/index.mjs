import express from "express";
import productRoutes from "./routes/products.mjs";
import productDate from "./routes/productDate.mjs";
import productType from "./routes/productType.mjs";
import { authRouter } from "./auth/router.mjs";
import cors from "cors";
import cookieParser from "cookie-parser";

const app = express();

console.log("JWT_SECRET:", process.env.JWT_SECRET);

// Declaro que express va a estar a la "escucha" de JSONs
app.use(express.json());

// Configuro los encabezados de cors para permitir peticiones desde cualquier origen con un middleware
app.use(
  cors({
    origin: "http://localhost:5173", // Origen de tu frontend
    credentials: true, // Permitir el envío de cookies
  })
);

// Deshabilito el encabezado X-Powered.By: Express para mejorar la seguridad
app.disable("x-powered-by");

// Configuro middleware para decodificar las cookies
app.use(cookieParser());

// Enrutamiento para los productos
app.use("/api", productRoutes);
app.use("/api", productType);
app.use("/api", productDate);
app.use("/api", authRouter);

app.get("/", async (req, res) => {
  res.send("Hello world!");
});

//Puerto donde corre la app.
app.listen(3000);
console.log("Server on port ", 3000);
