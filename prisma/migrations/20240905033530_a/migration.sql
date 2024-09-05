-- DropForeignKey
ALTER TABLE `product_date` DROP FOREIGN KEY `product_date_date_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_date` DROP FOREIGN KEY `product_date_product_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_feature` DROP FOREIGN KEY `product_feature_feature_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_feature` DROP FOREIGN KEY `product_feature_product_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_location` DROP FOREIGN KEY `product_location_location_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_location` DROP FOREIGN KEY `product_location_product_id_fkey`;

-- AddForeignKey
ALTER TABLE `product_date` ADD CONSTRAINT `product_date_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_date` ADD CONSTRAINT `product_date_date_id_fkey` FOREIGN KEY (`date_id`) REFERENCES `date`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_feature` ADD CONSTRAINT `product_feature_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_feature` ADD CONSTRAINT `product_feature_feature_id_fkey` FOREIGN KEY (`feature_id`) REFERENCES `feature`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_location` ADD CONSTRAINT `product_location_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_location` ADD CONSTRAINT `product_location_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
