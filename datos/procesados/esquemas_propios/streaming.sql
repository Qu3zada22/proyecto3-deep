CREATE TABLE `genres` (
  `genre_id` int NOT NULL COMMENT 'Identificador del género',
  `genre_name` varchar(40) NOT NULL COMMENT 'Nombre del género (Drama, Comedia, etc.)',
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de géneros audiovisuales';

CREATE TABLE `payments` (
  `payment_id` int NOT NULL COMMENT 'Identificador del pago',
  `subscription_id` int NOT NULL COMMENT 'Suscripción que se paga, referencia a subscriptions',
  `amount` decimal(10,2) NOT NULL COMMENT 'Monto cobrado en USD',
  `paid_at` datetime NOT NULL COMMENT 'Fecha y hora del cobro',
  `payment_method` enum('card','paypal','gift_card') NOT NULL COMMENT 'Medio de pago: tarjeta, PayPal o tarjeta de regalo',
  `status` enum('paid','failed','refunded') NOT NULL COMMENT 'Resultado del cobro: pagado, fallido o reembolsado',
  PRIMARY KEY (`payment_id`),
  KEY `subscription_id` (`subscription_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cobros mensuales asociados a las suscripciones';

CREATE TABLE `plans` (
  `plan_id` int NOT NULL COMMENT 'Identificador del plan de suscripción',
  `plan_name` varchar(40) NOT NULL COMMENT 'Nombre comercial del plan',
  `monthly_price` decimal(10,2) NOT NULL COMMENT 'Precio mensual del plan en USD',
  `max_screens` int NOT NULL COMMENT 'Número máximo de pantallas simultáneas permitidas',
  `video_quality` enum('SD','HD','4K') NOT NULL COMMENT 'Calidad de video máxima incluida en el plan',
  `has_ads` tinyint(1) NOT NULL COMMENT 'Indica si el plan incluye anuncios: 1 sí, 0 no',
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Planes de suscripción que ofrece la plataforma';

CREATE TABLE `ratings` (
  `rating_id` int NOT NULL COMMENT 'Identificador de la calificación',
  `user_id` int NOT NULL COMMENT 'Usuario que califica, referencia a users',
  `title_id` int NOT NULL COMMENT 'Título calificado, referencia a titles',
  `score` tinyint NOT NULL COMMENT 'Puntuación de 1 a 5 estrellas',
  `rated_at` datetime NOT NULL COMMENT 'Fecha y hora de la calificación',
  `review_text` varchar(255) DEFAULT NULL COMMENT 'Reseña escrita opcional; NULL si solo dejó estrellas',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `uq_user_title` (`user_id`,`title_id`),
  KEY `title_id` (`title_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`title_id`) REFERENCES `titles` (`title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Calificaciones que los usuarios dan a los títulos';

CREATE TABLE `subscriptions` (
  `subscription_id` int NOT NULL COMMENT 'Identificador de la suscripción',
  `user_id` int NOT NULL COMMENT 'Usuario titular de la suscripción, referencia a users',
  `plan_id` int NOT NULL COMMENT 'Plan contratado, referencia a plans',
  `start_date` date NOT NULL COMMENT 'Fecha de inicio de la suscripción',
  `end_date` date DEFAULT NULL COMMENT 'Fecha de finalización; NULL si sigue vigente',
  `status` enum('active','cancelled','expired','paused') NOT NULL COMMENT 'Estado de la suscripción: activa, cancelada, vencida o pausada',
  `auto_renew` tinyint(1) NOT NULL COMMENT 'Indica si se renueva automáticamente: 1 sí, 0 no',
  PRIMARY KEY (`subscription_id`),
  KEY `user_id` (`user_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Suscripciones de los usuarios a un plan; un usuario puede tener varias a lo largo del tiempo';

CREATE TABLE `title_genres` (
  `title_id` int NOT NULL COMMENT 'Título clasificado, referencia a titles',
  `genre_id` int NOT NULL COMMENT 'Género asignado, referencia a genres',
  PRIMARY KEY (`title_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `title_genres_ibfk_1` FOREIGN KEY (`title_id`) REFERENCES `titles` (`title_id`),
  CONSTRAINT `title_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Relación muchos a muchos entre títulos y géneros';

CREATE TABLE `titles` (
  `title_id` int NOT NULL COMMENT 'Identificador del título',
  `title_name` varchar(100) NOT NULL COMMENT 'Nombre del título (película o serie)',
  `title_type` enum('movie','series') NOT NULL COMMENT 'Tipo de título: película (movie) o serie (series)',
  `release_year` int NOT NULL COMMENT 'Año de estreno original',
  `duration_minutes` int DEFAULT NULL COMMENT 'Duración en minutos para películas; NULL en series',
  `seasons` int DEFAULT NULL COMMENT 'Número de temporadas para series; NULL en películas',
  `age_rating` varchar(5) NOT NULL COMMENT 'Clasificación por edad (G, PG, PG-13, R, TV-MA)',
  `origin_country` varchar(40) NOT NULL COMMENT 'País de producción del título',
  `added_date` date NOT NULL COMMENT 'Fecha en que el título se agregó al catálogo',
  PRIMARY KEY (`title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Catálogo de películas y series disponibles';

CREATE TABLE `users` (
  `user_id` int NOT NULL COMMENT 'Identificador del usuario',
  `full_name` varchar(80) NOT NULL COMMENT 'Nombre completo del usuario',
  `email` varchar(100) NOT NULL COMMENT 'Correo electrónico con el que se registró',
  `country` varchar(40) NOT NULL COMMENT 'País de residencia del usuario',
  `birth_date` date DEFAULT NULL COMMENT 'Fecha de nacimiento; NULL si el usuario no la indicó',
  `signup_date` datetime NOT NULL COMMENT 'Fecha y hora de registro en la plataforma',
  `is_active` tinyint(1) NOT NULL COMMENT 'Indica si la cuenta está activa: 1 sí, 0 no',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Usuarios registrados en la plataforma';

CREATE TABLE `views` (
  `view_id` int NOT NULL COMMENT 'Identificador de la sesión de reproducción',
  `user_id` int NOT NULL COMMENT 'Usuario que reprodujo el título, referencia a users',
  `title_id` int NOT NULL COMMENT 'Título reproducido, referencia a titles',
  `started_at` datetime NOT NULL COMMENT 'Fecha y hora de inicio de la reproducción',
  `minutes_watched` int NOT NULL COMMENT 'Minutos vistos en la sesión',
  `device` enum('tv','mobile','web','tablet') NOT NULL COMMENT 'Dispositivo usado: televisor, móvil, navegador web o tableta',
  `completed` tinyint(1) NOT NULL COMMENT 'Indica si se vio hasta el final: 1 sí, 0 no',
  PRIMARY KEY (`view_id`),
  KEY `user_id` (`user_id`),
  KEY `title_id` (`title_id`),
  CONSTRAINT `views_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `views_ibfk_2` FOREIGN KEY (`title_id`) REFERENCES `titles` (`title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Historial de reproducciones de los usuarios';
