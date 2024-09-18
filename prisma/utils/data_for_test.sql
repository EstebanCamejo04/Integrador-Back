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
(1, '2024-09-18 09:00:00'),
(2, '2024-09-25 11:00:00'),
(3, '2024-10-02 13:00:00'),
(4, '2024-10-09 14:00:00'),
(5, '2024-10-16 09:00:00'),
(6, '2024-10-23 17:00:00'),
(7, '2024-10-30 16:00:00'),
(8, '2024-11-06 15:00:00'),
(9, '2024-11-13 09:00:00'),
(10, '2024-11-20 11:00:00'),
(11, '2024-11-27 12:00:00'),
(12, '2024-12-04 09:00:00'),
(13, '2024-12-11 09:00:00'),
(14, '2024-12-18 09:00:00'),
(15, '2024-12-25 09:00:00'),
(16, '2025-01-01 09:00:00'),
(17, '2025-01-08 09:00:00'),
(18, '2025-01-15 09:00:00'),
(19, '2025-01-22 09:00:00'),
(20, '2025-01-29 09:00:00'),
(21, '2025-02-05 09:00:00'),
(22, '2025-02-12 09:00:00'),
(23, '2025-02-19 09:00:00'),
(24, '2025-02-26 09:00:00')
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
(3, 3, 'Highline', 'Disfruta de una experiencia única al caminar descalzo o con calcetines sobre una cinta plana especialmente diseñada, suspendida entre dos impresionantes rocas o riscos en un acantilado. Este emocionante recorrido ofrece una perspectiva espectacular de los paisajes circundantes mientras te desafía a mantener el equilibrio sobre la cinta en un entorno de altura. Ideal para los aventureros que buscan combinar la adrenalina con la belleza natural en un entorno seguro y controlado. Experimenta la sensación de caminar entre las alturas y disfruta de vistas inigualables mientras pones a prueba tu valentía y equilibrio.', 2000, 'images/product3.jpg', TRUE),
(4, 4, 'Senderismo', 'El senderismo es una actividad recreativa y deportiva que consiste en caminar a través de senderos y rutas en entornos naturales. Esta actividad se realiza generalmente en bosques, montañas, parques nacionales y otros espacios naturales, proporcionando una oportunidad para explorar la belleza del paisaje y disfrutar del aire libre.

Los senderos pueden variar en dificultad y longitud, desde rutas suaves y accesibles hasta desafiantes caminatas de montaña. El senderismo no solo promueve la actividad física y el bienestar, sino que también permite a los participantes conectarse con la naturaleza, observar la flora y fauna local, y experimentar la tranquilidad que ofrece el entorno natural.

Esta actividad puede ser realizada de forma individual o en grupo, y puede incluir diferentes niveles de complejidad, desde caminatas ligeras hasta excursiones más exigentes que requieren habilidades específicas y equipo adecuado. El senderismo es una forma excelente de mantenerse activo, mejorar la condición física y disfrutar de la serenidad de la naturaleza.', 3000, 'images/product4.jpg', TRUE),
(5, 4, 'Night shift Highline', 'es una emocionante experiencia que combina la adrenalina del highline con la magia de la noche. En esta actividad, los participantes caminan sobre una cinta plana suspendida entre dos rocas o acantilados en la oscuridad, con la única iluminación proveniente de luces especiales diseñadas para la ocasión.

A diferencia de las sesiones diurnas, donde el entorno natural y los paisajes se pueden observar con claridad, el Night Shift Highline ofrece una perspectiva única del paisaje nocturno. Las luces y la oscuridad crean una atmósfera surrealista que transforma la experiencia en un desafío tanto mental como físico. Caminar sobre la cuerda en estas condiciones requiere un mayor nivel de concentración, equilibrio y confianza, ya que la visibilidad limitada aumenta la complejidad del recorrido.

Además de la experiencia emocionante de caminar en la oscuridad, los participantes tienen la oportunidad de disfrutar de vistas nocturnas espectaculares, observando las estrellas y el paisaje iluminado de una manera que no es posible durante el día. Este evento está diseñado para los amantes de la aventura que buscan un reto adicional y una experiencia inolvidable en un entorno único.', 3000, 'images/product5.jpg', TRUE)
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
(1, 1, 8), -- Hamaca one day
(1, 4, 8),
(1, 17, 2),
(1, 8, 7),
(1, 7, 2),
(1, 5, 2),
(1, 10, 5), 
(2, 2, 8), -- Parque de juegos
(2, 5, 2),
(2, 4, 8),
(2, 8, 7),
(2, 17, 2),
(2, 11, 4),
(3, 3, 8), -- Highline
(3, 6, 8),
(3, 9, 6),
(3, 5, 2),
(3, 8, 7),
(3, 4, 8),
(3, 17, 2),
(3, 12, 3), 
(4, 13, 8),-- Senderismo 
(4, 16, 6),
(4, 4, 8)
(4, 19, 0),
(4, 17, 2),
(4, 5, 2),
(4, 8, 7),
(4, 22, 1), 
(5, 14, 5), -- Night shift Highline 
(5, 17, 2),
(5, 20, 1),
(5, 8, 7),
(5, 5, 2),
(5, 4, 8),
(5, 23, 7);  
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
