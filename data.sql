/* Populate database with sample data. */
INSERT INTO animals(ID,name,
date_of_birth,escape_attempts,
neutered,weight_kg) VALUES (1,
'Agumon', '2020-02-03',0,true,10.23);

INSERT INTO animals(ID,name,
date_of_birth,escape_attempts,
neutered,weight_kg) VALUES (2,
'Gabumon', '2018-11-15',2,true,8);

INSERT INTO animals(ID,name,
date_of_birth,escape_attempts,
neutered,weight_kg) VALUES (3,
'Pikachu', '2021-06-07',1,false,15.04);

INSERT INTO animals(ID,name,
date_of_birth,escape_attempts,
neutered,weight_kg) VALUES (4,
'Devimon', '2017-05-12',5,true,11);

INSERT INTO animals VALUES (5, 'Charmander', '2020-02-08', 0, alse, 11, null),
(6, 'Plantmon', '2021-11-15', 2, true, 5.7, null),
(7, 'Squirtle', '1993-04-02', 3, false, 12.13, null),
(8, 'Angemon', '2005-06-07', 1, true, 45, null),
(9, 'Boarmon', '2005-06-07', 7, true, 20.4,null),
(10, 'Blossom', '1998-10-13', 3, true, 17, null),
(11, 'Ditto', '2022-05-14', 4, true, 22, null);

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name IN ('Agumon');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon','Pikachu');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon','Boarmon');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander','Squirtle','Blossom');

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon','Plantmon');

INSERT INTO vets(id,name,age,date_of_graduation)
VALUES (1,'William Tatcher',45,'2000-04-23'),
		(2,'Maisy Smith',26,'2019-06-17'),
		(3,'Stephanie Mendez',64,'1981-05-04'),
		(4,'Jack Harkness',38,'2008-08-06');

--Add Visits Table

INSERT INTO visits(id,
animals_id,vets_id,visit_date)
VALUES (1,9,1,'2020-05-24'),
       (2,9,3,'2020-07-22'),
       (3,8,4,'2021-02-02'),
       (4,7,2,'2020-06-05'),
       (5,7,2,'2020-03-08'),
       (6,7,2,'2020-05-14'),
       (7,10,3,'2021-05-04'),
       (8,1,4,'2021-02-24'),
       (9,2,2,'2019-12-21'),
       (10,2,1,'2020-08-10'),
       (11,2,2,'2021-04-07'),
       (12,3,3,'2019-09-29'),
       (13,4,4,'2020-10-03'),
       (14,4,4,'2020-11-04'),
       (15,5,2,'2019-06-24'),
       (16,5,2,'2019-05-15'),
       (17,5,2,'2020-02-27'),
       (18,5,2,'2020-03-08'),
       (19,5,3,'2020-05-24'),
       (20,5,1,'2021-06-11');
