--✅MIS TABLAS DE SQL
CREATE TABLE pacientes (
	id_paciente SERIAL PRIMARY KEY,
	sexo SMALLINT NOT NULL CHECK (sexo IN (1, 2)),
	fecha_nacimiento DATE,
		fecha_diagnostico DATE,
	residencia character(100)
);

CREATE TABLE estado_nutricional (
	id_paciente INTEGER NOT NULL,
	fecha_medicion DATE NOT NULL,
	imc NUMERIC(4,2),
	dx_en_oms VARCHAR(30),
	albumina NUMERIC(4,2),
	hemoglobina NUMERIC(4,2),
	hematocrito NUMERIC(4,2),
	anemia BOOLEAN,
	
	FOREIGN KEY(id_paciente)
REFERENCES pacientes(id_paciente)
);

-- VISTAS PARA AGREGAR A LA TABLA PACEINTES 
CREATE OR REPLACE VIEW pacientes_vista AS
SELECT *,
  EXTRACT(YEAR FROM AGE(fecha_diagnostico, fecha_nacimiento)) AS edad_dx,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_diagnostico)) AS tiempo_desde_dx,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) AS edad_actual
FROM pacientes;
