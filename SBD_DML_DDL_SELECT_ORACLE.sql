



drop table DANE_KONTAKOWE
/

drop table KATEGORIAPROMOCJA
/

drop table OPINIA
/

drop table PROMOCJA
/

drop table REKLAMACJA
/

drop table ZAMÓWIENIE
/

drop table KLIENT
/

drop table PRACOWNIK
/

drop table PRODUKT
/

drop table KATEGORIA
/








-- Table: Dane_kontaktowe
CREATE TABLE Dane_kontakowe (
    ID number(10)  NOT NULL,
    Nr_telefonu number(15)  NOT NULL,
    email char(100)  NOT NULL,
    Klient_ID number(10)  NOT NULL,
    CONSTRAINT Dane_kontakowe_pk PRIMARY KEY (ID)
) ;

-- Table: KATEGORIAPROMOCJA
CREATE TABLE KATEGORIAPROMOCJA (
    ID number(10)  NOT NULL,
    Kategoria_ID number(10)  NOT NULL,
    Promocja_ID number(10)  NOT NULL,
    CONSTRAINT KATEGORIAPROMOCJA_pk PRIMARY KEY (ID)
) ;

-- Table: Kategoria
CREATE TABLE Kategoria (
    ID number(10)  NOT NULL,
    Nazwa char(100)  NOT NULL,
    CONSTRAINT Kategoria_pk PRIMARY KEY (ID)
) ;

-- Table: Klient
CREATE TABLE Klient (
    ID number(10)  NOT NULL,
    Imię char(100)  NOT NULL,
    Nazwisko char(100)  NOT NULL,
    Adres char(100)  NOT NULL,
    Status char(100)  NOT NULL,
    Pracownik_ID number(10)  NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (ID)
) ;

-- Table: Opinia
CREATE TABLE Opinia (
    ID number(10)  NOT NULL,
    Ocena number(10)  NOT NULL,
    Treść char(100)  NOT NULL,
    Klient_ID number(10)  NOT NULL,
    Produkt_ID number(10)  NOT NULL,
    CONSTRAINT Opinia_pk PRIMARY KEY (ID)
) ;

-- Table: Pracownik
CREATE TABLE Pracownik (
    ID number(10)  NOT NULL,
    Imię char(100)  NOT NULL,
    Nazwisko char(100)  NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (ID)
) ;

-- Table: Produkt
CREATE TABLE Produkt (
    ID number(10)  NOT NULL,
    Nazwa char(100)  NOT NULL,
    Opis char(100)  NOT NULL,
    Cena number(10,2)  NOT NULL,
    Dostępność char(100)  NOT NULL,
    Kategoria_ID number(10)  NOT NULL,
    CONSTRAINT Produkt_pk PRIMARY KEY (ID)
) ;

-- Table: Promocja
CREATE TABLE Promocja (
    ID number(10)  NOT NULL,
    Data_rozpoczęcia date  NOT NULL,
    Data_zakończenia date  NOT NULL,
    CONSTRAINT Promocja_pk PRIMARY KEY (ID)
) ;

-- Table: Reklamacja
CREATE TABLE Reklamacja (
    ID number(10)  NOT NULL,
    Opis varchar2(1000)  NOT NULL,
    Data_złożenia date  NOT NULL,
    Klient_ID number(10)  NOT NULL,
    Produkt_ID number(10)  NOT NULL,
    CONSTRAINT Reklamacja_pk PRIMARY KEY (ID)
) ;

-- Table: Zamówienie
CREATE TABLE Zamówienie (
    ID number(10)  NOT NULL,
    Data date  NOT NULL,
    Status char(100)  NOT NULL,
    Klient_ID number(10)  NOT NULL,
    Produkt_ID number(10)  NOT NULL,
    CONSTRAINT Zamówienie_pk PRIMARY KEY (ID)
) ;

-- foreign keys
-- Reference: Dane kontakowe_Klient (table: Dane_kontakowe)
ALTER TABLE Dane_kontakowe ADD CONSTRAINT Dane_kontakowe_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

-- Reference: Klient_Pracownik (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Pracownik
    FOREIGN KEY (Pracownik_ID)
    REFERENCES Pracownik (ID);

-- Reference: Opinia_Klient (table: Opinia)
ALTER TABLE Opinia ADD CONSTRAINT Opinia_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

-- Reference: Opinia_Produkt (table: Opinia)
ALTER TABLE Opinia ADD CONSTRAINT Opinia_Produkt
    FOREIGN KEY (Produkt_ID)
    REFERENCES Produkt (ID);

-- Reference: Produkt_Kategoria (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Kategoria
    FOREIGN KEY (Kategoria_ID)
    REFERENCES Kategoria (ID);

-- Reference: Reklamacja_Klient (table: Reklamacja)
ALTER TABLE Reklamacja ADD CONSTRAINT Reklamacja_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

-- Reference: Reklamacja_Produkt (table: Reklamacja)
ALTER TABLE Reklamacja ADD CONSTRAINT Reklamacja_Produkt
    FOREIGN KEY (Produkt_ID)
    REFERENCES Produkt (ID);

-- Reference: Table_15_Kategoria (table: KATEGORIAPROMOCJA)
ALTER TABLE KATEGORIAPROMOCJA ADD CONSTRAINT Table_15_Kategoria
    FOREIGN KEY (Kategoria_ID)
    REFERENCES Kategoria (ID);

-- Reference: Table_15_Promocja (table: KATEGORIAPROMOCJA)
ALTER TABLE KATEGORIAPROMOCJA ADD CONSTRAINT Table_15_Promocja
    FOREIGN KEY (Promocja_ID)
    REFERENCES Promocja (ID);

-- Reference: Zamówienie_Klient (table: Zamówienie)
ALTER TABLE Zamówienie ADD CONSTRAINT Zamówienie_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (ID);

-- Reference: Zamówienie_Produkt (table: Zamówienie)
ALTER TABLE Zamówienie ADD CONSTRAINT Zamówienie_Produkt
    FOREIGN KEY (Produkt_ID)
    REFERENCES Produkt (ID);











--inserts

-- Pracownik
INSERT INTO Pracownik (ID, Imię, Nazwisko)
VALUES (1, 'Adam', 'Nowak');

INSERT INTO Pracownik (ID, Imię, Nazwisko)
VALUES (2, 'Karolina', 'Kowalczyk');

INSERT INTO Pracownik (ID, Imię, Nazwisko)
VALUES (3, 'Tomasz', 'Lewandowski');

INSERT INTO Pracownik (ID, Imię, Nazwisko)
VALUES (4, 'Magdalena', 'Wójcik');

INSERT INTO Pracownik (ID, Imię, Nazwisko)
VALUES (5, 'Marcin', 'Lis');

-- Klient
INSERT INTO Klient (ID, Imię, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1, Warszawa', 'stały klient', 1);

INSERT INTO Klient (ID, Imię, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (2, 'Anna', 'Nowak', 'ul. Główna 2, Kraków', 'nowy klient', 2);

INSERT INTO Klient (ID, Imię, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (3, 'Piotr', 'Zielinski', 'ul. Leśna 3, Gdańsk', 'klient VIP', 3);

INSERT INTO Klient (ID, Imię, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (4, 'Maria', 'Nowakowska', 'ul. Słoneczna 4, Poznań', 'stały klient', 1);

INSERT INTO Klient (ID, Imię, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (5, 'Tomasz', 'Kowalczyk', 'ul. Morska 5, Szczecin', 'nowy klient', 2);


-- Dane_kontakowe
INSERT INTO Dane_kontakowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (1, '123456789', 'example1@example.com', 1);

INSERT INTO Dane_kontakowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (2, '987654321', 'example2@example.com', 2);

INSERT INTO Dane_kontakowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (3, '555555555', 'example3@example.com', 3);

INSERT INTO Dane_kontakowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (4, '555555555', 'example4@example.com', 4);

INSERT INTO Dane_kontakowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (5, '999999999', 'example5@example.com', 5);




-- Kategoria
INSERT INTO Kategoria (ID, Nazwa)
VALUES (1, 'Gaming');

INSERT INTO Kategoria (ID, Nazwa)
VALUES (2, 'Sprzęt kuchenny');

INSERT INTO Kategoria (ID, Nazwa)
VALUES (3, 'Głośniki');

INSERT INTO Kategoria (ID, Nazwa)
VALUES (4, 'Kamery');

INSERT INTO Kategoria (ID, Nazwa)
VALUES (5, 'Przewody');

-- Produkt
INSERT INTO Produkt (ID, Nazwa, Opis, Cena, Dostępność, Kategoria_ID)
VALUES (1, 'Monitor', 'Duży monitor LED', 999.99, 'nie dostępny', 1);

INSERT INTO Produkt (ID, Nazwa, Opis, Cena, Dostępność, Kategoria_ID)
VALUES (2, 'Blender', 'Blender kuchenny bezprzewodowy', 499.99, 'dostępny', 2);

INSERT INTO Produkt (ID, Nazwa, Opis, Cena, Dostępność, Kategoria_ID)
VALUES (3, 'Głośnik przenośny', 'Przenośny, mały głośnik na bluetooth', 199.99, 'dostępny', 3);

INSERT INTO Produkt (ID, Nazwa, Opis, Cena, Dostępność, Kategoria_ID)
VALUES (4, 'Kamerka GoPRO', 'Mała kamera z opcją nagrywania 4k', 2499.99, 'dostępny', 4);

INSERT INTO Produkt (ID, Nazwa, Opis, Cena, Dostępność, Kategoria_ID)
VALUES (5, 'Przewód Lightning', 'Oryginalny kabel do sprzętu Apple', 99.99, 'dostępny', 5);

-- Opinia
INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (1, 5, 'Bardzo dobry produkt!', 1, 1);

INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (2, 3, 'Średni produkt.', 2, 2);

INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (3, 4, 'Super sprzęt!', 3, 3);

INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (4, 2, 'Produkt nie spełnił moich oczekiwań.', 4, 4);

INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (5, 4, 'Mega dobry produkt!', 5, 5);





-- Promocja
INSERT INTO Promocja (ID, Data_rozpoczęcia, Data_zakończenia)
VALUES (1, '2023-06-15', '2024-06-30');

INSERT INTO Promocja (ID, Data_rozpoczęcia, Data_zakończenia)
VALUES (2, '2023-06-20', '2023-07-05');

INSERT INTO Promocja (ID, Data_rozpoczęcia, Data_zakończenia)
VALUES (3, '2023-07-01', '2023-07-31');

INSERT INTO Promocja (ID, Data_rozpoczęcia, Data_zakończenia)
VALUES (4, '2023-07-05', '2023-07-20');

INSERT INTO Promocja (ID, Data_rozpoczęcia, Data_zakończenia)
VALUES (5, '2023-07-10', '2023-07-31');


-- Kategoria_Promocja
INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (1, 1, 1);

INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (2, 2, 1);

INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (3, 3, 2);

INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (4, 4, 2);

INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (5, 5, 3);

-- Reklamacja
INSERT INTO Reklamacja (ID, Opis, Data_złożenia, Klient_ID, Produkt_ID)
VALUES (1, 'Uszkodzony produkt po dostawie', '2023-06-10', 1, 1);

INSERT INTO Reklamacja (ID, Opis, Data_złożenia, Klient_ID, Produkt_ID)
VALUES (2, 'Słabe ostrza', '2023-06-12', 2, 2);

INSERT INTO Reklamacja (ID, Opis, Data_złożenia, Klient_ID, Produkt_ID)
VALUES (3, 'Niezgodność z opisem', '2023-06-14', 3, 3);

INSERT INTO Reklamacja (ID, Opis, Data_złożenia, Klient_ID, Produkt_ID)
VALUES (4, 'Uszkodzony statyw', '2023-06-20', 4, 4);


-- Zamówienie
INSERT INTO Zamówienie (ID, Status, Data, Klient_ID, Produkt_ID)
VALUES (1, 'zrealizowane', '2023-06-14', 1, 1);

INSERT INTO Zamówienie (ID, Status, Data, Klient_ID, Produkt_ID)
VALUES (2, 'w trakcie', '2023-06-15', 2, 2);

INSERT INTO Zamówienie (ID, Status, Data, Klient_ID, Produkt_ID)
VALUES (3, 'w trakcie', '2023-06-16', 3, 3);

INSERT INTO Zamówienie (ID, Status, Data, Klient_ID, Produkt_ID)
VALUES (4, 'w trakcie', '2023-06-18', 4, 4);

INSERT INTO Zamówienie (ID, Status, Data, Klient_ID, Produkt_ID)
VALUES (5, 'zrealizowane', '2023-06-20', 5, 5);






--1--Wyświetl wszystkich klientów i ich dane kontaktowe

SELECT Klient.Imię, Klient.Nazwisko, Dane_kontakowe.Nr_telefonu, Dane_kontakowe.email
FROM Klient
INNER JOIN Dane_kontakowe
ON Klient.ID=Dane_kontakowe.Klient_ID;


--2--Wyświetl średnią ocenę dla każdego produktu

SELECT Produkt.Nazwa, AVG(Opinia.Ocena)
FROM Produkt
INNER JOIN Opinia
ON Produkt.ID=Opinia.Produkt_ID
GROUP BY Produkt.Nazwa;


--3--Wyświetl 3 najtańsze produkty

SELECT Nazwa, Cena
FROM (
  SELECT Nazwa, Cena
  FROM Produkt
  ORDER BY Cena
)
WHERE ROWNUM <= 3;



--4--Ile jest zamówień zrealizowanych

SELECT COUNT(ID)
FROM Zamówienie
WHERE Status='zrealizowane';


--5--Wyświetl wszystkich klientów którzy złożyli reklamacje

SELECT DISTINCT Klient.Imię, Klient.Nazwisko
FROM Klient
INNER JOIN Reklamacja
ON Klient.ID=Reklamacja.Klient_ID;


--6--Wyświetl pracowników którzy obsługują ponad 1 klienta


SELECT Pracownik.Imię, Pracownik.Nazwisko
FROM Pracownik
WHERE Pracownik.ID IN (
	SELECT Klient.Pracownik_ID
	FROM Klient
	GROUP BY Klient.Pracownik_ID
	HAVING COUNT(Klient.ID) > 1
);


--7--Wyświetl produkty w kategorii gaming

SELECT Produkt.Nazwa
FROM Produkt
INNER JOIN Kategoria
ON Produkt.Kategoria_ID=Kategoria.ID
WHERE Kategoria.Nazwa='Gaming';


--8--Wyświetl produkty które mają średnią ocene większą niż 3

SELECT Produkt.Nazwa, AVG(Opinia.Ocena) AS Średnia_ocena
FROM Produkt
JOIN Opinia ON Produkt.ID = Opinia.Produkt_ID
GROUP BY Produkt.Nazwa
HAVING AVG(Opinia.Ocena) > 3;


--9--Wyświetl klientów którzy nie złożyli reklamacji

SELECT Klient.Imię, Klient.Nazwisko
FROM Klient
LEFT JOIN Reklamacja ON Klient.ID = Reklamacja.Klient_ID
WHERE Reklamacja.ID IS NULL;


--10--Wyświetl wszystkie promocje dla kamer

SELECT Promocja.Data_rozpoczęcia, Promocja.Data_zakończenia
FROM Promocja
INNER JOIN KATEGORIAPROMOCJA
ON Promocja.ID=KATEGORIAPROMOCJA.Promocja_ID
WHERE KATEGORIAPROMOCJA.Kategoria_ID IN (
	SELECT Kategoria.ID
	FROM Kategoria
	WHERE Kategoria.Nazwa='Kamery'
);

