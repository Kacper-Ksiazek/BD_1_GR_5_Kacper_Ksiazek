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
