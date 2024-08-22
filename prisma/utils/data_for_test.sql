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

-- Insertar locations en la tabla `product_location` si no existen
-- Asume que los IDs para las locations serán 1, 2, 3 y 4
INSERT INTO product_location (id, name)
VALUES
(1, 'Cerro de los Burros'),
(2, 'Cerro Pan de Azúcar'),
(3, 'Cerro del Verdún'),
(4, 'Playa Las Grutas')
AS locations
ON DUPLICATE KEY UPDATE
    name = locations.name;

-- Insertar productos en la tabla `product` si no existen
-- Usa los IDs de categorías y fechas ya insertados
-- Asume que los IDs para los productos serán 1, 2, 3 y 4
INSERT INTO product (id, category_id, name, description, price, product_date_id, location_id, available)
VALUES
(1, 1, "Hamaca one day", "Disfruta de la serenidad de pasar un día entero en nuestra hamaca 'One Day', colgada entre cerros. Diseñada para ofrecerte máxima comodidad, esta hamaca es perfecta para relajarte mientras contemplas la belleza de la naturaleza. Fabricada con materiales de alta calidad, garantiza durabilidad y resistencia, haciendo que cada momento al aire libre sea inolvidable. Ya sea con un buen libro o simplemente disfrutando del paisaje, nuestra hamaca es el complemento ideal para tus escapadas. Regálate la experiencia de desconectar y sumérgete en la tranquilidad que solo la naturaleza puede ofrecer.", 1500, 1, 1, TRUE),
(2, 2, "Parque de juegos", "Parques con juegos relacionados con el slackline y sus diferentes componentes como lo son las space net, las cintas con guía, las hamacas y las cintas de iniciación.",2500, 2, 2, TRUE),
(3, 3, "Highline", "Caminar descalzo o con calcetines en una cinta plana especial suspendida entre dos rocas o riscos, en un acantilado", 2000, 3, 3, TRUE),
(4, 4, "Senderismo", "El senderismo es una actividad recreativa y deportiva que implica caminar por senderos y rutas al aire libre, generalmente en entornos naturales como bosques, montañas y parques nacionales.", 3000, 4, 4, TRUE),
(5, 4, "Night shift Highline", "Caminar descalzo o con calcetines en una cinta plana especial suspendida entre dos rocas o riscos, en un acantilado", 3000, 4, 4, TRUE)
AS products
ON DUPLICATE KEY UPDATE
    name = products.name,
    description = products.description,
    price = products.price,
    available = products.available;



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


INSERT INTO product_feature (product_id, feature_id)
VALUES
-- Asociaciones para "Hamaca one day" (product_id = 1)
(1, 2),  -- Relajación
(1, 3),  -- Comodidad
(1, 4),  -- Naturaleza
(1, 5),  -- Vista panorámica
(1, 6),  -- Desconexión

-- Asociaciones para "Parque de juegos" (product_id = 2)
(2, 7),  -- Diversión
(2, 8),  -- Actividad física
(2, 9),  -- Familia
(2, 10), -- Seguridad
(2, 11), -- Aventura

-- Asociaciones para "Highline" (product_id = 3)
(3, 12), -- Adrenalina
(3, 13), -- Desafío
(3, 14), -- Equilibrio
(3, 15), -- Altura
(3, 16), -- Riesgo

-- Asociaciones para "Senderismo" (product_id = 4)
(4, 17), -- Exploración
(4, 18), -- Aire libre
(4, 19), -- Tranquilidad
(4, 20), -- Ejercicio
(4, 4),  -- Naturaleza

-- Asociaciones para "Night shift Highline" (product_id = 5)
(5, 21), -- Aventura nocturna
(5, 22), -- Iluminación
(5, 23), -- Suspense
(5, 24), -- Noche
(5, 25)  -- Emoción

AS product_features
ON DUPLICATE KEY UPDATE
    product_id = product_features.product_id,
    feature_id = product_features.feature_id;
