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

  const token = jwt.sign({ userId: user.id }, SECRET_KEY, { expiresIn: "1h" });

  const expiresDate = new Date(Date.now() + 60 * 60 * 1000); // Si el tiempo de expiración es 1 hora

  await prisma.token.create({
    data: {
      token,
      user: { connect: { id: user.id } },
      expiresDate: expiresDate,
    },
  });

  return token;
};

export const verifyToken = async (token) => {
  try {
    return jwt.verify(token, SECRET_KEY);
  } catch (error) {
    throw new Error("Invalid token");
  }
};
