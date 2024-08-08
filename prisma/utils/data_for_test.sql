-- Verifica si la base de datos 'fly_mountain' no existe
-- y si no existe, la crea
CREATE DATABASE IF NOT EXISTS fly_mountain;

-- Usa la base de datos 'fly_mountain'
USE fly_mountain;

-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
--
-- USERS
--
-- Insertar roles en la tabla `user_role` si no existen
-- Asume que los IDs para los roles serán 1 y 2
INSERT INTO user_role (id, role, role_description)
VALUES
(1, 'ADMIN', 'Administrator with full access'),
(2, 'USER', 'Regular user with limited access')
AS roles
ON DUPLICATE KEY UPDATE
    role_description = roles.role_description;

-- Insertar usuarios en la tabla `user` si no existen
-- Usa ON DUPLICATE KEY UPDATE para evitar duplicados, basado en la clave única `email`
-- Asume que los IDs de roles ya están insertados correctamente
INSERT INTO user (id, email, pass, name, lastname, phone, role_id)
VALUES
(1, 'alice.smith@example.com', 'hashed_password1', 'Alice', 'Smith', 1234567890, 1),
(2, 'bob.johnson@example.com', 'hashed_password2', 'Bob', 'Johnson', 1234567891, 2),
(3, 'carol.williams@example.com', 'hashed_password3', 'Carol', 'Williams', 1234567892, 2),
(4, 'dave.jones@example.com', 'hashed_password4', 'Dave', 'Jones', 1234567893, 2),
(5, 'eve.brown@example.com', 'hashed_password5', 'Eve', 'Brown', 1234567894, 2),
(6, 'frank.davis@example.com', 'hashed_password6', 'Frank', 'Davis', 1234567895, 2),
(7, 'grace.miller@example.com', 'hashed_password7', 'Grace', 'Miller', 1234567896, 2),
(8, 'henry.garcia@example.com', 'hashed_password8', 'Henry', 'Garcia', 1234567897, 2),
(9, 'iris.martin@example.com', 'hashed_password9', 'Iris', 'Martin', 1234567898, 2),
(10, 'john.lee@example.com', 'hashed_password10', 'John', 'Lee', 1234567899, 2)
AS basic_users
ON DUPLICATE KEY UPDATE
    pass = basic_users.pass,
    name = basic_users.name,
    lastname = basic_users.lastname,
    phone = basic_users.phone,
    role_id = basic_users.role_id;
    
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------
--
-- PRODUCTS
--
-- Insertar categorías de productos en la tabla `product_category` si no existen
-- Asume que los IDs para las categorías serán 1, 2, 3 y 4
INSERT INTO product_category (id, name, description)
VALUES
(1, 'Entrenamiento de Slack Line', 'Una experiencia completa para aprender y dominar el slackline en un entorno controlado y seguro. Ideal para principiantes y entusiastas.'),
(2, 'Paseo en las Sierras', 'Un recorrido fascinante por las sierras uruguayas, disfrutando de vistas panorámicas y la belleza natural de la región.'),
(3, 'Hamacas Tour', 'Tour guiado en hamacas por las sierras, disfrutando de la flora y fauna mientras te relajas en hamacas colgantes.'),
(4, 'Aventura en la Playa', 'Actividades recreativas y deportivas en la playa, incluyendo surf, volleyball y paseos en bote.')
AS categories
ON DUPLICATE KEY UPDATE
    name = categories.name,
    description = categories.description;

-- Insertar fechas de productos en la tabla `product_date` si no existen
-- Asume que los IDs para las fechas serán 1, 2, 3 y 4
INSERT INTO product_date (id, slots, date)
VALUES
(1, 8, '2024-12-15 10:00:00'),
(2, 8, '2024-12-20 09:00:00'),
(3, 8, '2024-12-25 11:00:00'),
(4, 8, '2024-12-30 14:00:00')
AS dates
ON DUPLICATE KEY UPDATE
    slots = dates.slots,
    date = dates.date;

-- Insertar productos en la tabla `product` si no existen
-- Usa los IDs de categorías y fechas ya insertados
-- Asume que los IDs para los productos serán 1, 2, 3 y 4
INSERT INTO product (id, category_id, price, product_date_id, location, available)
VALUES
(1, 1, 1500, 1, 'Cerro de los Burros', TRUE),
(2, 2, 2500, 2, 'Cerro Pan de Azúcar', TRUE),
(3, 3, 2000, 3, 'Cerro del Verdún', TRUE),
(4, 4, 3000, 4, 'Playa Las Grutas', TRUE)
AS products
ON DUPLICATE KEY UPDATE
    price = products.price,
    location = products.location,
    available = products.available;
