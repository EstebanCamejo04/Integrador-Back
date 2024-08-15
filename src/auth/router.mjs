import { Router } from "express";
import { login, verifyToken } from "./service.mjs";

export const authRouter = Router();

authRouter.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: "Email and password are required" });
    }
    const token = await login(email, password);
        console.log("Token", token)
    res.json({ token });
  } catch (error) {
        console.log(error)
    res.status(401).json({ error: error.message });
  }
});
// Ruta protegida de ejemplo
authRouter.get('/protected', verifyToken, async (req, res) => {
    res.json({ message: 'Access granted', user: req.user });
});
