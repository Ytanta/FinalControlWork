DROP DATABASE IF EXISTS Human_Friends;

CREATE DATABASE Human_Friends;

USE Human_Friends;

CREATE TABLE Animals (
	id INT  AUTO_INCREMENT PRIMARY KEY,
	type_animals VARCHAR(50)
);

INSERT INTO `Animals` (`type_animals`) 
VALUES ('Pets'),
		('PackAnimals');	


CREATE TABLE Pets (
		id_pets INT AUTO_INCREMENT PRIMARY KEY,
		id_animal INT,
		name_pets VARCHAR(50),
		FOREIGN KEY (id_animal) REFERENCES Animals(id)ON DELETE CASCADE ON UPDATE CASCADE
);
		
 
INSERT INTO Pets (`name_pets`)
VALUES ('Dog'),
		('Cat'),
		('Hamster');
	
	
DROP TABLE IF EXISTS Dog;
CREATE TABLE Dog (
	  id_dog INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  pets_id INT ,
	  birthday date ,
	  commands varchar(50),	
	  FOREIGN KEY (pets_id) REFERENCES Pets(id_pets)ON DELETE CASCADE ON UPDATE CASCADE
 );


INSERT INTO `Dog` ( `name`, `pets_id`, `birthday`, `commands`)
VALUES ( 'Kiba', '1', '2020-01-01', 'Sit, Stay, Fetch'),
		( 'Fenrir', '1', '2020-01-10', 'Sit, Paw, Bark');

	
DROP TABLE IF EXISTS Cat;
CREATE TABLE Cat (
	  id_cat INT  AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  pets_id INT ,
	  birthday date ,
	  commands varchar(50),	
	  FOREIGN KEY (pets_id) REFERENCES Pets(id_pets)ON DELETE CASCADE ON UPDATE CASCADE
 );


INSERT INTO `Cat` ( `name`, `pets_id`, `birthday`, `commands`)
VALUES ( 'Thomas', '2', '2017-05-05', 'Sit, Pounce'),
		('Bigimot', '2', '2019-03-20', 'Meow, Scratch, Jump'),
		( 'Mufasa', '2', '2016-09-10', 'Sit, Pounce, Scratch');
	

DROP TABLE IF EXISTS Hamster;
CREATE TABLE Hamster (
	  id_hamster INT  AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  pets_id INT ,
	  birthday date ,
	  commands varchar(50), 	
	  FOREIGN KEY (pets_id) REFERENCES Pets(id_pets)ON DELETE CASCADE ON UPDATE CASCADE
 );


INSERT INTO `Hamster` ( `name`, `pets_id`, `birthday`, `commands`)
VALUES ( 'Rembo', '3', '2022-02-05', 'Roll, Spin'),
		('Persik', '3', '2023-08-16', 'Roll, Hide');
	
	
CREATE TABLE PackAnimals (
		id_packAnimals INT  AUTO_INCREMENT,
		id_animal INT,
		name_packAnimal VARCHAR(50),
		PRIMARY KEY (id_packAnimals),
		FOREIGN KEY (id_animal) REFERENCES Animals(id)ON DELETE CASCADE ON UPDATE CASCADE
		);
 
	
INSERT INTO PackAnimals (`name_packAnimal`)
VALUES ('Horse'),
		('Camel'),
		('Donkey');
	
	
DROP TABLE IF EXISTS Horse;
CREATE TABLE Horse (
	  id_horse INT  AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  packAnimal_id INT ,
	  birthday date ,
	  commands varchar(50), 	
	  FOREIGN KEY (packAnimal_id) REFERENCES PackAnimals(id_packAnimals)ON DELETE CASCADE ON UPDATE CASCADE
 );


INSERT INTO `Horse` (`name`, `packAnimal_id`, `birthday`, `commands`)
VALUES ('Spirit', '1', '2008-09-05', 'Trot, Canter, Gallop'),
		('BoJack', '1', '2010-08-17', 'Trot, Canter'),
        ('Gorbun', '1', '2012-12-06', 'Trot, Jump, Gallop');

DROP TABLE IF EXISTS Camel;
CREATE TABLE Camel (
	  id_camel INT  AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  packAnimal_id INT ,
	  birthday date ,
	  commands varchar(50), 	
	  FOREIGN KEY (packAnimal_id) REFERENCES PackAnimals(id_packAnimals)ON DELETE CASCADE ON UPDATE CASCADE
 );

INSERT INTO `Camel` (`name`, `packAnimal_id`, `birthday`, `commands`)
VALUES	('Dudde', '2', '2000-08-17', 'Walk, Carry Load'),
		('Men', '2', '2007-10-23', 'Walk, Sit'),
        ('Chel', '2', '2010-04-03', 'Walk, Run');
	
	
DROP TABLE IF EXISTS Donkey;
CREATE TABLE Donkey (
	  id_donkey INT  AUTO_INCREMENT PRIMARY KEY,
	  name varchar(20) ,
	  packAnimal_id INT ,
	  birthday date ,
	  commands varchar(50), 	
	  FOREIGN KEY (packAnimal_id) REFERENCES PackAnimals(id_packAnimals)ON DELETE CASCADE ON UPDATE CASCADE
 );
	

INSERT INTO `Donkey` (`name`, `packAnimal_id`, `birthday`, `commands`)
VALUES	('Kong', '3', '2007-11-11', 'Walk, Carry Load, Bray'),
		('King', '3', '2017-09-24', 'Walk, Bray, Kick');
  
  
  
DELETE  
FROM Camel
WHERE packAnimal_id = 2;
  
  
SELECT name, name_packAnimal AS type, birthday, commands
FROM Horse
JOIN PackAnimals ON PackAnimals.id_packAnimals = Horse.packAnimal_id
UNION
SELECT name, name_packAnimal AS type, birthday, commands
FROM Donkey
JOIN PackAnimals ON PackAnimals.id_packAnimals = Donkey.packAnimal_id ;


DROP TABLE IF EXISTS all_animals;
CREATE TEMPORARY TABLE all_animals AS 
SELECT *, 'Horse' as genus FROM Horse
UNION SELECT *, 'Donkey' AS genus FROM Donkey
UNION SELECT *, 'Dog' AS genus FROM Dog
UNION SELECT *, 'Cat' AS genus FROM Cat
UNION SELECT *, 'Hamster' AS genus FROM Hamster;

DROP TABLE IF EXISTS yang_animal;
CREATE TABLE yang_animal AS
SELECT name, birthday, commands, genus, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS Age_in_month
FROM all_animals WHERE birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
  
 SELECT h.name, h.birthday, h.commands, pa.name_packAnimal, ya.Age_in_month 
FROM Horse h
LEFT JOIN yang_animal ya ON ya.name = h.name
LEFT JOIN PackAnimals pa ON pa.id_packAnimals = h.packAnimal_id
UNION 
SELECT d.name, d.birthday, d.commands, pa.name_packAnimal, ya.Age_in_month 
FROM Donkey d 
LEFT JOIN yang_animal ya ON ya.name = d.name
LEFT JOIN PackAnimals pa ON pa.id_packAnimals = d.packAnimal_id
UNION  
SELECT c.name, c.birthday, c.commands, p.name_pets, ya.Age_in_month 
FROM Cat c
LEFT JOIN yang_animal ya ON ya.name = c.name
LEFT JOIN Pets p ON p.id_pets = c.pets_id
UNION  
SELECT d.name, d.birthday, d.commands, p.name_pets, ya.Age_in_month 
FROM Dog d
LEFT JOIN yang_animal ya ON ya.name = d.name
LEFT JOIN Pets p ON p.id_pets = d.pets_id
UNION  
SELECT hm.name, hm.birthday, hm.commands, p.name_pets, ya.Age_in_month 
FROM Hamster hm
LEFT JOIN yang_animal ya ON ya.name = hm.name
LEFT JOIN Pets p ON p.id_pets = hm.pets_id;
