/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species VARCHAR(50)
);
CREATE TABLE owners( id SERIAL PRIMARY KEY, full_name VARCHAR(50), age INT);
CREATE TABLE species( id SERIAL PRIMARY KEY, name VARCHAR(50));
CREATE SEQUENCE animals_id_seq owned BY animals.id;
ALTER TABLE ANIMALS ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');
SELECT SETVAL(pg_get_serial_sequence('animals', 'id'), max(id)) FROM animals;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);
CREATE TABLE vets( id SERIAL PRIMARY KEY, name VARCHAR(50), age INT, date_of_graduation DATE);
CREATE TABLE specializations( id SERIAL PRIMARY KEY, species_id INT, vets_id INT, FOREIGN KEY(species_id) REFERENCES species (id), FOREIGN KEY(vets_id) REFERENCES vets(id));
CREATE TABLE visits( id SERIAL PRIMARY KEY, animals_id INT, vets_id INT, date_of_visit DATE, FOREIGN KEY(animals_id) REFERENCES animals (id), FOREIGN KEY(vets_id) REFERENCES vets (id));