-- 2.
DROP SCHEMA ksiegowosc CASCADE;
CREATE SCHEMA ksiegowosc;

-- 3.
CREATE TABLE IF NOT EXISTS ksiegowosc.pracownicy
(
    id_pracownika SERIAL UNIQUE,
    imie          varchar NOT NULL,
    nazwisko      varchar NOT NULL,
    adres         varchar,
    telefon       int,

    PRIMARY KEY (id_pracownika)
);

CREATE TABLE IF NOT EXISTS ksiegowosc.godziny
(
    id_godziny    SERIAL UNIQUE,
    data          date,
    liczba_godzin float8,
    id_pracownika int NOT NULL,

    PRIMARY KEY (id_godziny),
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy (id_pracownika) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ksiegowosc.pensje
(
    id_pensji  SERIAL UNIQUE,
    stanowisko varchar,
    kwota      float8 NOT NULL,

    PRIMARY KEY (id_pensji)
);

CREATE TABLE IF NOT EXISTS ksiegowosc.premie
(
    id_premii SERIAL,
    rodzaj    varchar NOT NULL,
    kwota     float8  NOT NULL,

    PRIMARY KEY (id_premii)
);

CREATE TABLE IF NOT EXISTS ksiegowosc.wynagrodzenie
(
    id_wynagrodzenia SERIAL UNIQUE,
    data             DATE,
    id_pracownika    int NOT NULL,
    id_pensji        int NOT NULL,
    id_premii        int DEFAULT NULL,

    PRIMARY KEY (id_wynagrodzenia),
    FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje (id_pensji) ON DELETE CASCADE,
    FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie (id_premii) ON DELETE CASCADE,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy (id_pracownika) ON DELETE CASCADE
);

INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES (1, 'Anna', 'Kowalska', 'ul. Kwiatowa 1, 00-001 Warszawa', 123456789),
       (2, 'Jan', 'Nowak', 'ul. Leśna 5, 02-002 Kraków', 987654321),
       (3, 'Magdalena', 'Zielińska', 'ul. Słoneczna 10, 03-003 Gdańsk', 555666777),
       (4, 'Kamila', 'Wiśniewska', 'ul. Ogrodowa 7, 04-004 Wrocław', 111222333),
       (5, 'Monika', 'Lis', 'ul. Polna 12, 05-005 Poznań', 999888777),
       (6, 'Bartosz', 'Jankowski', 'ul. Morska 3, 06-006 Łódź', 333444555),
       (7, 'Natalia', 'Kaczmarek', 'ul. Rajska 9, 07-007 Katowice', 777888999),
       (8, 'Rafał', 'Piotrowski', 'ul. Słowiańska 11, 08-008 Gdynia', 222111333),
       (9, 'Agnieszka', 'Dąbrowska', 'ul. Zielona 8, 09-009 Lublin', 666555444),
       (10, 'Grzegorz', 'Szymański', 'ul. Cicha 6, 10-010 Szczecin', 444333222),
       (11, 'Karolina', 'Nowicka', 'ul. Kwiaty 15, 11-011 Gdynia', 555111222),
       (12, 'Piotr', 'Kowal', 'ul. Słowackiego 20, 12-012 Warszawa', 987654321),
       (13, 'Ewa', 'Lewandowska', 'ul. Piękna 30, 13-013 Poznań', 123456789);


DO
$$
    BEGIN
        FOR pracownik_id in 1..13
            LOOP
                FOR i in 1..20
                    LOOP
                        INSERT INTO ksiegowosc.godziny (data, liczba_godzin, id_pracownika)
                        VALUES (CURRENT_DATE + (i || ' days')::INTERVAL, ROUND(RANDOM() * 16) + 1, pracownik_id);
                    END LOOP;
            END LOOP;
    END
$$;

-- INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
-- VALUES (1, '2023-11-01', 8, 1),
--        (2, '2023-11-02', 7.5, 2),
--        (3, '2023-11-03', 9, 3),
--        (4, '2023-11-04', 8.5, 4),
--        (5, '2023-11-05', 7, 5),
--        (6, '2023-11-06', 9.5, 6),
--        (7, '2023-11-07', 8, 7),
--        (8, '2023-11-08', 7.5, 8),
--        (9, '2023-11-09', 9, 9),
--        (10, '2023-11-10', 8, 10);

INSERT INTO ksiegowosc.pensje (id_pensji, stanowisko, kwota)
VALUES (1, 'Księgowa', 5000),
       (2, 'Programista', 6000),
       (3, 'Specjalista ds. Finansów', 5500),
       (4, 'Analityk', 5200),
       (5, 'Administrator', 4800),
       (6, 'Kierownik Projektu', 7000),
       (7, 'HR Manager', 2999),
       (8, 'Architekt Systemowy', 6500),
       (9, 'Doradca Podatkowy', 5800),
       (10, 'Tester Oprogramowania', 4800),
       (11, 'Kierownik Projektu', 13300),
       (12, 'Kierownik Projektu', 7000),
       (13, 'Kierownik Projektu', 2340);

INSERT INTO ksiegowosc.premie (id_premii, rodzaj, kwota)
VALUES (1, 'Premia roczna', 1000.00),
       (2, 'Premia za wyniki', 500.00),
       (3, 'Premia świąteczna', 700.00),
       (4, 'Premia jubileuszowa', 1200.00),
       (5, 'Premia motywacyjna', 800.00),
       (6, 'Premia uznaniowa', 600.00),
       (7, 'Premia specjalna', 900.00),
       (8, 'Premia za staż', 1000.00),
       (9, 'Premia nagrodowa', 750.00),
       (10, 'Premia eksportowa', 1100.00);


INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES (1, '2023-11-01', 1, 1, NULL),
       (2, '2023-11-02', 2, 2, 1),
       (3, '2023-11-03', 3, 3, 2),
       (4, '2023-11-04', 4, 4, 3),
       (5, '2023-11-05', 5, 5, 4),
       (6, '2023-11-06', 6, 6, 5),
       (7, '2023-11-07', 7, 7, 6),
       (8, '2023-11-08', 8, 8, 7),
       (9, '2023-11-09', 9, 9, 8),
       (10, '2023-11-10', 10, 10, 9),
       (11, '2023-11-10', 11, 11, NULL),
       (12, '2023-11-10', 12, 12, 10),
       (13, '2023-11-10', 13, 13, NULL);

-- a)
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;


-- b)
-- 5000zl zamiast 1000zl
SELECT id_pracownika, placa
FROM (SELECT id_pracownika,
             pensje.kwota + COALESCE(premie.kwota, 0) AS placa
      FROM ksiegowosc.wynagrodzenie
               JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
               LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii) as placa_pracownika
WHERE placa > 5000;


-- c)
SELECT id_pracownika, wynagrodzenie.id_premii, pensje.kwota as pensja
FROM ksiegowosc.wynagrodzenie
         JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
WHERE wynagrodzenie.id_premii IS NULL
  AND pensje.kwota > 2000;


-- d)
SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';


-- e)
SELECT *
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%'
  AND imie LIKE '%a';


-- f)
SELECT imie,
       nazwisko,
       date_part('month', godziny.data) as miesiac,
--     SUM(liczba_godzin)               as miesieczna_liczba_godzin,
       SUM(liczba_godzin) - 160         as miesiaczna_liczba_nadgodzin
FROM ksiegowosc.pracownicy
         JOIN ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika
GROUP BY pracownicy.id_pracownika, miesiac
HAVING SUM(liczba_godzin) > 160
ORDER BY miesiac DESC, miesiaczna_liczba_nadgodzin DESC;


-- g)
SELECT imie, nazwisko, pensje.kwota as pensja
FROM ksiegowosc.pracownicy
         JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
         JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
WHERE pensje.kwota BETWEEN 1500 AND 3000;


-- h)
SELECT imie, nazwisko, premie.id_premii
FROM (SELECT pracownicy.id_pracownika,
             imie,
             nazwisko,
             date_part('month', godziny.data) as miesiac
      FROM ksiegowosc.pracownicy
               JOIN ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika
      GROUP BY pracownicy.id_pracownika, miesiac
      HAVING SUM(liczba_godzin) > 160)
         as pracownicy_z_nadgodzinami
         JOIN ksiegowosc.wynagrodzenie ON pracownicy_z_nadgodzinami.id_pracownika = wynagrodzenie.id_pracownika
         LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
WHERE premie.id_premii IS NULL;


-- i)
SELECT imie,
       nazwisko,
       adres,
       telefon,
       pensje.kwota as pensja
FROM ksiegowosc.pracownicy
         JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
         JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY pensje.kwota DESC;


-- j)
SELECT imie,
       nazwisko,
       adres,
       telefon,
       pensje.kwota as pensja,
       premie.kwota as premia
FROM ksiegowosc.pracownicy
         JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
         JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
         LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
ORDER BY pensje.kwota DESC, premie.kwota DESC;


-- k)
SELECT stanowisko,
       COUNT(stanowisko) AS liczba_pracownikow
FROM ksiegowosc.pensje
GROUP BY stanowisko
ORDER BY liczba_pracownikow DESC, stanowisko;


-- l)
-- szukane stanowisko: Kierownik Projektu
SELECT stanowisko,
       AVG(kwota) AS srednia_placa,
       MIN(kwota) AS najmniejsza_placa,
       MAX(kwota) AS najwieksza_placa
FROM ksiegowosc.pensje
GROUP BY stanowisko
HAVING stanowisko = 'Kierownik Projektu';


-- m)
SELECT SUM(pensje.kwota) + SUM(premie.kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie
         JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
         LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii


-- n)
SELECT *,
       suma_pensji + suma_premii as suma_wynagrodzen
FROM (SELECT stanowisko,
             SUM(pensje.kwota)              as suma_pensji,
             COALESCE(SUM(premie.kwota), 0) AS suma_premii
      FROM ksiegowosc.pensje
               JOIN ksiegowosc.wynagrodzenie ON pensje.id_pensji = wynagrodzenie.id_pensji
               LEFT JOIN ksiegowosc.premie ON premie.id_premii = wynagrodzenie.id_premii
      GROUP BY stanowisko) AS sumy;


-- o)
SELECT stanowisko,
       count(premie.id_premii) as ilosc_przyznanych_premii
FROM ksiegowosc.pensje
         JOIN ksiegowosc.wynagrodzenie ON pensje.id_pensji = wynagrodzenie.id_pensji
         LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
GROUP BY stanowisko
ORDER BY ilosc_przyznanych_premii DESC;


-- p)

-- 5000zl zamiast 1200zl
DELETE
FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (SELECT id_pracownika
                        FROM ksiegowosc.wynagrodzenie
                                 JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
                        WHERE pensje.kwota < 5000);
