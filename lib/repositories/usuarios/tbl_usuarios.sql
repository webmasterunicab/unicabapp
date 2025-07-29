DROP TABLE IF EXISTS tbl_usuarios;

CREATE TABLE tbl_usuarios (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_rol int(11) UNSIGNED NOT NULL,
  nombre varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  contrasenia varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ciudadRecidencia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  cumpleaños varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  activo int(11) NOT NULL,
  observaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  informacionAdicional varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
  INDEX fk_tbl_usuarios_tbl_roles (id_rol),
  CONSTRAINT fk_tbl_usuarios_tbl_roles FOREIGN KEY (id_rol) REFERENCES tbl_roles (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
