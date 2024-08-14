import { Router } from "express";
import { login } from "./service.mjs";

export const authRouter = Router();

authRouter.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ error: "Email and password are required" });
    }
    const token = await login(email, password);
    res.json({ token });
  } catch (error) {
    res.status(401).json({ error: error.message });
  }
});
