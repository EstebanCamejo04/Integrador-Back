-- CreateTable
CREATE TABLE "Product" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type_id" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "product_date_id" INTEGER NOT NULL,
    "location" TEXT NOT NULL,
    "avible" BOOLEAN NOT NULL,
    CONSTRAINT "Product_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Product_product_date_id_fkey" FOREIGN KEY ("product_date_id") REFERENCES "Product_date" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Product_date" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "slots" INTEGER NOT NULL,
    "date" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Type" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Product_product_date_id_key" ON "Product"("product_date_id");

-- CreateIndex
CREATE UNIQUE INDEX "Type_name_key" ON "Type"("name");
