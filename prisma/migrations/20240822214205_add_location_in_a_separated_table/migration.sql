/*
  Warnings:

  - You are about to drop the column `location` on the `product` table. All the data in the column will be lost.
  - Added the required column `location_id` to the `product` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `product` DROP COLUMN `location`,
    ADD COLUMN `location_id` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `product_location` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `product_location`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
