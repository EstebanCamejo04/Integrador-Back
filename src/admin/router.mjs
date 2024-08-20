import { Router } from "express";
import { verifyToken } from "../auth/service.mjs";
import { checkRole, getAllUsers, updateUserRole } from "./service.mjs";

export const adminRouter = Router();

adminRouter.get("/users", verifyToken, checkRole(["ADMIN"]), async (req, res) => {
    try {
       const users = await getAllUsers(); 
        res.json(users);
    } catch (error) {
        res.send(500).json({error:"Failed to fetch all users."});
    }
})

adminRouter.put("/users/:id/change-role", verifyToken, checkRole(["ADMIN"]), async (req,res) => {

    const userId = parseInt(req.params.id, 10); // Recover the id from de params of the request.. (10) is for the base( or radix) wich is the numerical sistem.

    const { newRoleId} = req.body; // Id for the new role
    try {
        const updatedRole = await updateUserRole(userId, newRoleId);
        res.status(200).json({message: "Role updated succesfully", user:updatedRole})
    } catch (error) {
        res.status(400).json({message: "Error updating role", error: error.message})
    }
})
