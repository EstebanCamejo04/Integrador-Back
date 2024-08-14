/*
  Warnings:

  - Added the required column `expiresDate` to the `token` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `token` ADD COLUMN `expiresDate` DATETIME(3) NOT NULL;
