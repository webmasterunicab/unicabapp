DROP TABLE IF EXISTS tbl_comentarios_publicaciones;

CREATE TABLE tbl_comentarios_publicaciones (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_publicacion int(11) NOT NULL,
  comentario varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fechaComentario varchar(20) NOT NULL,
  estadoRevisionComentario int(2) NOT NULL DEFAULT 0,
  correo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;