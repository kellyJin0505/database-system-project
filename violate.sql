-- Constraints for primary keys

-- For Movie, "id" is primary key, we cannot insert a row with an id that already existed in Movie.id 
-- shows error since 272 has already existed in Movie.id
-- ERROR 1062 (23000): Duplicate entry '272' for key 'PRIMARY'
INSERT INTO Movie VALUES (272, 'Dying to Survive', 2018, 'PG-13', 'drama');

-- Same with Movie table, Actor.id is primary key, it cannot contains duplicates
-- shows error since 1 has already existed in Actor.id
-- ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
INSERT INTO Actor VALUES (1, "Tim", "Ye", "male", 1997-04-08, NULL);

-- Same with Movie table, Director.id is primary key, it cannot contains duplicates
-- shows error since 3141 has already existed in Director.id
-- ERROR 1062 (23000): Duplicate entry '3141' for key 'PRIMARY'
INSERT INTO Director VALUES (3141, "Tim", "Ye", 1997-04-08, NULL);


-- Referential integrity constraints

-- For MovieGenre, mid is referencing Movie id, the value of mid must be existed in Movie id
-- shows error since we do not have movie with mid = 1
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`MovieGenre`, CONSTRAINT `MovieGenre_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE UPDATE CASCADE)
INSERT INTO MovieGenre VALUES (1, 'Comedy');

-- For Sales, mid is referencing Movie id, the value of mid must be existed in Movie id
-- shows error since we do not have movie with mid = 1
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`Sales`, CONSTRAINT `Sales_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE UPDATE CASCADE)
INSERT INTO Sales VALUES (1, 245292, 3679380);

-- For MovieRating, mid is referencing Movie id, the value of mid must be existed in Movie id
-- shows error since we do not have movie with mid = 1
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`MovieRating`, CONSTRAINT `MovieRating_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE UPDATE CASCADE)
INSERT INTO MovieRating VALUES (1, 16, 10);

-- For MovieDirector, mid is referencing Movie id, did is referencing Director id, the values must already existed in Movie.id and Director.id
-- First query shows error since we do not have movie with id = 1, second query shows error since we do not have director with id = 1
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`MovieDirector`, CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE)
INSERT INTO MovieDirector VALUES (1, 2);
INSERT INTO MovieDirector VALUES (2, 1);

-- For MovieActor, mid is referencing Movie id, aid is referencing Actor id, the values must already existed in Movie.id and Actor.id
-- First query shows error since we do not have movie with id = 1, second query shows error since we do not have actor with id = 2
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`MovieActor`, CONSTRAINT `MovieActor_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE)
INSERT INTO MovieActor VALUES (1, 1, 'teacher');
INSERT INTO MovieActor VALUES (2, 2, 'teacher');

-- For Review, mid is referencing Movie id, the value of mid must be existed in Movie id
-- shows error since we do not have movie with mid = 1
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`TEST`.`Review`, CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`) ON DELETE CASCADE UPDATE CASCADE)
INSERT INTO Review VALUES ('Tim Ye', '2020-01-28 23:40:00', 1, 5, 'Excellent');

-- check CHECK constraints

-- violate check constraint by inserting movie id negative
-- shows error since movie id must be larger or equal to zero.
INSERT INTO Movie VALUES (-1, 'Arrival', 2016, 'PG', 'drama');

-- violate check constraint by inserting rating value of 'A'
-- shows error since ratings must either be null, 'G', 'PG', 'PG-13', 'R', 'NC-17','surrendere'
INSERT INTO Movie VALUES (1, 'Dying to Survive', 2018, 'A', 'drama');

-- violate check constraint by inserting rating value of 20
-- shows error since ratings must be an integer between 0 to 5
INSERT INTO Review VALUES ('Tim Ye', '2020-01-28 23:40:00', 2, 20, 'Excellent');

-- violate check constraint by inserting actor id negative
-- shows error since actor id must be larger or equal to zero.
INSERT INTO Actor VALUES (-19,"Aaron","Caroline","Female",19520807,\N);

-- violate check constraint by inserting director id negative
-- shows error since director id must be larger or equal to zero.
INSERT INTO Director VALUES (-10,"Buxton","Alex",19690607,\N);

-- violate check constraint by inserting rot value of 200
-- shows error since ratings must be an integer between 0 to 100
INSERT INTO MovieRating VALUES (1109,89,200);
