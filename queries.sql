/*Queries that provide answers to the questions from all projects.*/

-- Select all animals whose name contains 'mon'
SELECT * FROM animals WHERE name Like '%mon'

--List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31'

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true and escape_attempts < 3 ;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts from animals  WHERE weight > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = true;

--Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg
SELECT * from animals WHERE weight >= 10.4 AND weight <=17.3;


BEGIN;

UPDATE animals
 SET species='unspecified'
WHERE species IS NULL;

ROLLBACK;

-- Inside a transaction:
BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name Like '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
 SET species='Pokemon'
WHERE species IS NULL;
-- Commit the transaction.
COMMIT;

-- Delete all records in a Transaction.
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;


-- Inside a transaction:
START TRANSACTION;
-- Delete all animals born after Jan 1st, 2022.

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT point1;

UPDATE animals
SET weight = weight * -1;


ROLLBACK to savepoint point1;


UPDATE animals
SET weight = weight * -1;
-- Commit transaction
COMMIT;



SELECT COUNT(*) FROM animals;

SELECT MIN(escape_attempts) FROM animals;

SELECT AVG(weight) FROM animals;

SELECT COUNT(neutered) FROM animals GROUP BY neutered;

SELECT  species,max(weight),min(weight) FROM animals GROUP BY species;

SELECT name, AVG(escape_attempts) FROM animals WHERE  date_of_birth> '1990-01-01' AND date_of_birth < '2000-12-31' GROUP BY name;

