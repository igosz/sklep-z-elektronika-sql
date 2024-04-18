
drop trigger SprawdzPoprEmail
go

drop trigger NieaktywneZamowienie
go

drop procedure SredniaOcena
go

drop procedure PrzydzielNewPracownik
go


--Wyzwalacz 1
--Sprawdza przy wstawianiu lub aktualizacji adresu email do tabeli Dane_kontaktowe czy jest on
--poprawny (czy zawiera '@') ,jeżeli nie jest to ustawia status klienta na nieaktywny.

CREATE TRIGGER SprawdzPoprEmail
ON Dane_kontaktowe
AFTER INSERT, UPDATE
AS
DECLARE

@Klient_ID INT,
@Status VARCHAR(100);

BEGIN

    SELECT @Klient_ID = Klient_ID, @Status = Klient.Status
    FROM inserted JOIN Klient ON Klient.ID = inserted.Klient_ID;

    IF EXISTS (SELECT 1 FROM inserted WHERE Klient_ID = @Klient_ID AND CHARINDEX('@', email) = 0)
    BEGIN
        UPDATE Klient SET Status = 'nieaktywny' WHERE ID = @Klient_ID;
    END

END;



--Przyklad uzycia
INSERT INTO Klient (ID, Imie, Nazwisko, Adres, Status, Pracownik_ID)
VALUES (60, 'Bede', 'Nieaktywny', 'ul. Zlego emaila', 'nowy klient', 2);

Insert INTO Dane_kontaktowe (ID, Nr_telefonu, email, Klient_ID)
VALUES (11, 510984567, 'niepoprawnygmail.com', 60);

SELECT * FROM Klient












--Wyzwalacz 2
--Sprawdza przy zlozeniu nowego zamowienia czy klient ma nieaktywny status, jezeli tak to nie moze on
--zlozyc tego zamowienia.

CREATE TRIGGER NieaktywneZamowienie
ON Zamowienie
INSTEAD OF INSERT
AS

DECLARE
@Info VARCHAR(100)

BEGIN

    IF EXISTS ( SELECT 1 FROM inserted i JOIN Klient k ON i.Klient_ID = k.ID WHERE k.Status = 'nieaktywny')
    BEGIN
        SET @Info = (N'Klient jest nieaktywny i nie może złozyć zamówienia');
        PRINT @Info;
    END

    ELSE
    BEGIN
        INSERT INTO Zamowienie (ID, Data, Status, Klient_ID, Produkt_ID)
        SELECT ID, Data, Status, Klient_ID, Produkt_ID
        FROM inserted;
    END

END;



--Przykład użycia
INSERT INTO Zamowienie (ID, Data, Status, Klient_ID, Produkt_ID)
VALUES (666, SYSDATETIME(), 'nowe zamowienie', 60, 3);

SELECT * FROM Zamowienie;





















--Procedura 1
--Za pomocą kursora przeszukuje przez wszystkie oceny danego produktu i wylicza dla
--tego produktu średnią ocenę.

CREATE PROCEDURE SredniaOcena @ProduktID INT
AS
BEGIN

    DECLARE
    @Ocena NUMERIC(10, 2),
    @NewOcena NUMERIC(10,2),
    @OpiniaCount INT,
    @Info VARCHAR(100);

    DECLARE OpinieCursor CURSOR FOR SELECT Ocena FROM Opinia WHERE Produkt_ID = @ProduktID;



    SET @OpiniaCount = 0;
    SET @Ocena = 0;
    SET @NewOcena = 0;



    OPEN OpinieCursor;
    FETCH NEXT FROM OpinieCursor INTO @Ocena;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @NewOcena = @NewOcena + @Ocena;
        SET @OpiniaCount = @OpiniaCount + 1;
        FETCH NEXT FROM OpinieCursor INTO @Ocena;
    END

    CLOSE OpinieCursor;
    DEALLOCATE OpinieCursor;




    IF @OpiniaCount > 0
    BEGIN
        SET @Info = N'Średnia ocena tego produktu to: ' + CAST(@NewOcena / @OpiniaCount AS VARCHAR);
    END

    ELSE
    BEGIN
        SET @Info = 'Ten produkt nie ma jeszcze ocen.';
    END

    PRINT @Info;

END;





--Przyklad uzycia
INSERT INTO Opinia (ID, Ocena, Tresc, Klient_ID, Produkt_ID)
VALUES (6, 3, 'Po czasie produkt jednak nie taki dobry', 5, 5);

EXECUTE SredniaOcena 5;














--Procedura 2
--Przydziela ona nowego, wybranego pracownika dla danego klienta po sprawdzeniu czy znajdują się
--oni w bazie danych.

CREATE PROCEDURE PrzydzielNewPracownik @KlientID INT, @NewPracownikID INT
AS
BEGIN

    DECLARE @Info VARCHAR(100);

    IF EXISTS (SELECT 1 FROM Klient WHERE ID = @KlientID)
    BEGIN

        IF EXISTS (SELECT 1 FROM Pracownik WHERE ID = @NewPracownikID)
        BEGIN

            UPDATE Klient
            SET Pracownik_ID = @NewPracownikID
            WHERE ID = @KlientID;

            SET @Info = 'Przydzielono nowego pracownika klientowi.';
        END

        ELSE
        BEGIN
            SET @Info = 'Pracownik o tym ID nie istnieje.';
        END
    END

    ELSE
    BEGIN
        SET @Info = 'Klient o tym ID nie istnieje.';
    END

    PRINT @Info;

END;


--Przyklad uzycia
EXECUTE PrzydzielNewPracownik 1,5;

SELECT * FROM Klient;







