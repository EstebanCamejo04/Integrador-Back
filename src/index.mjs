import express from "express";
import productRoutes from "./routes/products.mjs";
import productDate from "./routes/productDate.mjs";
import productType from "./routes/productType.mjs";
import cors from "cors";
const app = express();

// Declaro que express va a estar a la "escucha" de JSONs
app.use(express.json());

// Configuro los encabezados de cors para permitir peticiones desde cualquier origen con un middleware
app.use(cors());

// Deshabilito el encabezado X-Powered.By: Express para mejorar la seguridad
app.disable("x-powered-by");

// Enrutamiento para los productos
app.use("/api", productRoutes);
app.use("/api", productType);
app.use("/api", productDate);

app.get("/", async (req, res) => {
  res.send("Hello world!");
});

//Puerto donde corre la app.
app.listen(3000);
console.log("Server on port ", 3000);
