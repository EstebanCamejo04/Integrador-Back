import express from "express";
import productRoutes from "./routes/products.mjs";
import productDate from "./routes/productDate.mjs";
import productType from "./routes/productType.mjs";
import { authRouter } from "./auth/router.mjs";
import cors from "cors";
import session from "express-session";
import cookieParser from "cookie-parser";

const app = express();

console.log("JWT_SECRET:", process.env.JWT_SECRET);

// Declaro que express va a estar a la "escucha" de JSONs
app.use(express.json());

// Configuro los encabezados de cors para permitir peticiones desde cualquier origen con un middleware
app.use(cors());

// Deshabilito el encabezado X-Powered.By: Express para mejorar la seguridad
app.disable("x-powered-by");

// Configuro middlewares de session cookies
app.use(cookieParser());
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false, //  La sesión solo se guardará si ha sido modificada
    saveUninitialized: false, // Evita crear y almacenar sesiones para usuarios anonimos
    cookie: {
      httpOnly: true, // No accesible desde JavaScript
      secure: true, // Solo se envian en HTTPS (se podría manejar para que entornos aplica)
      maxAge: 3600000, // 1 hora
    },
  })
);

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
