DROP TABLE IF EXISTS tbl_usuarios;

CREATE TABLE tbl_usuarios (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_rol int(11) UNSIGNED NOT NULL,
  nombre varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL UNIQUE,
  pass varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ciudadResidencia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  cumpleaños varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,-- Formato fecha
  activo int(11) NOT NULL,
  observaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  lugaresVisitados varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL, -- Campo ¿Qué lugares has viajado o te gustaría visitar?
  porqueUnicab varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL, -- Campo ¿Por qué elegiste UNICAB?
  fotoPerfil varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  aceptoTerminos int(11) NOT NULL,
  INDEX fk_tbl_usuarios_tbl_roles (id_rol),
  CONSTRAINT fk_tbl_usuarios_tbl_roles FOREIGN KEY (id_rol) REFERENCES tbl_roles (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_usuarios (id_rol,  nombre, correo, pass, ciudadResidencia, cumpleaños, activo, observaciones,
lugaresVisitados, porqueUnicab, fotoPerfil, aceptoTerminos) 
VALUES (3, 'Gregory Figueredo', 'gregory.figueredo@unicab.org', '1QAZxsw2#', 'Sogamoso', '', 1, '', '', '', '', 1),
(3, 'Cristian Ortiz', 'cortiz@unicab.org', '1QAZxsw2#', 'Bogotá', '', 1, '', '', '', '', 1),
(3, 'Miguel Angel Ortiz', 'miguelangelortiz@unicab.org', '1QAZxsw2#', 'Bogotá', '', 1, '', '', '', '', 1)
;