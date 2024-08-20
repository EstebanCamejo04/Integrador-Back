import { Router } from "express";
import { login, verifyToken, signUp } from "./service.mjs";

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
authRouter.post("/sign-up", async (req, res, next) => {
  const { name, lastName, email, password, phone } = req.body;
  if (!name || !/^[a-zA-Z]+(\s[a-zA-Z]+)*$/.test(name)) {
    return res.status(400).json({
      error: "El nombre es obligatorio y no puede incluir números ni símbolos",
    });
  }
  if (!lastName || !/^[a-zA-Z]+(\s[a-zA-Z]+)*$/.test(lastName)) {
    return res.status(400).json({
      error:
        "El apellido es obligatorio y no puede incluir números ni símbolos",
    });
  }
  if (!email) {
    return res
      .status(400)
      .json({ error: "El correo electrónico es obligatorio" });
  }
  if (!/\S+@\S+\.\S+/.test(email)) {
    return res
      .status(400)
      .json({ error: "El correo electrónico no tiene un formato valido" });
  }
  if (!phone || !/^[0-9]+$/.test(phone)) {
    return res.status(400).json({
      error: "El número de teléfono es obligatorio y no puede contener letras",
    });
  }
  if (phone.length > 10) {
    return res
      .status(400)
      .json({ error: "El número de teléfono no debe exceder los 10 digitos" });
  }

  if (!password || password.length < 8) {
    return res.status(400).json({ error: "Contraseña insegura" });
  }

  try {
    const user = await signUp(name, lastName, email, password, phone);
    res.json({
      name: user.name,
      lastName: user.lastname,
      email: user.email,
      phone: user.phone,
    });
  } catch (error) {
    next(error);
  }
});
