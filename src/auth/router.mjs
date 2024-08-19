import { Router } from "express";
import { login, verifyToken } from "./service.mjs";
import { checkRole } from "../admin/service.mjs";

export const authRouter = Router();

authRouter.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    // Valido que el mail o la contraseña no esten vacios
    if (!email || !password) {
      return res.status(400).json({ error: "Email and password are required" });
    }
    // Consulto la informacion
    const sessionData = await login(email, password);
    console.log("Session data: ", sessionData);
    // Envio token y info del usuario
    res.json(sessionData);
  } catch (error) {
    console.log(error);
    res.status(401).json({ error: error.message });
  }
});
// Ruta protegida de ejemplo
authRouter.get("/protected", verifyToken, checkRole(["ADMIN"]), async (req, res) => {
  res.json({ message: "Access granted", user: req.user });
});
