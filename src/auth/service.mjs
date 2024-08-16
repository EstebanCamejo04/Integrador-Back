import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import { findUserByEmail } from "../users/service.mjs";
import dotenv from "dotenv";
import { prisma } from "../db.mjs";
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
  const token = jwt.sign({ userId: user.id, email: user.email, role: user.role_id }, SECRET_KEY, {
    expiresIn: "1d",
  });

  // Eliminar la contraseña del objeto user antes de enviarlo al frontend
  const { pass, ...userWithoutPassword } = user;

  return { token, user: userWithoutPassword };
};

export const verifyToken = async (req, res, next) => {
  const authToken = req.headers.authorization;

  if (!authToken) {
    return res.status(401).json({ error: "Authorization header missing" });
  }

  const token = authToken.split(" ")[1]; // Extract token from "Bearer <token>"

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
        console.log(decoded)
    req.user = decoded; // Añadir los datos del usuario al request
    next(); // Continuar con la siguiente función en la cadena
  } catch (error) {
    return res.status(401).json({ error: "Invalid token" });
  }
};

export const checkRole = (role) => async (req, res, next) => {
    try {

        // Busco el usuario por su id e incluyo el rol
        const userRole = await prisma.user_role.findUnique({
            where: {id: req.user.userId},
        })
        console.log("userRole: ",userRole)

        if (role.includes(userRole.role)) {
           next()
        }else {
            res.status(401)
            res.send({error: 'Forbiden access.'})
        }
        
    } catch (error) {
        console.log(error)
       res.status(500).json({error: error.messge});
    }
     
}
