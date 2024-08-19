import { prisma } from "../db.mjs";

export const findUserByEmail = async (email) => {
  return prisma.user.findUnique({
    where: { email },
    include: {
      role: true,
    },
  });
};

export const createUser = async (name, lastName, email, password, phone) => {
  return prisma.user.create({
    data: {
      email: email,
      pass: password,
      name: name,
      lastname: lastName,
      phone: phone,
      role_id: 2, // definir rol por defecto
    },
  });
};
