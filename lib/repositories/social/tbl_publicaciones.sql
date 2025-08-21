DROP TABLE IF EXISTS tbl_publicaciones;

CREATE TABLE tbl_publicaciones (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_rol int(2) NOT NULL,
  texto varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  imagen varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fechaPublicacion varchar(20) NOT NULL,
  estadoRevisionTexto int(2) NOT NULL DEFAULT 0,
  estadoRevisionMultimedia int(2) NOT NULL DEFAULT 0,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  meGusta int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;