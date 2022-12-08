/* Database schema to keep the structure of entire database. */


CREATE TABLE animals ( id INT, name VARCHAR(30), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL);

-- ALTER TABLE ANIMALS
ALTER TABLE animals ADD COLUMN species varchar(30);

--Creating Tables
CREATE TABLE owners( id INT, full_name VARCHAR(30), age INT, PRIMARY KEY(id));

CREATE TABLE species( id INT, name VARCHAR(30), PRIMARY KEY(id));

ALTER TABLE animals ADD PRIMARY KEY(id);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);
