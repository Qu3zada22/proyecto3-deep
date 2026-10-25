-- Esquema de una plataforma de video en streaming (nombres en inglés)
CREATE TABLE plans (
  plan_id INT NOT NULL COMMENT 'Identificador del plan de suscripción',
  plan_name VARCHAR(40) NOT NULL COMMENT 'Nombre comercial del plan',
  monthly_price DECIMAL(10,2) NOT NULL COMMENT 'Precio mensual del plan en USD',
  max_screens INT NOT NULL COMMENT 'Número máximo de pantallas simultáneas permitidas',
  video_quality ENUM('SD','HD','4K') NOT NULL COMMENT 'Calidad de video máxima incluida en el plan',
  has_ads TINYINT(1) NOT NULL COMMENT 'Indica si el plan incluye anuncios: 1 sí, 0 no',
  PRIMARY KEY (plan_id)
) COMMENT='Planes de suscripción que ofrece la plataforma';

CREATE TABLE users (
  user_id INT NOT NULL COMMENT 'Identificador del usuario',
  full_name VARCHAR(80) NOT NULL COMMENT 'Nombre completo del usuario',
  email VARCHAR(100) NOT NULL COMMENT 'Correo electrónico con el que se registró',
  country VARCHAR(40) NOT NULL COMMENT 'País de residencia del usuario',
  birth_date DATE NULL COMMENT 'Fecha de nacimiento; NULL si el usuario no la indicó',
  signup_date DATETIME NOT NULL COMMENT 'Fecha y hora de registro en la plataforma',
  is_active TINYINT(1) NOT NULL COMMENT 'Indica si la cuenta está activa: 1 sí, 0 no',
  PRIMARY KEY (user_id)
) COMMENT='Usuarios registrados en la plataforma';

CREATE TABLE subscriptions (
  subscription_id INT NOT NULL COMMENT 'Identificador de la suscripción',
  user_id INT NOT NULL COMMENT 'Usuario titular de la suscripción, referencia a users',
  plan_id INT NOT NULL COMMENT 'Plan contratado, referencia a plans',
  start_date DATE NOT NULL COMMENT 'Fecha de inicio de la suscripción',
  end_date DATE NULL COMMENT 'Fecha de finalización; NULL si sigue vigente',
  status ENUM('active','cancelled','expired','paused') NOT NULL COMMENT 'Estado de la suscripción: activa, cancelada, vencida o pausada',
  auto_renew TINYINT(1) NOT NULL COMMENT 'Indica si se renueva automáticamente: 1 sí, 0 no',
  PRIMARY KEY (subscription_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (plan_id) REFERENCES plans (plan_id)
) COMMENT='Suscripciones de los usuarios a un plan; un usuario puede tener varias a lo largo del tiempo';

CREATE TABLE payments (
  payment_id INT NOT NULL COMMENT 'Identificador del pago',
  subscription_id INT NOT NULL COMMENT 'Suscripción que se paga, referencia a subscriptions',
  amount DECIMAL(10,2) NOT NULL COMMENT 'Monto cobrado en USD',
  paid_at DATETIME NOT NULL COMMENT 'Fecha y hora del cobro',
  payment_method ENUM('card','paypal','gift_card') NOT NULL COMMENT 'Medio de pago: tarjeta, PayPal o tarjeta de regalo',
  status ENUM('paid','failed','refunded') NOT NULL COMMENT 'Resultado del cobro: pagado, fallido o reembolsado',
  PRIMARY KEY (payment_id),
  FOREIGN KEY (subscription_id) REFERENCES subscriptions (subscription_id)
) COMMENT='Cobros mensuales asociados a las suscripciones';

CREATE TABLE genres (
  genre_id INT NOT NULL COMMENT 'Identificador del género',
  genre_name VARCHAR(40) NOT NULL COMMENT 'Nombre del género (Drama, Comedia, etc.)',
  PRIMARY KEY (genre_id)
) COMMENT='Catálogo de géneros audiovisuales';

CREATE TABLE titles (
  title_id INT NOT NULL COMMENT 'Identificador del título',
  title_name VARCHAR(100) NOT NULL COMMENT 'Nombre del título (película o serie)',
  title_type ENUM('movie','series') NOT NULL COMMENT 'Tipo de título: película (movie) o serie (series)',
  release_year INT NOT NULL COMMENT 'Año de estreno original',
  duration_minutes INT NULL COMMENT 'Duración en minutos para películas; NULL en series',
  seasons INT NULL COMMENT 'Número de temporadas para series; NULL en películas',
  age_rating VARCHAR(5) NOT NULL COMMENT 'Clasificación por edad (G, PG, PG-13, R, TV-MA)',
  origin_country VARCHAR(40) NOT NULL COMMENT 'País de producción del título',
  added_date DATE NOT NULL COMMENT 'Fecha en que el título se agregó al catálogo',
  PRIMARY KEY (title_id)
) COMMENT='Catálogo de películas y series disponibles';

CREATE TABLE title_genres (
  title_id INT NOT NULL COMMENT 'Título clasificado, referencia a titles',
  genre_id INT NOT NULL COMMENT 'Género asignado, referencia a genres',
  PRIMARY KEY (title_id, genre_id),
  FOREIGN KEY (title_id) REFERENCES titles (title_id),
  FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
) COMMENT='Relación muchos a muchos entre títulos y géneros';

CREATE TABLE views (
  view_id INT NOT NULL COMMENT 'Identificador de la sesión de reproducción',
  user_id INT NOT NULL COMMENT 'Usuario que reprodujo el título, referencia a users',
  title_id INT NOT NULL COMMENT 'Título reproducido, referencia a titles',
  started_at DATETIME NOT NULL COMMENT 'Fecha y hora de inicio de la reproducción',
  minutes_watched INT NOT NULL COMMENT 'Minutos vistos en la sesión',
  device ENUM('tv','mobile','web','tablet') NOT NULL COMMENT 'Dispositivo usado: televisor, móvil, navegador web o tableta',
  completed TINYINT(1) NOT NULL COMMENT 'Indica si se vio hasta el final: 1 sí, 0 no',
  PRIMARY KEY (view_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (title_id) REFERENCES titles (title_id)
) COMMENT='Historial de reproducciones de los usuarios';

CREATE TABLE ratings (
  rating_id INT NOT NULL COMMENT 'Identificador de la calificación',
  user_id INT NOT NULL COMMENT 'Usuario que califica, referencia a users',
  title_id INT NOT NULL COMMENT 'Título calificado, referencia a titles',
  score TINYINT NOT NULL COMMENT 'Puntuación de 1 a 5 estrellas',
  rated_at DATETIME NOT NULL COMMENT 'Fecha y hora de la calificación',
  review_text VARCHAR(255) NULL COMMENT 'Reseña escrita opcional; NULL si solo dejó estrellas',
  PRIMARY KEY (rating_id),
  UNIQUE KEY uq_user_title (user_id, title_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id),
  FOREIGN KEY (title_id) REFERENCES titles (title_id)
) COMMENT='Calificaciones que los usuarios dan a los títulos';
