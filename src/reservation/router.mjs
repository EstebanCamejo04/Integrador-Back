import { Router } from "express";
import {
  createReservation,
  getAllReservations,
  getReservationById,
} from "./service.mjs";
import { verifyToken } from "../auth/service.mjs";

export const reservationRouter = Router();

// Endpoint para crear una nueva reserva
reservationRouter.post("/reservations", async (req, res) => {
  try {
    const { user_id, product_id, date_id, slots_requested } = req.body;

    // Validar si faltan campos obligatorios
    if (!user_id || !product_id || !date_id || !slots_requested) {
      return res.status(400).json({
        error: "User_id, product_id, date_id and slots_requested are required.",
      });
    }

    // Llamo al servicio para crear la reserva
    const newReservation = await createReservation(
      user_id,
      product_id,
      date_id,
      slots_requested
    );

    // Valido que la reserva se haya creado y exista
    if (!newReservation.success) {
      return res.status(newReservation.status).json({
        message: newReservation.message,
      });
    }

    // Enviar la respuesta al cliente con la reserva realizada
    return res.status(201).json({
      message: "Reservation done successfully!",
      reservation: newReservation.reservation,
    });
  } catch (error) {
    console.error("Error creating new reservation:", error);
    res.status(500).json({
      message: "Internal server error while processing the reservation",
    });
  }
});

// Endpoint para obtener todas las reservas
reservationRouter.get("/reservations", verifyToken, async (req, res) => {
  try {
    // Llamamos al servicio para obtener todas las reservas
    const reservations = await getAllReservations();

    // Enviamos la respuesta con las reservas obtenidas
    return res.status(200).json(reservations);
  } catch (error) {
    console.error("Error fetching all reservations:", error);
    res.status(500).json({
      message: "Internal server error while fetching all reservations",
    });
  }
});

// Endpoint para obtener una reserva por su ID
reservationRouter.get("/reservations/:id", verifyToken, async (req, res) => {
  try {
    const reservationId = parseInt(req.params.id, 10); // Convertir el ID a número

    // Valido que el ID es un número
    if (isNaN(reservationId)) {
      return res
        .status(400)
        .json({ message: "Invalid reservation ID. Must be a number." });
    }

    // Llamo al servicio para obtener la reserva
    const reservation = await getReservationById(reservationId);

    if (!reservation) {
      return res.status(404).json({ message: "Reservation not found" });
    }

    // Envio la respuesta con la reserva obtenida
    return res.status(200).json(reservation);
  } catch (error) {
    console.error("Error fetching reservation:", error);
    res.status(500).json({
      message: "Internal server error while fetching reservation",
    });
  }
});
