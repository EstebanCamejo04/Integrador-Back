-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `pass` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `lastname` VARCHAR(191) NOT NULL,
    `phone` INTEGER NOT NULL,
    `role_id` INTEGER NOT NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_role` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `role` VARCHAR(191) NOT NULL,
    `role_description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `user_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `user_role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
