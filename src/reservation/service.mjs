import { prisma } from "../db.mjs";

// Servicio para crear una nueva reserva
export const createReservation = async (
  user_id,
  product_id,
  date_id,
  slots_requested,
  res
) => {
  try {
    // Consulto a la bd por el product_date
    const product_date = await prisma.product_date.findFirst({
      where: {
        product_id: product_id,
        date_id: date_id,
      },
    });

    // Verifico que esta fecha este disponible para este producto
    if (!product_date) {
      return {
        success: false,
        status: 404,
        message: "No available dates for this product",
      };
    }

    // Verifico si hay suficientes slots disponibles en product_date
    if (product_date.slots < slots_requested) {
      return {
        success: false,
        status: 400,
        message: "Not enough available slots for this product_date",
      };
    }

    // Verifico si el usuario ya tiene una reserva para el mismo product_date
    const existingReservation = await prisma.reservation.findFirst({
      where: {
        user_id: user_id,
        product_id: product_id,
        date_id: date_id,
      },
    });

    let newReservation;

    if (existingReservation) {
      // Si ya existe una reserva, actualizo la cantidad de slots reservados (en lugar de realizar una nueva reserva)
      newReservation = await prisma.reservation.update({
        where: { id: existingReservation.id },
        data: {
          slots_reserved: existingReservation.slots_reserved + slots_requested,
        },
      });
    } else {
      // Si no existe, creo una nueva reserva
      newReservation = await prisma.reservation.create({
        data: {
          user_id: user_id,
          product_id: product_id,
          date_id: date_id,
          slots_reserved: slots_requested,
        },
      });
    }

    // Actualizo los slots disponibles en product_date
    await prisma.product_date.update({
      where: {
        product_id_date_id: {
          product_id: product_id,
          date_id: date_id,
        },
      },
      data: { slots: { decrement: slots_requested } }, // Decrementar los slots disponibles
    });

    // Retorno el éxito y la reserva creada
    return {
      success: true,
      reservation: newReservation,
    };
  } catch (error) {
    console.error("Error creating reservation:", error);
    return {
      success: false,
      status: 500,
      message: "Internal server error while creating the reservation",
    };
  }
};

// Servicio para obtener todas las reservas
export const getAllReservations = async () => {
  try {
    // Obtenemos todas las reservas
    const reservations = await prisma.reservation.findMany({
      include: {
        user: true, // Incluye información del user
        product_date: {
          include: {
            product: true, // Incluye información del product
            date: true, // Incluye información del date
          },
        },
      },
    });

    // Retorno todas las reservas
    return reservations;
  } catch (error) {
    console.error("Error fetching all reservations:", error);
    throw new Error("Error fetching all reservations.");
  }
};

// Servicio para obtener una reserva por ID
export const getReservationById = async (reservationId) => {
  try {
    // Consultar la reserva con el ID específico
    const reservation = await prisma.reservation.findUnique({
      where: {
        id: reservationId,
      },
      include: {
        user: true, // Incluir información del user
        product_date: {
          include: {
            product: true, // Incluir información del product
            date: true, // Incluir información del date
          },
        },
      },
    });

    return reservation; // Retorno la reserva encontrada
  } catch (error) {
    console.error("Error fetching reservation by ID:", error);
    throw new Error("Error fetching reservation by ID.");
  }
};
