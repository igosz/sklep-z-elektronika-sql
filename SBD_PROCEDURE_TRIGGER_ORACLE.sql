drop procedure ZlozZamowienie
/

drop procedure PrzyznajStatusVIP
/

drop trigger UpdateCena
/

drop trigger OpiniaPoReklamacji
/

drop sequence opinia_se
/




--Procedura 1
--Złożenie zamówienia, sprawdza czy produkt jest dostępny aby możliwe było dodanie nowego rekordu
--zamówienia do bazy danych.

CREATE OR REPLACE PROCEDURE ZlozZamowienie (
    v_Klient_ID NUMBER,
    v_Produkt_ID NUMBER,
    v_Status CHAR,
    v_Data DATE,
    v_Zamowienie_ID NUMBER
)
AS
    v_DostepnoscProduktu CHAR(100);
BEGIN

    SELECT Dostępność INTO v_DostepnoscProduktu FROM Produkt WHERE ID = v_Produkt_ID;

    IF v_DostepnoscProduktu = 'nie dostępny' THEN

        DBMS_OUTPUT.PUT_LINE('Produkt nie dostępny.');

    ELSE

        INSERT INTO Zamówienie (ID, Klient_ID, Produkt_ID, Status, Data) VALUES (v_Zamowienie_ID, v_Klient_ID, v_Produkt_ID, v_Status, v_Data);
        DBMS_OUTPUT.PUT_LINE('Zamówienie zostało dodane.');

    END IF;
COMMIT;
END;


--Przykładowe użycie

BEGIN
    ZlozZamowienie(3, 2, 'w trakcie', SYSDATE, 6);
END;











--Procedura 2
--Przeszukuje wydatki w sklepie dla danych klientów poprzez kursor, który pobiera dane z tabel: Klient,
--Zamówienie i Produkt, a następnie jeżeli suma wartości zakupów przekroczy 2000 to przyznaje klientowi
--status VIP.

CREATE OR REPLACE PROCEDURE PrzyznajStatusVIP

AS

    CURSOR KlienciCur IS
    SELECT K.ID, SUM(P.Cena) AS SumaWydana
    FROM Klient K
    JOIN Zamówienie Z ON K.ID = Z.Klient_ID
    JOIN Produkt P ON Z.Produkt_ID = P.ID
    GROUP BY K.ID;


    v_KlientID NUMBER(10);
    v_SumaWydana NUMBER(10,2);

BEGIN

    FOR KlientRec IN KlienciCur LOOP

        v_KlientID := KlientRec.ID;
        v_SumaWydana := KlientRec.SumaWydana;

        IF v_SumaWydana > 2000 THEN
            UPDATE Klient SET Status = 'klient VIP' WHERE ID = v_KlientID;
        END IF;

    END LOOP;

COMMIT;
END;


--Przykładowe użycie

BEGIN
PrzyznajStatusVIP;
END;














--Wyzwalacz 1
--Przy każdym założeniu promocji na daną kategorie sprawdza czy promocja jest aktualna i następnie
--jeżeli jest to zmniejsza cene wszystkich produktów z tej kategorii o 25%.
CREATE OR REPLACE TRIGGER UpdateCena
AFTER INSERT ON KATEGORIAPROMOCJA
FOR EACH ROW
DECLARE
  v_datarozpoczecia DATE;
  v_datazakonczenia DATE;
BEGIN

  SELECT Data_rozpoczęcia, Data_zakończenia INTO v_datarozpoczecia, v_datazakonczenia FROM Promocja WHERE ID = :NEW.Promocja_ID;

  IF SYSDATE BETWEEN v_datarozpoczecia AND v_datazakonczenia THEN

    UPDATE Produkt SET Cena = Cena * 0.75 WHERE Kategoria_ID = :NEW.Kategoria_ID;

  END IF;

END;
/


--Przykładowe użycie

--dodajemy aktualna promocje na kategorie głosniki
INSERT INTO KATEGORIAPROMOCJA (ID, Kategoria_ID, Promocja_ID)
VALUES (6, 3, 1);

--wyswietlamy ceny produktow
SELECT ID AS Produkt_ID, Nazwa, Cena FROM Produkt;












--Wyzwalacz 2
--Za każdym razem jak zostaje wystawiona reklamacja klient automatycznie wystawia negatywną opinie.




CREATE SEQUENCE opinia_se
  START WITH 6
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


CREATE OR REPLACE TRIGGER OpiniaPoReklamacji
AFTER INSERT ON Reklamacja
FOR EACH ROW
DECLARE
    v_IDopinii NUMBER;
BEGIN

v_IDopinii := opinia_se.nextval;

INSERT INTO Opinia (ID, Ocena, Treść, Klient_ID, Produkt_ID)
VALUES (v_IDopinii, 0, 'Produkt zareklamowany.', :NEW.Klient_ID, :NEW.Produkt_ID);

END;
/




--Przykładowe użycie
INSERT INTO REKLAMACJA (ID, OPIS, DATA_ZŁOŻENIA, KLIENT_ID, PRODUKT_ID)
VALUES (88, 'przyszło bez pudełka', '2024-01-22', 5, 4);

SELECT * FROM OPINIA