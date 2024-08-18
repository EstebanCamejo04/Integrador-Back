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
    // Envio token y info del usuario
    res.json(sessionData);
  } catch (error) {
    console.log(error);
    res.status(401).json({ error: error.message });
  }
});
// Ruta protegida de ejemplo
authRouter.get("/protected", verifyToken, async (req, res) => {
  res.json({ message: "Access granted", user: req.user });
});
authRouter.post("/sign-up", async (req, res) => {
  const { name, lastName, email, password } = req.body;
  if (!name || /\d/.test(name)) {
    return res.status(400).json({ error: "Invalid username" });
  }
  if (!lastName || /\d/.test(lastName)) {
    return res.status(400).json({ error: "Invalid lastname" });
  }
  if (!email || !/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
    return res.status(400).json({ error: "Invalid email" });
  }
  if (password.length < 8) {
    return res.status(400).json({ error: "Weak password" });
  }
  res.json({
    name,
    lastName,
    email,
  });
});
