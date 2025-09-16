DROP TABLE IF EXISTS tbl_megusta_publicaciones;

CREATE TABLE tbl_megusta_publicaciones (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_publicacion int(11) NOT NULL,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  meGusta int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY (id_publicacion, correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;