/*
  Warnings:

  - You are about to drop the column `location_id` on the `product` table. All the data in the column will be lost.
  - You are about to drop the column `product_date_id` on the `product` table. All the data in the column will be lost.
  - The primary key for the `product_date` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `date` on the `product_date` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `product_date` table. All the data in the column will be lost.
  - You are about to drop the column `slots` on the `product_date` table. All the data in the column will be lost.
  - The primary key for the `product_location` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `product_location` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `product_location` table. All the data in the column will be lost.
  - Added the required column `date_id` to the `product_date` table without a default value. This is not possible if the table is not empty.
  - Added the required column `product_id` to the `product_date` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location_id` to the `product_location` table without a default value. This is not possible if the table is not empty.
  - Added the required column `product_id` to the `product_location` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `product` DROP FOREIGN KEY `product_location_id_fkey`;

-- DropForeignKey
ALTER TABLE `product` DROP FOREIGN KEY `product_product_date_id_fkey`;

-- AlterTable
ALTER TABLE `product` DROP COLUMN `location_id`,
    DROP COLUMN `product_date_id`,
    ADD COLUMN `image_url` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `product_date` DROP PRIMARY KEY,
    DROP COLUMN `date`,
    DROP COLUMN `id`,
    DROP COLUMN `slots`,
    ADD COLUMN `date_id` INTEGER NOT NULL,
    ADD COLUMN `product_id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`product_id`, `date_id`);

-- AlterTable
ALTER TABLE `product_location` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    DROP COLUMN `name`,
    ADD COLUMN `location_id` INTEGER NOT NULL,
    ADD COLUMN `product_id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`product_id`, `location_id`);

-- CreateTable
CREATE TABLE `date` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `slots` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `location` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `product_date` ADD CONSTRAINT `product_date_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_date` ADD CONSTRAINT `product_date_date_id_fkey` FOREIGN KEY (`date_id`) REFERENCES `date`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_location` ADD CONSTRAINT `product_location_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_location` ADD CONSTRAINT `product_location_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
