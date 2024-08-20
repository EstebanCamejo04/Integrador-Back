import { Router } from "express";

export const router = Router();

// Endpoint para validar que el usuario es admin
router.get("/checkAdmin", verifyRole(1), async (req, res) => {
  res.json({ message: "Role verified successfully." });
});

// Endpoint para validar que el usuario es user
router.get("/checkUser", verifyRole(2), async (req, res) => {
  res.json({ message: "Role verified successfully." });
});
