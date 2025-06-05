DROP TABLE IF EXISTS tbl_prueba;

CREATE TABLE tbl_prueba (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  descripcion varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_prueba (descripcion ) VALUES 
('Fundación'),
('Creativo'),
('Sistemas');