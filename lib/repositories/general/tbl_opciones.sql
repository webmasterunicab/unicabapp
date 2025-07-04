-- Tabla de opciones - MySQL 8.0+
-- Archivo: tbl_opciones.sql
DROP TABLE IF EXISTS tbl_opciones;

-- Crear tabla de opciones (sin columna icono)
CREATE TABLE IF NOT EXISTS tbl_opciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    imagen VARCHAR(500) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Insertar las nuevas opciones (sin icono)
INSERT INTO tbl_opciones (nombre, imagen, direccion, orden, activo) VALUES 
('Calificaciones', 'assets/calificaciones.png', 'calificaciones/materias_screen', 1, TRUE),
('Observador', 'assets/observador.png', 'observador/observador_screen', 2, TRUE),
('Seguimientos y Acuerdos', 'assets/seguimientos.png', 'seguimientos/seguimientos_screen', 3, TRUE),
('Financiera', 'assets/financiera.png', 'financiera/financiera_screen', 4, TRUE),
('Comunidad', 'assets/comunidad.png', 'comunidad/comunidad_screen.dart', 5, TRUE);
