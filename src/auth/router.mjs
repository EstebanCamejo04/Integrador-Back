import { Router } from "express";
import { login, verifySession } from "./service.mjs";

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

    // Almaceno el token y usuario en la cookie de sesión
    req.session.token = sessionData.token;
    req.session.user = sessionData.user;

    // Envio la info del usuario
    res.json({ user: sessionData.user });
  } catch (error) {
    console.log(error);
    res.status(401).json({ error: error.message });
  }
});
// Ruta protegida de ejemplo
authRouter.get("/protected", verifySession, async (req, res) => {
  res.json({ message: "Access granted", user: req.user });
});
