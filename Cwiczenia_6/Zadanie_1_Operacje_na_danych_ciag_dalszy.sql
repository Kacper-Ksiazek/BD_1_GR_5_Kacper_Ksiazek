-- a)
ALTER TABLE ksiegowosc.pracownicy
    ALTER COLUMN telefon TYPE VARCHAR(20);

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48)', telefon);

-- b)

UPDATE ksiegowosc.pracownicy
SET telefon =
        CONCAT(
                SUBSTRING(telefon, 1, 8),
                '-',
                SUBSTRING(telefon, 9, 3),
                '-',
                SUBSTRING(telefon, 12, 3)
            );

-- c)
SELECT UPPER(imie)     AS imie,
       UPPER(nazwisko) AS nazwisko,
       UPPER(adres)    AS adres
FROM ksiegowosc.pracownicy
WHERE LENGTH(nazwisko) = (SELECT LENGTH(nazwisko) AS dlugosc_nazwiska
                          FROM ksiegowosc.pracownicy
                          ORDER BY dlugosc_nazwiska DESC
                          LIMIT 1);

-- d)
SELECT pracownicy.imie,
       pracownicy.nazwisko,
       pracownicy.adres,
       md5(pensje.kwota::VARCHAR) as pensja
FROM ksiegowosc.pracownicy
         JOIN ksiegowosc.wynagrodzenie
              ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
         JOIN ksiegowosc.pensje
              ON wynagrodzenie.id_pensji = pensje.id_pensji;


-- e)
SELECT pracownicy.imie,
       pracownicy.nazwisko,
       pracownicy.adres,
       pensje.kwota                             AS pensja,
       premie.kwota                             AS premia,
       pensje.kwota + COALESCE(premie.kwota, 0) AS wynagrodzenie
FROM ksiegowosc.pracownicy
         LEFT JOIN ksiegowosc.wynagrodzenie
                   ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
         LEFT JOIN ksiegowosc.pensje
                   ON wynagrodzenie.id_pensji = pensje.id_pensji
         LEFT JOIN ksiegowosc.premie
                   ON wynagrodzenie.id_premii = premie.id_premii


-- f)
SELECT CONCAT(
               'Pracownik ',
               pracownik,
               ', w dniu ',
               data,
               ' otrzymał pensję całkowitą na kwotę ',
               wynagrodzenie,
               ', gdzie wynagrodzenie zasadnicze wyniosło: ',
               pensja,
               ' zł, premia: ',
               premia,
               ' zł'
           ) as raport
FROM (SELECT CONCAT(pracownicy.imie,
                    ' ',
                    pracownicy.nazwisko)              as pracownik,
             godziny.data                             as data,
             pensje.kwota                             AS pensja,
             COALESCE(premie.kwota, 0)                AS premia,
             pensje.kwota + COALESCE(premie.kwota, 0) AS wynagrodzenie
      FROM ksiegowosc.pracownicy
               LEFT JOIN ksiegowosc.wynagrodzenie
                         ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
               LEFT JOIN ksiegowosc.pensje
                         ON wynagrodzenie.id_pensji = pensje.id_pensji
               LEFT JOIN ksiegowosc.premie
                         ON wynagrodzenie.id_premii = premie.id_premii
               LEFT JOIN ksiegowosc.godziny
                         ON wynagrodzenie.id_pracownika = godziny.id_pracownika) AS baza_raportu