-- Tabla de estudiantes - MySQL 8.0+
-- Archivo: tbl_estudiantes.sql

DROP TABLE IF EXISTS tbl_estudiantes;

-- Crear tabla de estudiantes
CREATE TABLE IF NOT EXISTS tbl_estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    foto VARCHAR(500) NOT NULL,
    email VARCHAR(255) DEFAULT NULL,
    carrera VARCHAR(255) DEFAULT NULL,
    semestre INT DEFAULT NULL,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar estudiantes de ejemplo (coinciden con AuthService)
INSERT INTO tbl_estudiantes (id, nombre, foto, email, carrera, semestre, activo) VALUES 
(1, 'Juan Pérez', 'assets/img/student1.jpg', 'juan.perez@unicab.edu.co', 'Ingeniería de Sistemas', 5, TRUE),
(2, 'María González', 'assets/img/student2.jpg', 'maria.gonzalez@unicab.edu.co', 'Administración de Empresas', 3, TRUE),
(3, 'Carlos Rodríguez', 'assets/img/student3.jpg', 'carlos.rodriguez@unicab.edu.co', 'Contaduría Pública', 7, TRUE),
(4, 'Ana López', 'assets/img/student4.jpg', 'ana.lopez@unicab.edu.co', 'Psicología', 2, TRUE);