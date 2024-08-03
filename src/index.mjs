import express from 'express'
import productRoutes from "./routes/products.mjs"
const app = express()

app.use(express.json())

app.use("/api", productRoutes);


app.listen(3000)
console.log('Server on port ', 3000 )

