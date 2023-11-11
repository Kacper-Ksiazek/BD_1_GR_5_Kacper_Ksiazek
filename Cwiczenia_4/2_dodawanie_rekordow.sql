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
