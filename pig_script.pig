-- Cargar datos a Pig --
data = LOAD '/user/hadoop/csv/branch_traces2.csv' USING PigStorage(',') 
       AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Número total de registros --
total_registros = FOREACH (GROUP data ALL) GENERATE COUNT(data);
DUMP total_registros;

-- Frecuencia de cada tipo de branch --
branch_frequency = GROUP data BY branch_type;
branch_frequency = FOREACH branch_frequency GENERATE group, COUNT(data);
DUMP branch_frequency;

-- Relación entre los tipos de branch y el valor 'taken' --
taken_frequency = GROUP data BY (branch_type, taken);
taken_frequency = FOREACH taken_frequency GENERATE group, COUNT(data);
DUMP taken_frequency;

-- Query de forma aleatoria con tiempo cercano a 1h --
sample_data = SAMPLE data 10000000

