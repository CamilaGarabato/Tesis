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

-- AGREGA LA COLUMNA imc_dx_oms CODIFICADA NUMERICAMENTE SEGUN CLASIFICACION OMS 2000
ALTER TABLE estado_nutricional 
ADD COLUMN dx_en_oms INTEGER 
GENERATED ALWAYS AS (
    CASE 
        WHEN imc < 18.5 THEN 1               -- Bajo peso
        WHEN imc BETWEEN 18.5 AND 24.9 THEN 2 -- Normal
        WHEN imc BETWEEN 25.0 AND 29.9 THEN 3 -- Sobrepeso
        WHEN imc BETWEEN 30.0 AND 34.9 THEN 4 -- Obesidad Grado I
        WHEN imc BETWEEN 35.0 AND 39.9 THEN 5 -- Obesidad Grado II
        WHEN imc >= 40.0 THEN 6               -- Obesidad Grado III
        ELSE NULL                             -- Para valores nulos/no válidos
    END
) STORED;

-- VISTAS PARA AGREGAR A LA TABLA PACEINTES 
CREATE OR REPLACE VIEW pacientes_vista AS
SELECT *,
  EXTRACT(YEAR FROM AGE(fecha_diagnostico, fecha_nacimiento)) AS edad_dx,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_diagnostico)) AS tiempo_desde_dx,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento)) AS edad_actual
FROM pacientes;
