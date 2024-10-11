-- Создание таблицы Guests с первичным ключом
CREATE TABLE IF NOT EXISTS Guests (GuestID INTEGER PRIMARY KEY, Name VARCHAR(50), Age INT, Gender VARCHAR(10), Continent VARCHAR(20), Country VARCHAR(50), PassportNumber VARCHAR(20));

-- Создание таблицы Visits с внешними ключами на таблицу Guests
CREATE TABLE Visits (VisitID INTEGER PRIMARY KEY, Room INTEGER, GuestID1 INTEGER, GuestID2 INTEGER, FOREIGN KEY (GuestID1) REFERENCES Guests(GuestID) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (GuestID2) REFERENCES Guests(GuestID) ON DELETE CASCADE ON UPDATE CASCADE);

-- Вставка данных в таблицу Guests
INSERT INTO Guests (GuestID, Name, Age, Gender, Continent, Country, PassportNumber) VALUES (1, 'John Doe', 35, 'Male', 'Europe', 'UK', 'ABC123'), (2, 'Jane Smith', 28, 'Female', 'Europe', 'Germany', 'XYZ456'), (3, 'Akira Tanaka', 42, 'Male', 'Asia', 'Japan', 'JPN789'), (4, 'Lina Petrovna', 31, 'Female', 'Eurasia', 'Russia', 'RUS012'), (5, 'Miguel Hernandez', 25, 'Male', 'Europe', 'Spain', 'ESP345'), (6, 'Naked Hernandez', 27, 'Male', 'Europe', 'Spain', '89089'), (7, 'Volk Hernandez', 29, 'Male', 'Asia', 'Russia', '3452'), (8, 'Volodya Hernandez', 19, 'Male', 'Europe', 'Spain', 'tyu6758'), (9, 'Sanya Hernandez', 40, 'Male', 'Asia', 'Russia', '23345233'), (10, 'Heydrih', 25, 'Male', 'Europe', 'Germany', 'NAZ1BATOV');

-- Каскадное удаление
-- DELETE FROM Guests WHERE 1
-- ALTER TABLE Guests DROP FOREIGN KEY 1

-- Вставка данных в таблицу Visits
INSERT INTO Visits (VisitID, Room, GuestID1, GuestID2) VALUES (1, 101, 1, 2), (2, 102, 3, 4), (3, 103, 2, 5), (4, 104, 1, 3), (5, 105, 4, 5);

-- Задание 0: Показать все визиты
SELECT * FROM Visits;

-- ОПТИМИЗИРОВАТЬ ГОВНО НИЖЕ

-- Задание 1: Все номера комнат, где гости мужского пола, не из Европы
SELECT DISTINCT Room FROM Visits AS JOSTKA_Buxaut WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') OR GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male')) AND (GuestID1 NOT IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe') AND GuestID2 NOT IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe'));

-- Задание 2: Номера, где работают на удалёнке (двое гостей из Европы одного пола)
SELECT DISTINCT Room FROM Visits AS Rabotaut_na_udalence WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Continent = 'Europe')) AND ((GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male')) OR (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female')));

-- Задание 3: Номера, где работают на удалёнке (мужчина и женщина)
SELECT DISTINCT Room FROM Visits AS Rabotaut_na_udalence_odobraym WHERE (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female')) OR (GuestID1 IN (SELECT GuestID FROM Guests WHERE Gender = 'Female') AND GuestID2 IN (SELECT GuestID FROM Guests WHERE Gender = 'Male'));
