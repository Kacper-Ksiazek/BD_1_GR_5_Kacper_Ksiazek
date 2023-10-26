CREATE SCHEMA "rozliczenia";

DROP TABLE rozliczenia.pracownicy;
DROP TABLE rozliczenia.godziny;
DROP TABLE rozliczenia.pensje;
DROP TABLE rozliczenia.premie;

-- 1. STWORZENIE TABELI

CREATE TABLE IF NOT EXISTS "rozliczenia"."pracownicy" (
    id_pracownika int not null UNIQUE,
    imie varchar,
    nazwisko varchar,
    adres varchar,
    telefon int,

    PRIMARY KEY(id_pracownika)
);

CREATE TABLE IF NOT EXISTS "rozliczenia"."godziny" (
    id_godziny int not null UNIQUE,
    data date,
    liczba_godzin float8,
    id_pracownika int not null,

    PRIMARY KEY(id_godziny)
);

CREATE TABLE IF NOT EXISTS "rozliczenia"."pensje" (
    id_pensji int UNIQUE not null,
    stanowisko varchar default 'informatyk',
    kwota float8 default null,
    id_premii int ,

    PRIMARY KEY(id_pensji)
);

CREATE TABLE IF NOT EXISTS "rozliczenia"."premie" (
    id_premii int UNIQUE not null,
    rodzaj varchar not null,
    kwota varchar not null,

    PRIMARY KEY(id_premii)
);


-- 2. Dodanie kluczy obcych

ALTER TABLE rozliczenia.godziny
    ADD FOREIGN KEY(id_pracownika)
        REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
    ADD FOREIGN KEY(id_premii)
        REFERENCES rozliczenia.premie(id_premii);


-- 3. Generowanie rekordow

INSERT INTO "rozliczenia"."pracownicy" (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
    (1, 'Jan', 'Kowalski', 'ul. Prosta 1, Warszawa', 123456789),
    (2, 'Anna', 'Nowak', 'ul. Kwiatowa 3, Kraków', 987654321),
    (3, 'Marek', 'Wiśniewski', 'ul. Słoneczna 7, Gdańsk', 555333111),
    (4, 'Ewa', 'Lis', 'ul. Lesna 4, Wrocław', 111222333),
    (5, 'Piotr', 'Zając', 'ul. Zielona 5, Poznań', 444555666),
    (6, 'Katarzyna', 'Wójcik', 'ul. Górska 8, Łódź', 666777888),
    (7, 'Andrzej', 'Kaczor', 'ul. Polna 2, Katowice', 222333444),
    (8, 'Magdalena', 'Wilk', 'ul. Morska 6, Szczecin', 777888999),
    (9, 'Tomasz', 'Pawlak', 'ul. Słoneczna 9, Lublin', 999888777),
    (10, 'Agnieszka', 'Duda', 'ul. Wiejska 10, Rzeszów', 111222333);

INSERT INTO "rozliczenia"."godziny" (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
    (1, '2023-10-11', 160.5, 1),
    (2, '2023-08-02', 145.25, 2),
    (3, '2023-10-09', 173.75, 3),
    (4, '2023-11-04', 132.0, 4),
    (5, '2023-10-15', 155.5, 5),
    (6, '2023-09-06', 140.75, 6),
    (7, '2023-10-27', 168.25, 7),
    (8, '2023-08-11', 120.0, 8),
    (9, '2023-10-09', 180.5, 9),
    (10, '2023-01-01', 190.75, 10);

INSERT INTO "rozliczenia"."premie" (id_premii, rodzaj, kwota)
VALUES
    (1, 'Miesięczna premia', '300.00'),
    (2, 'Roczna premia', '800.00'),
    (3, 'Miesięczna premia', '250.00'),
    (4, 'Roczna premia', '700.00'),
    (5, 'Miesięczna premia', '200.00'),
    (6, 'Roczna premia', '900.00'),
    (7, 'Miesięczna premia', '350.00'),
    (8, 'Roczna premia', '750.00'),
    (9, 'Miesięczna premia', '400.00'),
    (10, 'Roczna premia', '600.00');

INSERT INTO "rozliczenia"."pensje" (id_pensji, stanowisko, kwota, id_premii)
VALUES
    (1, 'informatyk', 5000.0, null),
    (2, 'księgowy', 4500.0, 1),
    (3, 'programista', 5500.0, null),
    (4, 'analityk', 4800.0, 2),
    (5, 'tester', 4200.0, null),
    (6, 'asystent', 3800.0, 3),
    (7, 'informatyk', 5100.0, null),
    (8, 'księgowa', 4600.0, 4),
    (9, 'programistka', 5600.0, null),
    (10, 'analityk', 4900.0, 5);

-- 5.

SELECT nazwisko,adres FROM "rozliczenia"."pracownicy";

-- 6.

SELECT
    id_pracownika,
    DATE_PART('day', data) as dzien_tygodnia,
    DATE_PART('month', data) as miesiac,
    to_char(data,'day') as nazwa_dnia_tygodnia,
    to_char(data,'month') as nazwa_miesiaca
FROM "rozliczenia"."godziny";


-- 7.

ALTER TABLE "rozliczenia"."pensje"
    RENAME "kwota" TO "kwota_brutto";

ALTER TABLE "rozliczenia"."pensje"
    ADD "kwota_netto" float8;

UPDATE "rozliczenia"."pensje"
SET kwota_netto = rozliczenia.pensje.kwota_brutto * 0.77;

SELECT kwota_brutto,kwota_netto FROM rozliczenia.pensje
