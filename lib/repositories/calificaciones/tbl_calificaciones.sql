DROP TABLE IF EXISTS tbl_calificaciones;

-- 3) Tabla de calificaciones (por inscripción y periodo)
CREATE TABLE IF NOT EXISTS tbl_calificaciones (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  inscripcion_id    INT           NOT NULL COMMENT 'FK a tbl_inscripciones',
  orden             INT           NOT NULL COMMENT 'Orden de la calificación',
  nota              DECIMAL(3,1)  NOT NULL COMMENT '0.0 a 5.0',
  periodo           VARCHAR(50)   NOT NULL COMMENT 'ej: 2024-1',
  fecha_publicacion DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  descripcion       TEXT          NULL COMMENT 'Observaciones de la nota',
  en_proceso            ENUM('0','1') NOT NULL DEFAULT '1',
  CONSTRAINT fk_calif_insc FOREIGN KEY (inscripcion_id)
    REFERENCES tbl_inscripciones(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY uk_insc_periodo (inscripcion_id, periodo)
) COMMENT='Notas que obtiene un estudiante en cada materia por periodo';

INSERT INTO tbl_calificaciones (inscripcion_id, orden, nota, periodo, descripcion, en_proceso) VALUES
  -- Para Matemáticas I (inscripción 1) 
  (1, 1, 4.2, 'Primer Periodo', 'Excelente desempeño en álgebra', '0'),
  (1, 2, 3.9, 'Segundo Periodo', 'Buen repaso de geometría',       '0'),
  (1, 3, 4.5, 'Tercer Periodo', 'Excelente desempeño en álgebra', '0'),
  (1, 4, 4.0, 'Cuarto Periodo', 'Buen repaso de geometría', '1'),
  -- Para Programación I (inscripción 2)
  (2, 1, 3.8, 'Primer Periodo', 'Manejo aceptable de sintaxis',   '0'),
  (2, 2, 4.1, 'Segundo Periodo', 'Algoritmos bien implementados', '0'),
  (2, 3, 4.5, 'Tercer Periodo', 'Excelente desempeño en álgebra', '0'),
  (2, 4, 4.0, 'Cuarto Periodo', 'Buen repaso de geometría', '1');