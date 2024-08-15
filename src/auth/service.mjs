import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { prisma } from "../db.mjs";
import { findUserByEmail } from "../users/service.mjs";
import dotenv from "dotenv";
dotenv.config();

const SECRET_KEY = process.env.JWT_SECRET;
console.log("JWT_SECRET_svc:", process.env.JWT_SECRET);

export const login = async (email, password) => {
  const user = await findUserByEmail(email);
  if (!user) throw new Error("User not found");

  const isPasswordValid = await bcrypt.compare(password, user.pass);
  if (!isPasswordValid) throw new Error("Invalid credentials");

  const token = jwt.sign({ userId: user.id, email: user.email }, SECRET_KEY, {
    expiresIn: "1d",
  });

  const expiresDate = new Date(Date.now() + 24 * 60 * 60 * 1000); // Si el tiempo de expiración es 1 hora

  await prisma.token.create({
    data: {
      token,
      user: { connect: { id: user.id } },
      expiresDate: expiresDate,
    },
  });

  return token;
};

const findValidToken = async (token) => {
  const tokenRecord = await prisma.token.findFirst({
    where: { token },
  });
  return tokenRecord;
};

export const verifyToken = async (req, res, next) => {
  const authToken = req.headers.authorization;

  if (!authToken) {
    return res.status(401).json({ error: "Authorization header missing" });
  }

  const token = authToken.split(" ")[1]; // Extract token from "Bearer <token>"

  if (!(await findValidToken(token))) {
    return res.status(401).json({ error: "Invalid token" });
  }

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    req.user = decoded; // Añadir los datos del usuario al request
    next(); // Continuar con la siguiente función en la cadena
  } catch (error) {
    return res.status(401).json({ error: "Invalid token" });
  }
};
