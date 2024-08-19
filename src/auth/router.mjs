import { Router } from "express";
import { login, verifyToken } from "./service.mjs";

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

    const cookieConfig = {
      httpOnly: true, // Protege contra XSS
      secure: false, // Solo en HTTPS si está en producción
      maxAge: 3600000, // Expiración de la cookie
    };

    // Configuro la cookie
    res.cookie("token", sessionData.token, cookieConfig);

    // Envio la info del usuario
    res.json({ user: sessionData.user });
  } catch (error) {
    console.log(error);
    res.status(401).json({ error: error.message });
  }
});
// Ruta protegida de ejemplo
authRouter.get("/protected", verifyToken, async (req, res) => {
  res.json({ message: "Access granted", user: req.user });
});
