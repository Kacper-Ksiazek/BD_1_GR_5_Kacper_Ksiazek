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