CREATE DATABASE IF NOT EXISTS Malchiki_i_devochki_na_udalenke_1;
USE Malchiki_i_devochki_na_udalenke_1;

CREATE TABLE Guests (GuestID INTEGER PRIMARY KEY, Name VARCHAR(50), Age INT, Gender VARCHAR(10), Continent VARCHAR(20), Country VARCHAR(50), PassportNumber VARCHAR(20));

CREATE TABLE Visits (VisitID INTEGER PRIMARY KEY, Room INTEGER, GuestID1 INTEGER, GuestID2 INTEGER, FOREIGN KEY (GuestID1) REFERENCES Guests(GuestID), FOREIGN KEY (GuestID2) REFERENCES Guests(GuestID));

INSERT INTO Guests (GuestID, Name, Age, Gender, Continent, Country, PassportNumber) VALUES (1, 'John Doe', 35, 'Male', 'Europe', 'UK', 'ABC123'), (2, 'Jane Smith', 28, 'Female', 'Europe', 'Germany', 'XYZ456'), (3, 'Akira Tanaka', 42, 'Male', 'Asia', 'Japan', 'JPN789'), (4, 'Lina Petrovna', 31, 'Female', 'Eurasia', 'Russia', 'RUS012'), (5, 'Miguel Hernandez', 25, 'Male', 'Europe', 'Spain', 'ESP345');

INSERT INTO Visits (VisitID, Room, GuestID1, GuestID2) VALUES (1, 101, 1, 2), (2, 102, 3, 4), (3, 103, 2, 5), (4, 104, 1, 3), (5, 105, 4, 5);


--Задание 0: все
SELECT * FROM Visits

--Задание 1:Все кто пили
SELECT DISTINCT Room FROM Visits as JOSTKA_Buxaut WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') OR GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender ='Male')) AND (GuestID1 NOT IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe') AND GuestID2 NOT IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe'));


-- Задание 2: Выбрать номера, в которых работают на удалёнке (двое гостей из Европы)
SELECT DISTINCT Room FROM Visits as Rabotaut_na_udalence WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe')) AND ((GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male')) OR (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female')));

-- Задание 3: Выбрать номера, в которых работают на удалёнке (мужчина и женщина)
SELECT DISTINCT Room FROM Visits as Rabotaut_na_udalence_odobraym WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female')) OR (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male'));
