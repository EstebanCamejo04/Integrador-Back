import { schedule } from "node-cron";
import { prisma } from "../db.mjs";

async function deleteExpiredOrInactiveTokens() {
  const now = new Date();
  try {
    const result = await prisma.token.deleteMany({
      where: {
        OR: [
          {
            expiresDate: {
              lt: now,
            },
          },
          {
            active: false,
          },
        ],
      },
    });
    console.log(`${result.count} tokens eliminados (expirados o inactivos)`);
  } catch (error) {
    console.error("Error eliminando tokens:", error);
  }
}

// Schedule the job to run every 6 hours
schedule("0 */6 * * *", () => {
  console.log(
    "Ejecutando job de eliminación de tokens expirados o inactivos..."
  );
  deleteExpiredOrInactiveTokens();
});
