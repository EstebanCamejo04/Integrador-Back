import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { findUserByEmail, createUser } from "../users/service.mjs";
import dotenv from "dotenv";
dotenv.config();

const SECRET_KEY = process.env.JWT_SECRET;
console.log("JWT_SECRET_svc:", process.env.JWT_SECRET);

export const login = async (email, password) => {
  // Buscar al usuario por email
  const user = await findUserByEmail(email);
  if (!user) throw new Error("User not found");

  // Validar la contraseña
  const isPasswordValid = await bcrypt.compare(password, user.pass);
  if (!isPasswordValid) throw new Error("Invalid credentials");

  // Generar JWT
  const token = jwt.sign(
    { userId: user.id, email: user.email, role: user.role_id },
    SECRET_KEY,
    {
      expiresIn: "1d",
    }
  );

  // Eliminar la contraseña del objeto user antes de enviarlo al frontend
  const { pass, ...userWithoutPassword } = user;

  return { token, user: userWithoutPassword };
};
export const signUp = async (name, lastName, email, password, phone) => {
  try {
    let user = await findUserByEmail(email);
    if (user) throw new Error("El usuario ya se encuentra registrado");

    const passHash = await bcrypt.hash(password, 10);
    user = await createUser(name, lastName, email, passHash, phone);
    if (!user)
      throw new Error(
        "Ha ocurrido un error inesperado, intenta de nuevo más tarde"
      );
    return user;
  } catch (error) {
    console.log("e" + error);

    throw new Error(
      "Ha ocurrido un error inesperado, intenta de nuevo más tarde"
    );
  }
};
// Middleware para verificar el token
export const verifyToken = async (req, res, next) => {
  // Obtengo el token de las cookies
  let token;

  token = req.cookies.token;

  // Valido que obtuve un token
  if (!token) {
    token = req.headers["authorization"]
      ?.split(" ")[1]
      .replace(/^"|"$/g, "")
      .trim();

    if (!token) {
      return res
        .status(401)
        .json({ message: "Access denied. No token provided." });
    }
  }

  // const token = authToken.split(" ")[1]; // Extract token from "Bearer <token>"

  try {
    const decoded = jwt.verify(authToken, SECRET_KEY);
    req.user = decoded; // Añadir los datos del usuario al request
    next(); // Continuar con la siguiente función en la cadena
  } catch (error) {
    return res.status(401).json({ error: "Invalid token" });
  }
};
