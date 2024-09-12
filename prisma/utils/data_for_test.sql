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
(1, 'alice.smith@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Alice', 'Smith', 1234567890, 1),
(2, 'bob.johnson@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Bob', 'Johnson', 1234567891, 2),
(3, 'carol.williams@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Carol', 'Williams', 1234567892, 2),
(4, 'dave.jones@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Dave', 'Jones', 1234567893, 2),
(5, 'eve.brown@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Eve', 'Brown', 1234567894, 2),
(6, 'frank.davis@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Frank', 'Davis', 1234567895, 2),
(7, 'grace.miller@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Grace', 'Miller', 1234567896, 2),
(8, 'henry.garcia@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Henry', 'Garcia', 1234567897, 2),
(9, 'iris.martin@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'Iris', 'Martin', 1234567898, 2),
(10, 'john.lee@example.com', '$2b$10$tZLPmXylQR6lsgF5fm6pE.CV.Po2.988qC/y2CaHE/SLe9MtnwgC.', 'John', 'Lee', 1234567899, 2)
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

-- Insertar fechas en la tabla `date` si no existen
-- Asume que los IDs para las fechas serán 1, 2, 3 y 4
INSERT INTO date (id, date)
VALUES
(1, '2024-12-15 10:00:00'),
(2, '2024-12-20 09:00:00'),
(3, '2024-12-25 11:00:00'),
(4, '2024-12-30 14:00:00')
AS dates
ON DUPLICATE KEY UPDATE
    date = dates.date;

-- Insertar ubicaciones en la tabla `location` si no existen
-- Asume que los IDs para las ubicaciones serán 1, 2, 3 y 4
INSERT INTO location (id, name)
VALUES
(1, 'Cerro de los Burros'),
(2, 'Cerro Pan de Azúcar'),
(3, 'Cerro del Verdún'),
(4, 'Playa Las Grutas')
AS locations
ON DUPLICATE KEY UPDATE
    name = locations.name;

-- Insertar productos en la tabla `product` si no existen
-- Usa los IDs de categorías, fechas y ubicaciones ya insertados
-- Asume que los IDs para los productos serán 1, 2, 3, 4 y 5
INSERT INTO product (id, category_id, name, description, price, imageKey, available)
VALUES
(1, 1, 'Hamaca one day', 'Disfruta de la serenidad de pasar un día entero en nuestra hamaca "One Day", colgada entre cerros. Diseñada para ofrecerte máxima comodidad, esta hamaca es perfecta para relajarte mientras contemplas la belleza de la naturaleza. Fabricada con materiales de alta calidad, garantiza durabilidad y resistencia, haciendo que cada momento al aire libre sea inolvidable. Ya sea con un buen libro o simplemente disfrutando del paisaje, nuestra hamaca es el complemento ideal para tus escapadas. Regálate la experiencia de desconectar y sumérgete en la tranquilidad que solo la naturaleza puede ofrecer.', 1500, 'images/product1.jpg', TRUE),
(2, 2, 'Parque de juegos', 'Parques con juegos relacionados con el slackline y sus diferentes componentes como lo son las space net, las cintas con guía, las hamacas y las cintas de iniciación.', 2500, 'images/product2.jpg', TRUE),
(3, 3, 'Highline', 'Caminar descalzo o con calcetines en una cinta plana especial suspendida entre dos rocas o riscos, en un acantilado.', 2000, 'images/product3.jpg', TRUE),
(4, 4, 'Senderismo', 'El senderismo es una actividad recreativa y deportiva que implica caminar por senderos y rutas al aire libre, generalmente en entornos naturales como bosques, montañas y parques nacionales.', 3000, 'images/product4.jpg', TRUE),
(5, 4, 'Night shift Highline', 'Caminar descalzo o con calcetines en una cinta plana especial suspendida entre dos rocas o riscos, en un acantilado.', 3000, 'images/product5.jpg', TRUE)
AS products
ON DUPLICATE KEY UPDATE
    name = products.name,
    description = products.description,
    price = products.price,
    imageKey = products.imageKey,
    available = products.available;

-- Insertar características en la tabla `feature` si no existen
-- Asume que los IDs para las características serán 1 a 25
INSERT INTO feature (id, name, name_alias)
VALUES
(1, "Hammaca", "hmk"),
(2, "Relajación", "relax"),
(3, "Comodidad", "cmfd"),
(4, "Naturaleza", "ntrz"),
(5, "Vista panorámica", "vspn"),
(6, "Desconexión", "dscx"),
(7, "Diversión", "dvrn"),
(8, "Actividad física", "actf"),
(9, "Familia", "fml"),
(10, "Seguridad", "sgd"),
(11, "Aventura", "avnt"),
(12, "Adrenalina", "adrn"),
(13, "Desafío", "dsf"),
(14, "Equilibrio", "eqbr"),
(15, "Altura", "altr"),
(16, "Riesgo", "rsg"),
(17, "Exploración", "explr"),
(18, "Aire libre", "frair"),
(19, "Tranquilidad", "tranq"),
(20, "Ejercicio", "exrs"),
(21, "Aventura nocturna", "avnnt"),
(22, "Iluminación", "ilum"),
(23, "Suspenso", "susps"),
(24, "Noche", "noch"),
(25, "Emoción", "emoc")
AS features
ON DUPLICATE KEY UPDATE
    name = features.name,
    name_alias = features.name_alias;

-- Relación entre productos y características
-- Asume que los IDs de productos y características ya están definidos
INSERT INTO product_feature (product_id, feature_id)
VALUES
(1, 1), -- Hamaca one day tiene característica Hammaca
(1, 2), -- Hamaca one day tiene característica Relajación
(1, 3), -- Hamaca one day tiene característica Comodidad
(1, 4), -- Hamaca one day tiene característica Naturaleza
(2, 1), -- Parque de juegos tiene característica Hammaca
(2, 2), -- Parque de juegos tiene característica Relajación
(2, 3), -- Parque de juegos tiene característica Comodidad
(2, 4), -- Parque de juegos tiene característica Naturaleza
(2, 5), -- Parque de juegos tiene característica Vista panorámica
(2, 7), -- Parque de juegos tiene característica Diversión
(3, 1), -- Highline tiene característica Hammaca
(3, 2), -- Highline tiene característica Relajación
(3, 5), -- Highline tiene característica Vista panorámica
(3, 8), -- Highline tiene característica Actividad física
(3, 9), -- Highline tiene característica Familia
(4, 8), -- Senderismo tiene característica Actividad física
(4, 4), -- Senderismo tiene característica Naturaleza
(4, 19), -- Senderismo tiene característica Tranquilidad
(5, 11), -- Night shift Highline tiene característica Aventura
(5, 12), -- Night shift Highline tiene característica Adrenalina
(5, 13)  -- Night shift Highline tiene característica Desafío
AS product_features
ON DUPLICATE KEY UPDATE
    product_id = product_features.product_id,
    feature_id = product_features.feature_id;

-- Insertar fechas para productos en la tabla `product_date`
-- Asume que los IDs de productos y fechas ya están definidos
INSERT INTO product_date (product_id, date_id, slots)
VALUES
(1, 1, 8), -- Hamaca one day disponible en la fecha con ID 1
(1, 2, 8), -- Hamaca one day disponible en la fecha con ID 2
(2, 3, 8), -- Parque de juegos disponible en la fecha con ID 3
(3, 4, 8), -- Highline disponible en la fecha con ID 4
(4, 2, 8), -- Senderismo disponible en la fecha con ID 2
(5, 1, 8)  -- Night shift Highline disponible en la fecha con ID 1
AS product_dates
ON DUPLICATE KEY UPDATE
    product_id = product_dates.product_id,
    date_id = product_dates.date_id,
    slots = product_dates.slots;

-- Insertar ubicaciones para productos en la tabla `product_location`
-- Asume que los IDs de productos y ubicaciones ya están definidos
INSERT INTO product_location (product_id, location_id)
VALUES
(1, 1), -- Hamaca one day en ubicación con ID 1
(1, 2), -- Hamaca one day en ubicación con ID 2
(2, 3), -- Parque de juegos en ubicación con ID 3
(3, 4), -- Highline en ubicación con ID 4
(4, 1), -- Senderismo en ubicación con ID 1
(5, 2)  -- Night shift Highline en ubicación con ID 2
AS product_locations
ON DUPLICATE KEY UPDATE
    product_id = product_locations.product_id,
    location_id = product_locations.location_id;
