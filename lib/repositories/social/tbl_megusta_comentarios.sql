DROP TABLE IF EXISTS tbl_megusta_comentarios;

CREATE TABLE tbl_megusta_comentarios (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_publicacion int(11) NOT NULL,
  id_comentario int(11) NOT NULL,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  meGusta int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY (id_publicacion, id_comentario, correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;