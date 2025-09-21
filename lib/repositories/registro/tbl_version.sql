DROP TABLE IF EXISTS tbl_version;

CREATE TABLE tbl_version (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ultima_version varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci; 

INSERT INTO tbl_version ( ultima_version ) VALUES ('1.0.1+3');
