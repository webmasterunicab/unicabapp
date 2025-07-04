-- Tabla de menú - MySQL 8.0+
-- Archivo: tbl_menus.sql

DROP TABLE IF EXISTS tbl_menus;

-- Crear tabla de menú
CREATE TABLE IF NOT EXISTS tbl_menus (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    enlace VARCHAR(255) NOT NULL,
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar opciones del menú según la imagen
INSERT INTO tbl_menus (titulo, enlace, orden, activo) VALUES 
('Ajustar perfil', '/ajustar-perfil', 1, TRUE),
('Ir al aula virtual', '/aula-virtual', 2, TRUE),
('Manual de convivencia', '/manual-convivencia', 3, TRUE),
('Cambiar contraseña', '/cambiar-contrasena', 4, TRUE),
('Cerrar sesión', '/logout', 5, TRUE),
('Preguntas frecuentes', '/preguntas-frecuentes', 6, TRUE),
('Política y privacidad', '/politica-privacidad', 7, TRUE),
('Términos y condiciones', '/terminos-condiciones', 8, TRUE),
('Eliminar cuenta', '/eliminar-cuenta', 9, TRUE); 