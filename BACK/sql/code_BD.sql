DROP DATABASE IF EXISTS `app_raices`;
CREATE DATABASE IF NOT EXISTS `app_raices`;
USE `app_raices`;

-- Tabla de Usuarios
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  profile_picture_url VARCHAR(255),
  language_preference VARCHAR(50), -- Idioma preferido para aprender
  native_language VARCHAR(50), -- Idioma nativo
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (username),  -- Índice para optimizar la búsqueda de usuarios por nombre de usuario
  INDEX (email)  -- Índice para optimizar la búsqueda de usuarios por correo electrónico
);

-- Tabla de Idiomas
CREATE TABLE languages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  NAME VARCHAR(100) NOT NULL UNIQUE, -- Nombre del idioma
  CODE VARCHAR(10) NOT NULL, -- Código del idioma (por ejemplo, "en" para inglés)
  DESCRIPTION TEXT, -- Descripción breve del idioma
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (CODE)  -- Índice para optimizar la búsqueda de idiomas por código
);

-- Tabla de Lecciones
CREATE TABLE lessons (
  id INT AUTO_INCREMENT PRIMARY KEY,
  language_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  DESCRIPTION TEXT,
  LEVEL ENUM('beginner', 'intermediate', 'advanced') NOT NULL, -- Nivel de dificultad
  lesson_type ENUM('reading', 'writing', 'speaking', 'listening') NOT NULL, -- Tipo de lección
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (language_id) REFERENCES languages(id) ON DELETE CASCADE,
  INDEX (language_id)  -- Índice para optimizar la búsqueda de lecciones por idioma
);

-- Tabla de Ejercicios
CREATE TABLE exercises (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lesson_id INT NOT NULL,
  question TEXT NOT NULL, -- Pregunta o ejercicio
  correct_answer TEXT NOT NULL, -- Respuesta correcta
  answer_choices TEXT, -- Opciones de respuesta (si es un tipo de opción múltiple)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  INDEX (lesson_id)  -- Índice para optimizar la búsqueda de ejercicios por lección
);

-- Tabla de Progreso de los Usuarios
CREATE TABLE user_progress (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_id INT NOT NULL,
  score DECIMAL(5, 2), -- Puntaje en la lección (puede ser porcentaje o puntos)
  completed_at TIMESTAMP, -- Fecha y hora de la finalización de la lección
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  INDEX (user_id, lesson_id)  -- Índice para optimizar la búsqueda del progreso de un usuario en una lección
);

-- Tabla de Resultados de Ejercicios
CREATE TABLE exercise_results (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  exercise_id INT NOT NULL,
  user_answer TEXT, -- Respuesta proporcionada por el usuario
  correct BOOLEAN, -- Si la respuesta es correcta
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE,
  INDEX (user_id, exercise_id)  -- Índice para optimizar la búsqueda de resultados de ejercicios por usuario y ejercicio
);

-- Tabla de Comentarios y Retroalimentación
CREATE TABLE feedback (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_id INT,
  exercise_id INT,
  feedback TEXT NOT NULL,
  rating INT NOT NULL, -- Calificación de 1 a 5
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE,
  INDEX (user_id, lesson_id, exercise_id)  -- Índice para optimizar la búsqueda de comentarios por usuario, lección o ejercicio
);

-- Tabla de Amigos o Conexiones
CREATE TABLE friends (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  STATUS ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id, friend_id)  -- Índice para optimizar la búsqueda de amistades entre usuarios
);

-- Tabla de Notificaciones
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id)  -- Índice para optimizar la búsqueda de notificaciones por usuario
);

-- Tabla de Log de Actividades de Usuario
CREATE TABLE user_activity_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  activity_type ENUM('login', 'lesson_started', 'lesson_completed', 'exercise_answered', 'feedback_submitted') NOT NULL,
  activity_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id, activity_type)  -- Índice para optimizar la búsqueda de actividades por usuario y tipo
);

-- Tabla de Recompensas
CREATE TABLE rewards (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  reward_type ENUM('badge', 'level', 'certificate') NOT NULL,
  DESCRIPTION TEXT,
  earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id)  -- Índice para optimizar la búsqueda de recompensas por usuario
);

-- Tabla de Niveles de Usuario
CREATE TABLE user_levels (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  level_name VARCHAR(255) NOT NULL, -- Nombre del nivel (por ejemplo, "Beginner", "Intermediate")
  points INT NOT NULL, -- Puntos acumulados por el usuario
  achieved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id, level_name)  -- Índice para optimizar la búsqueda de niveles de usuario
);

-- Tabla de Configuración de la Aplicación
CREATE TABLE app_settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  setting_name VARCHAR(255) NOT NULL,
  setting_value TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (setting_name)  -- Índice para optimizar la búsqueda de configuraciones por nombre
);

-- Tabla de Historial de Lecciones de Usuario
CREATE TABLE user_lesson_history (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_id INT NOT NULL,
  progress DECIMAL(5, 2), -- Progreso de la lección (porcentaje completado)
  start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_time TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  INDEX (user_id, lesson_id)  -- Índice para optimizar la búsqueda del historial de lecciones por usuario y lección
);

-- Tabla de Compras en la Aplicación
CREATE TABLE in_app_purchases (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  purchase_type ENUM('lesson', 'premium', 'currency') NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id, purchase_type)  -- Índice para optimizar la búsqueda de compras por usuario y tipo
);

-- Tabla de Sistema de Feedback de la Comunidad
CREATE TABLE community_feedback (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  feedback_type ENUM('bug_report', 'suggestion', 'general_feedback') NOT NULL,
  message TEXT NOT NULL,
  STATUS ENUM('new', 'reviewed', 'resolved') DEFAULT 'new',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX (user_id, feedback_type)  -- Índice para optimizar la búsqueda de feedback por usuario y tipo
);

-- Tabla de Videos y Recursos Adicionales
CREATE TABLE video_resources (
  id INT AUTO_INCREMENT PRIMARY KEY,
  lesson_id INT NOT NULL,
  video_url TEXT NOT NULL,
  DESCRIPTION TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE,
  INDEX (lesson_id)  -- Índice para optimizar la búsqueda de recursos por lección
);
