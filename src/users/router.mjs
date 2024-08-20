import { Router } from "express";
import { verifyRole } from "./service.mjs";

export const userRouter = Router();

// Endpoint para validar que el usuario es admin
userRouter.get("/checkAdmin", verifyRole(1), async (req, res) => {
  res.json({ message: "Role verified successfully." });
});

// Endpoint para validar que el usuario es user
userRouter.get("/checkUser", verifyRole(2), async (req, res) => {
  res.json({ message: "Role verified successfully." });
});
