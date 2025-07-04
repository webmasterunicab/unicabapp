-- 2) Tabla de inscripciones (relación estudiante ↔ materia)
DROP TABLE IF EXISTS tbl_inscripciones;

CREATE TABLE IF NOT EXISTS tbl_inscripciones (
  id                 INT AUTO_INCREMENT PRIMARY KEY,
  estudiante_id      INT           NOT NULL COMMENT 'FK a tbl_estudiantes',
  materia_id         INT           NOT NULL COMMENT 'FK a tbl_materias',
  fecha_inscripcion  DATE          NOT NULL DEFAULT (CURRENT_DATE),
  activo             ENUM('0','1') NOT NULL DEFAULT '1',
  CONSTRAINT fk_insc_est FOREIGN KEY (estudiante_id)
    REFERENCES tbl_estudiantes(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_insc_mat FOREIGN KEY (materia_id)
    REFERENCES tbl_materias(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY uk_est_mat (estudiante_id, materia_id)
) COMMENT='Cada registro indica que un estudiante está inscrito en una materia';

INSERT INTO tbl_inscripciones (id, estudiante_id, materia_id, fecha_inscripcion, activo) VALUES
  (1, 1, 1, '2024-02-15', '1'),
  (2, 1, 2, '2024-02-16', '1');