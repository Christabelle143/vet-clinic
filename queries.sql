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
SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts > 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) from animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-30' GROUP BY species;
SELECT animals.name, owner_id, full_name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owner_id = 4;
SELECT animals.name, species_id, species.name FROM animals JOIN species ON species.id = animals.species_id WHERE species_id = 1;
SELECT animals.name, owner_id, full_name FROM animals JOIN owners ON owners.id = animals.owner_id;
SELECT animals.name,species_id,species.name FROM animals JOIN species ON species.id = animals.species_id;
SELECT animals.name,owner_id,full_name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE name LIKE '%mon' AND owners.id = 2;
SELECT animals.name,owner_id,full_name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE escape_attempts = 0 AND owners.id = 5;
SELECT full_name, COUNT(owner_id) FROM owners JOIN animals on owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT (owner_id) desc limit 1;
SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 1 GROUP BY animals.name, visits.date_of_visit ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(DISTINCT(animals.name)) FROM visits JOIN animals ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';
SELECT vets.name as vet_name, species.name as SPECIES_NAME FROM species RIGHT JOIN specializations ON specializations.species_id = species.id RIGHT JOIN vets ON specializations.vets_id = vets.id;
SELECT * FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vets.name = 'Stephanie Mendez';
SELECT COUNT(animals.name), animals.name FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;
SELECT animals.name, vets.name, visits.date_of_visit FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit LIMIT 1;
SELECT visits.date_of_visit, animals.*, vets.* FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;
SELECT COUNT(*) FROM vets LEFT JOIN specializations ON specializations.species_id = vets.id LEFT JOIN species ON species.id = specializations.species_id LEFT JOIN visits ON vets.id = visits.animals_id WHERE species_id IS NULL;
SELECT COUNT(animals.id), animals.* FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Maisy Smith' GROUP BY animals.id ORDER BY COUNT(animals.id) DESC LIMIT 1;
