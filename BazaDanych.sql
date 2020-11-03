-- $$$$$$$$$$$$$$$$$$$$$
--     FINANSE KLUBU
--	   PI£KARSKIEGO
-- $$$$$$$$$$$$$$$$$$$$$

USE master
GO

IF DB_ID('FinanseKlubu') IS NULL
CREATE DATABASE FinanseKlubu
GO

USE FinanseKlubu;


-- Usuwanie tabel
IF OBJECT_ID('Przychody', 'U') IS NOT NULL
DROP TABLE Przychody

IF OBJECT_ID('Kontrakt', 'U') IS NOT NULL
DROP TABLE Kontrakt

IF OBJECT_ID('ProfilPrzychod', 'U') IS NOT NULL
DROP TABLE ProfilPrzychod

IF OBJECT_ID('Kontrahent', 'U') IS NOT NULL
DROP TABLE Kontrahent

IF OBJECT_ID('Pracownicy', 'U') IS NOT NULL
DROP TABLE Pracownicy


-- Tworzenie tabel
IF OBJECT_ID('Pracownicy', 'U') IS NULL
CREATE TABLE Pracownicy (
  id			   INT          NOT NULL PRIMARY KEY,
  nazwisko		   VARCHAR(100) NOT NULL,
  data_urodzenia   DATE,
  plec			   VARCHAR(9)   NOT NULL CHECK (plec IN ('mê¿czyzna', 'kobieta'))
)
  GO

IF OBJECT_ID('Kontrahent', 'U') IS NULL
CREATE TABLE Kontrahent (
  id             INT                  NOT NULL PRIMARY KEY,
  nazwa          VARCHAR(40) UNIQUE   NOT NULL,
  email			 VARCHAR(200) UNIQUE  NOT NULL,
  branza         VARCHAR(40)          NOT NULL,
  przedstawiciel VARCHAR(100)		  NOT NULL,
)
  GO

IF OBJECT_ID('ProfilPrzychod', 'U') IS NULL
CREATE TABLE ProfilPrzychod (
  id             INT                 NOT NULL PRIMARY KEY,
  nazwa          VARCHAR(40) UNIQUE  NOT NULL,
  opis			 VARCHAR(500) UNIQUE NOT NULL,
)
  GO

IF OBJECT_ID ('Kontrakt', 'U') IS NULL
CREATE TABLE Kontrakt (
  id_kontrakt			  INT		   NOT NULL IDENTITY PRIMARY KEY,
  kontrahent_id			  INT          NOT NULL FOREIGN KEY REFERENCES Kontrahent(id) ON DELETE CASCADE,
  pracownik_id			  INT          NOT NULL FOREIGN KEY REFERENCES Pracownicy(id) ON DELETE CASCADE,
  nazwa					  VARCHAR(200) NOT NULL,
  dlugosc				  INT		   NOT NULL,
  wartosc_roczna		  MONEY		   NOT NULL,
  UNIQUE(id_kontrakt, kontrahent_id, pracownik_id)
)
  GO

IF OBJECT_ID ('Przychody', 'U') IS NULL
CREATE TABLE Przychody (
  id_przychod			  INT        NOT NULL IDENTITY PRIMARY KEY,
  kontrakt_id			  INT        NOT NULL FOREIGN KEY REFERENCES Kontrakt(id_kontrakt) ON DELETE CASCADE,
  profil_id				  INT        NOT NULL FOREIGN KEY REFERENCES ProfilPrzychod(id) ON DELETE CASCADE,
  data_zawarcia			  DATE		 NOT NULL,
  konto_ksiegowe		  INT		 NOT NULL CHECK (konto_ksiegowe IN (71011100, 71011200, 71011300, 71011400)),
  UNIQUE(kontrakt_id, profil_id)
)
  GO


-- Wstawianie wartosci do tabel
INSERT INTO
  Pracownicy (id, nazwisko, data_urodzenia, plec)
VALUES
  (1, 'Florentino Perez', '1947-03-08', 'mê¿czyzna'),
  (2, 'Fernando Fernandez Tapias', '1938-07-01', 'mê¿czyzna'),
  (3, 'Jose Angel Sanchez', '1967-05-05', 'mê¿czyzna'),
  (4, 'Emilio Butragueno', '1963-06-22', 'mê¿czyzna'),
  (5, 'Roberto Carlos', '1973-04-10', 'mê¿czyzna'),
  (6, 'Santiago Solari', '1976-10-07', 'mê¿czyzna');

INSERT INTO
  ProfilPrzychod (id, nazwa, opis)
VALUES
  (1, 'Transmisja', 'Telewizyjne prawa do transmisju meczów'),
  (2, 'Sponsor sprzêtu', 'Umowy sponsorskie - dostawcy sprzêtu meczowego jak i pozameczowego'),
  (3, 'Reklama wizerunkowa', 'Nazwa sponsora umieszczona np. na: koszulkach meczowych/przedmeczowych lub treningowych, stadionie, klubowym muzeum'),
  (4, 'Reklama multimedialna', 'Reklama produktu w telewizji i/lub social media z udzia³em klubu pi³karskiego');

INSERT INTO
  Kontrahent(id, nazwa, email, branza, przedstawiciel)
VALUES
  (1, 'Adidas', 'marketing@adidas.com', 'odzie¿', 'Hans Dassler'),
  (2, 'Emirates', 'marketing@emirates.com', 'transport lotniczy', 'Ahmed bin Saeed Al Maktoum'),
  (3, 'Audi', 'marketing@audi.com', 'motoryzacja', 'Abraham Schot'),
  (4, 'Hankook', 'marketing@hankook.com', 'motoryzacja', 'Hyun Bum Cho'),
  (5, 'Tecate', 'marketing@tecate.com', 'piwowarstwo', 'Thomas Hunt'),
  (6, 'Sanitas', 'marketing@sanitas.com', 'medycyna', 'Francesco Alcacor'),
  (7, 'Palladium', 'marketing@palladium.com', 'hotele', 'Rafel Rubi'),
  (8, 'Nivea', 'marketing@nivea.com', 'kosmetologia', 'Oskar Troplowitz'),
  (9, 'Coca-cola', 'marketing@coke.com', '¿ywnoœæ', 'John Pemberton'),
  (10, 'Movistar', 'marketing@movistar.com', 'telekomunikacja', 'Rudi Sanchez'),
  (11, 'Movistar+', 'marketing@movistarplus.com', 'telewizja', 'Tres Cantos'),
  (12, 'Versace', 'marketing@versace.com', 'odzie¿', 'Gianni Donnaruma'),
  (13, 'Mahou', 'marketing@mahou.com', 'piwowarstwo', 'Daniel Diaz'),
  (14, 'EA Sports', 'marketing@easports.com', 'multimedia', 'Red Roger'),
  (15, 'beIN Sports', 'marketing@beinsports.com', 'telewizja', 'Stan Smith'),
  (16, 'Comcast', 'marketing@comcast.com', 'telewizja', 'Seth Roger'),
  (17, 'CCTV', 'marketing@cctv.com', 'telewizja', 'Xinwen Lianbo'),
  (18, 'SKY Sports', 'marketing@skysports.com', 'telewizja', 'Patrice Evra');

INSERT INTO
  Kontrakt(kontrahent_id, pracownik_id, nazwa, dlugosc, wartosc_roczna)
VALUES
  (1, 1, 'Sprzêt sportowy', 10, 150000000),
  (18, 6, 'Prawa transmisyjne', 1, 60000000),
  (3, 2, 'Samochody', 5, 15000000),
  (17, 5, 'Prawa transmisyjne', 1, 50000000),
  (2, 3, 'Logo na koszulkach meczowych', 2, 75000000),
  (16, 4, 'Prawa transmisyjne', 1, 65000000),
  (4, 1, 'Logo na stadionie', 3, 15000000),
  (15, 2, 'Prawa transmisyjne', 1, 45000000),
  (5, 3, 'Logo na stadionie', 4, 10000000),
  (14, 4, 'Ok³adka gry', 1, 10000000),
  (6, 5, 'Logo na koszulkach treningowych', 2, 15000000),
  (13, 6, 'Spot reklamowy w telewizji', 1, 10000000),
  (7, 6, 'Spot reklamowy w telewizji oraz social media', 2, 12000000),
  (12, 5, 'Odzie¿ wizytowa', 5, 9000000),
  (8, 4, 'Spot reklamowy w telewizji oraz social media', 2, 20000000),
  (11, 3,  'Prawa transmisyjne', 1, 65000000),
  (9, 2,  'Logo na koszulkach przedmeczowych', 1, 10000000),
  (10, 1,  'Logo na stadionie', 3, 10000000);

INSERT INTO
  Przychody(kontrakt_id, profil_id, data_zawarcia, konto_ksiegowe)
VALUES
  (1, 2, '20200120', 71011200),
  (2, 1, '20200617', 71011100),
  (3, 2, '20200330', 71011200),
  (4, 1, '20201125', 71011100),
  (5, 3, '20201106', 71011300),
  (6, 1, '20200727', 71011100),
  (7, 3, '20200824', 71011300),
  (8, 1, '20200904', 71011100),
  (9, 3, '20200301', 71011300),
  (10, 4, '20200411', 71011400),
  (11, 3, '20200114', 71011300),
  (12, 4, '20200214', 71011400),
  (13, 4, '20201217', 71011400),
  (14, 2, '20200620', 71011200),
  (15, 4, '20200522', 71011400),
  (16, 1, '20200123', 71011100),
  (17, 3, '20200905', 71011300),
  (18, 3, '20200406', 71011300);

-- Usuwanie i tworzenie widoków
IF OBJECT_ID('TopKontrakt', 'V') IS NOT NULL
DROP VIEW TopKontrakt
GO

CREATE VIEW TopKontrakt AS (
  SELECT TOP 1 kontrahent=h.nazwa, h.branza, kontrakt=k.nazwa, suma=(dlugosc * wartosc_roczna)
  FROM Kontrakt AS k
    JOIN Kontrahent AS h ON k.kontrahent_id = h.id
  ORDER BY suma DESC
)
  GO


IF OBJECT_ID('TopPracownik', 'V') IS NOT NULL
DROP VIEW TopPracownik
GO

CREATE VIEW TopPracownik AS (
  SELECT TOP 1 p.nazwisko, suma = SUM(k.wartosc_roczna)
  FROM Pracownicy AS p
    JOIN Kontrakt AS k ON p.id = k.pracownik_id
  GROUP BY p.nazwisko
  ORDER BY suma DESC
)
  GO


IF OBJECT_ID('ProfilePrzychodu', 'V') IS NOT NULL
DROP VIEW ProfilePrzychodu
GO

CREATE VIEW ProfilePrzychodu AS (
  SELECT TOP 4 pp.nazwa, suma=SUM(k.wartosc_roczna)
  FROM ProfilPrzychod AS pp
    JOIN Przychody AS p ON pp.id = p.profil_id
	JOIN Kontrakt AS k ON p.kontrakt_id = k.id_kontrakt
  GROUP BY pp.nazwa 
  ORDER BY suma DESC
)
  GO


IF OBJECT_ID('PracownikData', 'V') IS NOT NULL
DROP VIEW PracownikData
GO

CREATE VIEW PracownikData AS (
  SELECT TOP 1 p.nazwisko, suma = SUM(k.wartosc_roczna)
  FROM Pracownicy AS p
    JOIN Kontrakt AS k ON p.id = k.pracownik_id
	JOIN Przychody AS prz ON prz.kontrakt_id = k.id_kontrakt
  WHERE prz.data_zawarcia >= '20200401' AND prz.data_zawarcia <= '20200630'
  GROUP BY p.nazwisko
  ORDER BY suma DESC
)
  GO
-- Tworzenie procedur
IF OBJECT_ID('NajlepszyPracownikProfil', 'P') IS NOT NULL
DROP PROCEDURE NajlepszyPracownikProfil
GO

CREATE PROCEDURE NajlepszyPracownikProfil (
@top_ile TINYINT,
@profil VARCHAR (40)
) AS
SELECT
  TOP(@top_ile)
  p.nazwisko,
  suma=SUM(k.wartosc_roczna),
  @profil AS profil
FROM
  Pracownicy AS p
  JOIN Kontrakt AS k ON p.id = k.pracownik_id
  JOIN Przychody AS pr ON pr.kontrakt_id = k.id_kontrakt
  JOIN ProfilPrzychod AS pp ON pr.profil_id = pp.id
WHERE pp.nazwa = @profil
GROUP BY p.nazwisko
ORDER BY suma DESC
GO


-- Utworzenie raportów
PRINT 'Najwiêkszy podpisany kontrakt, w rozumieniu d³ugoœæ trwania w latach x wartoœæ roczna'
SELECT *
FROM TopKontrakt;

PRINT 'Najlepszy pracownik pod k¹tem sumy wartoœci rocznych przychodów w zawartych przez niego kontraktach'
SELECT *
FROM TopPracownik;

PRINT 'Wielkoœæ przychodów rocznych klubu w zale¿noœci od profilu przychodu'
SELECT *
FROM ProfilePrzychodu;

PRINT 'Najlepszy pracownik pod k¹tem sumy rocznego przychodu w zawartych przez niego kontraktach w II kwartale 2020 roku'
SELECT *
FROM PracownikData;

PRINT 'N najlepszych pracowników pod wzglêdem zdobytego rocznego przychodu dla klubu w danym profilu przychodu. N = 4, profil przychodu = "Transmisja" '
EXEC NajlepszyPracownikProfil 4, 'Transmisja';


-- Usuniecie bazy
USE master
GO

IF DB_ID('FinanseKlubu') IS NOT NULL
DROP DATABASE FinanseKlubu
GO