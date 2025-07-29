DROP TABLE IF EXISTS tbl_roles;

CREATE TABLE tbl_roles (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  rol varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  visible int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci; 
INSERT INTO tbl_roles ( rol ,  visible ) VALUES ('Estudiante', 1);
INSERT INTO tbl_roles ( rol ,  visible ) VALUES ('Acudiente', 1);
INSERT INTO tbl_roles ( rol ,  visible ) VALUES ('Super Usuario', 0);
INSERT INTO tbl_roles ( rol ,  visible ) VALUES ('Empleado Unicab', 1);
INSERT INTO tbl_roles ( rol ,  visible ) VALUES ('Docente', 1);
