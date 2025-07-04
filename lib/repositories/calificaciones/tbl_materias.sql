-- 1) Tabla de materias
CREATE TABLE IF NOT EXISTS tbl_materias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(255) NOT NULL,
  codigo      VARCHAR(50)   NULL,
  descripcion TEXT          NULL,
  activo      ENUM('0','1') NOT NULL DEFAULT '1',
  UNIQUE KEY uk_codigo (codigo)
) COMMENT='Tabla que almacena las materias disponibles en el sistema educativo';

INSERT INTO tbl_materias (nombre, codigo, descripcion, activo) VALUES
  ('Matemáticas I',    'MAT101', 'Álgebra y geometría básica',        '1'),
  ('Programación I',    'PROG101','Introducción a la programación',   '1'),
  ('Historia Universal','HIST101','Principales eventos históricos',    '1');
