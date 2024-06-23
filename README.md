# Tarea 3 Sistemas Distribuidos

## Obtención
Para obtener los archivos de este repositorio, se usa el siguiente comando:
```sh
git clone https://github.com/dingyiqi/Tarea3-SD
```

## Inicialización
Para inicializar el contenedor docker, se usa el siguiente comando:
```sh
docker-compose up 
```

## Acceso a la terminal del contenedor
Una vez inicializado el contenedor, se usa el siguiente comando para acceder a la terminal:
```sh
docker-compose exec hadoop bash
```
## Creación de directorio en contenedor
Una vez en la terminal del contenedor, se crea un directorio con el siguiente comando:
```sh
mkdir -p /usr/local/csv
```
## Creación de directorio en HDFS
Para crear un directorio en HDFS, se usa el siguiente comando:
```sh
hdfs dfs -mkdir -p /user/hadoop/csv
```

## Carga de dataset CSV local a contenedor
Para cargar el dataset CSV desde la computadora local al contenedor, se usa el siguiente código:
```sh
docker cp branch_traces2.csv idcontenedor:/usr/local/csv
```

## Carga de dataset CSV de contenedor a HDFS
Para cargar el dataset CSV desde el contenedor a HDFS, se usa el siguiente comando:
```sh
hdfs dfs -put /usr/local/csv/branch_traces2.csv /user/hadoop/csv
```

## Acceder a terminal de Hive
Para acceder a la terminal de Hive, se usa el siguiente comando:
```sh
hive
```

## Acceder a terminal de Pig
Para acceder a la terminal de Pig, se usa el siguiente comando:
```sh
pig
```
