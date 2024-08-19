import { prisma } from "../db.mjs";

//Middleware for checking the role
export const checkRole = (role) => async (req, res, next) => {
    try {

        // Busco el usuario por su id e incluyo el rol
        const userRole = await prisma.user_role.findUnique({
            where: {id: req.user.role}, // Recupero los datos del usuario
        })

        if (role.includes(userRole.role)) {
            next()
        }else {
            res.status(401)
            res.send({error: "You don't have access to this endpoint."})
        }

    } catch (error) {
        res.status(500).json({error: error.messge});
    }

}

// Middleware for fetching all users
export const getAllUsers = async () => {
        return await prisma.user.findMany({
            include:{role: true}
        })
}

// Middleware for updating a user role
export const updateUserRole = async (userId, newRoleId) => {
    return await prisma.user.update({
        where: {id: userId},
        data: {
            role: {connect: {id: newRoleId}}
        }
    })
} 
