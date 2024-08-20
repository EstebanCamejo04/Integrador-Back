import { prisma } from "../db.mjs";

const SECRET_KEY = process.env.JWT_SECRET;

export const findUserByEmail = async (email) => {
  return prisma.user.findUnique({
    where: { email },
    include: {
      role: true,
    },
  });
};

// Middleware para verificar si el usuario tiene un rol específico
function verifyRole(role) {
  return (req, res, next) => {
    // Obtengo el token
    const token = req.cookies.token;

    // Valido que obtuve un token
    if (!token) {
      return res
        .status(401)
        .json({ message: "Access denied. No token provided." });
    }

    try {
      const decoded = jwt.verify(token, SECRET_KEY);
      req.user = decoded; // Guardo los datos del usuario en req.user

      // Valido que el id del rol contenido en el token efectivamente sea el adecuado
      if (req.user.roleId !== role) {
        return res
          .status(403)
          .json({ message: `Access forbidden. Admin role required.` });
      }

      next(); // Permite el acceso a la ruta si el rol coincide
    } catch (error) {
      return res.status(401).json({ message: "Invalid token" });
    }
  };
}
