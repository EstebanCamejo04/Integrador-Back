import express from 'express'
import productRoutes from "./routes/products.mjs"
import productDate from "./routes/productDate.mjs"
import productType from "./routes/productType.mjs"
const app = express()

// Declaro que express va a estar a la "escucha" de JSONs
app.use(express.json())

// Enrutamiento para los productos
app.use("/api", productRoutes);
app.use("/api", productType);
app.use("/api", productDate);


//Puerto donde corre la app.
app.listen(3000)
console.log('Server on port ', 3000 )

