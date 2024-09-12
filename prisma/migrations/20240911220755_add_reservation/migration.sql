/*
  Warnings:

  - You are about to drop the column `slots` on the `date` table. All the data in the column will be lost.
  - Added the required column `slots` to the `product_date` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `date` DROP COLUMN `slots`;

-- AlterTable
ALTER TABLE `product_date` ADD COLUMN `slots` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `reservation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `date_id` INTEGER NOT NULL,
    `slots_reserved` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `reservation` ADD CONSTRAINT `reservation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation` ADD CONSTRAINT `reservation_product_id_date_id_fkey` FOREIGN KEY (`product_id`, `date_id`) REFERENCES `product_date`(`product_id`, `date_id`) ON DELETE CASCADE ON UPDATE CASCADE;
