/*Queries that provide answers to the questions from all projects.*/
SELECT name FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-13';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE NOT name= 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
BEGIN;
  update animals
  set species = 'unspecified';
  ROLLBACK;

BEGIN;
  update animals
  set species = 'digimon' where name like '%mon';
  update animals
  set species = 'pokemon' where name not like '%mon';
  COMMIT;

BEGIN;
  DELETE from animals
  ROLLBACK;

BEGIN;
  DELETE FROM animals WHERE date_of_birth > '2022-01-01';
  SAVEPOINT delete_2022;
  UPDATE animals
  SET weight_kg = weight_kg * -1;
  ROLLBACK TO SAVEPOINT delete_2022;
  UPDATE animals
  SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
  COMMIT;