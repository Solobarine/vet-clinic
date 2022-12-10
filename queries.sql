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


SELECT name, full_name FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name='Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT name, date_of_birth, neutered, weight, full_name, age FROM animals a INNER JOIN owners o ON  o.id = a.owner_id;

--How many animals are there per species?

SELECT COUNT(a.name), s.name FROM animals a INNER JOIN species s ON a.species_id = s.id GROUP BY s.name;

--List all Digimon owned by Jennifer Orwell.

SELECT name, full_name FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND name Like '%mon';

--List all animals owned by Dean Winchester that haven't tried to escape.

SELECT name, full_name FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' and escape_attempts=0;

--Who owns the most animals?

SELECT o.full_name , COUNT(a.owner_id) FROM animals a INNER JOIN owners o ON o.id = a.owner_id GROUP BY o.full_name;

--Who was the last animal seen by William Tatcher?

SELECT v.name,
        B.visit_date
from vets v
JOIN visits B ON B.vets_id = v.id
WHERE v.name = 'William Tatcher' LIMIT 1;

--How many different animals did Stephanie Mendez see?

SELECT B.name,
       COUNT(v.animals_id)
from visits v JOIN vets B ON v.vets_id = B.id
WHERE B.name = 'Stephanie Mendez'
GROUP by B.name;

--List all vets and their specialties, including vets with no specialties.
SELECT v.name,
      species.name
FROM vets v JOIN specializations s ON s.vet_id = v.id
RIGHT JOIN species ON species.id = s.spcs_id ;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT v.name,
        B.visit_date
FROM vets v JOIN visits B ON v.id= B.vets_id
WHERE v.name = 'Stephanie Mendez'
AND B.visit_date> '2020-04-01 00:00:00' AND B.visit_date < '2020-08-31 12:00:00';

--What animal has the most visits to vets?
SELECT
a.name,
        COUNT(v.vets_id)
FROM animals a
JOIN visits v ON a.id= v.vets_id
GROUP BY a.name LIMIT 1;

--What animal has the most visits to vets?
SELECT v.name,
        B.visit_date
from vets v
JOIN visits B ON B.vets_id = v.id
WHERE v.name = 'Maisy Smith' ORDER BY  B.visit_date ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.

SELECT vets.name,
        animals.name,
        escape_attempts,
        neutered,
        weight,
        age,
         animals.date_of_birth,
        date_of_graduation,
        visit_date FROM visits
JOIN vets ON vets.id= visits.vets_id
LEFT JOIN animals ON animals.id = visits.animals_id
ORDER BY visit_date DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?

SELECT
COUNT(visit_date)
FROM visits
JOIN vets ON vets_id = vets.id
LEFT JOIN specializations on spcs_id != vet_id
WHERE vets_id= 3;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT B.name,
species.name,
      Count(species_id)
FROM visits v JOIN vets B ON v.vets_id = B.id
LEFT JOIN animals ON animals.id= v.animals_id
LEFT JOIN specializations ON species_id = specializations.id
LEFT JOIN species ON animals.species_id= species.id
WHERE B.name = 'Maisy Smith'
GROUP BY B.name,species.name;
