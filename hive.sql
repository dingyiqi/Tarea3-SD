-- Crear tabla para almacenar dataset CSV --
CREATE EXTERNAL TABLE IF NOT EXISTS branch_traces (
    branch_addr STRING,
    branch_type STRING,
    taken INT,
    target STRING
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
LOCATION '/user/hadoop/csv';

-- Cargar datos del dataset a la tabla --
LOAD DATA INPATH '/user/hadoop/csv/branch_traces2.csv' INTO TABLE branch_traces;

-- Número total de registros --
SELECT COUNT(*) AS total_registros 
FROM branch_traces;

-- Frecuencia de cada tipo de branch --
SELECT branch_type, COUNT(*) AS freq 
FROM branch_traces 
GROUP BY branch_type;

-- Relación entre los tipos de branch y el valor 'taken' --
SELECT branch_type, taken, COUNT(*) AS freq 
FROM branch_traces 
GROUP BY branch_type, taken;

-- Proporción de registros 'taken' igual a 1 para cada tipo de branch --
SELECT branch_type, SUM(CASE WHEN taken = 1 THEN 1 ELSE 0 END) / COUNT(*) AS prop_taken 
FROM branch_traces 
GROUP BY branch_type;

-- Creación de tablas para almacenar los resultados --
CREATE TABLE branch_freq (
    branch_type STRING,
    freq INT
);

CREATE TABLE branch_taken_freq (
    branch_type STRING,
    taken INT,
    freq INT
);

CREATE TABLE branch_taken_prop (
    branch_type STRING,
    prop_taken DOUBLE
);

-- Almacenar conteos de frecuencias y relaciones analizadas en tablas --
INSERT INTO branch_freq 
SELECT branch_type, COUNT(*) AS freq 
FROM branch_traces 
GROUP BY branch_type;

INSERT INTO branch_taken_freq 
SELECT branch_type, taken, COUNT(*) AS freq 
FROM branch_traces 
GROUP BY branch_type, taken;

INSERT INTO branch_taken_prop 
SELECT branch_type, SUM(CASE WHEN taken = 1 THEN 1 ELSE 0 END) / COUNT(*) AS prop_taken 
FROM branch_traces 
GROUP BY branch_type;

-- Query de forma aleatoria con tiempo cercano a 1h --
SELECT * FROM branch_traces TABLESAMPLE (10000000 ROWS);









