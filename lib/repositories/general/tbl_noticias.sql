-- Tabla de noticias - MySQL 8.0+
-- Archivo: tbl_noticias.sql

DROP TABLE IF EXISTS tbl_noticias;

-- Crear tabla de noticias
CREATE TABLE IF NOT EXISTS tbl_noticias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(500) NOT NULL,
    texto TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    foto VARCHAR(500) DEFAULT NULL,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar solo las 2 noticias solicitadas
INSERT INTO tbl_noticias (titulo, texto, descripcion, foto, activo) VALUES 
('Conectados', 'Mantente siempre conectado con la comunidad universitaria. Accede a todas las herramientas digitales y recursos en línea disponibles para estudiantes.', 'Portal de conexión estudiantil con acceso a servicios digitales, comunicación y recursos académicos en línea.', 'assets/img/conectados.jpg', TRUE),
('Biblioteca', 'Nueva biblioteca digital con más de 10,000 recursos académicos disponibles las 24 horas del día. Accede a libros, revistas y material de estudio de alta calidad.', 'Los estudiantes pueden acceder a través del portal estudiantil con sus credenciales institucionales.', 'assets/img/biblioteca.jpg', TRUE); 