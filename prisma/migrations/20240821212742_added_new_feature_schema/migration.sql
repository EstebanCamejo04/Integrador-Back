-- CreateTable
CREATE TABLE `feature` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `name_alias` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `feature_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_feature` (
    `product_id` INTEGER NOT NULL,
    `feature_id` INTEGER NOT NULL,

    PRIMARY KEY (`product_id`, `feature_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `product_feature` ADD CONSTRAINT `product_feature_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_feature` ADD CONSTRAINT `product_feature_feature_id_fkey` FOREIGN KEY (`feature_id`) REFERENCES `feature`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
