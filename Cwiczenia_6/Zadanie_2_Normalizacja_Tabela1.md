# Tabela 1- Normalizacja

### Oryginał

| IDPracownika | NazwaLekarza   | IDPacjenta | NazwaPacjenta   | DataGodzinaWizyty | IDZabiegu | NazwaZabiegu      |
| ------------ | -------------- | ---------- | --------------- | ----------------- | --------- | ----------------- |
| S1011        | Maria Nowak    | P100       | Anna Jeleń      | 12.03.2020 10.00  | Z500      | Borowanie         |
| S1011        | Maria Nowak    | P105       | Jarosław Nicpoń | 12.03.2020 13.00  | Z496      | Lakowanie         |
| S1011        | Maria Nowak    | P108       | Joanna Nosek    | 14.03.2020 10.00  | Z500      | Borowanie         |
| S1024        | Jan Kowalski   | P108       | Joanna Nosek    | 16.03.2020 17.00  | Z503      | Usuwanie kamienia |
| S1045        | Anna Jabłońska | P120       | Jan Kałuża      | 18.03.2020 09.00  | Z500      | Borowanie         |
| S1034        | Marek Potocki  | P130       | Jerzy Lis       | 20.03.2020 08.00  | Z496      | Lakowanie         |
| S1034        | Marek Potocki  | P123       | Olga Nowacka    | 12.03.2020 15.00  | Z503      | Usuwanie kamienia |

### (1/4) Nowa tabela- Lekarze

```sql
CREATE TABLE IF NOT EXISTS Lekarze (
    ID VARCHAR(10) PRIMARY KEY UNIQUE,
    Imię VARCHAR(50),
    Nazwisko VARCHAR(50)
);
```

| ID    | Imię  | Nazwisko  |
| ----- | ----- | --------- |
| S1011 | Maria | Nowak     |
| S1024 | Jan   | Kowalski  |
| S1045 | Anna  | Jabłońska |
| S1034 | Marek | Potocki   |

### (2/4) Nowa tabela- Pacjenci

```sql
CREATE TABLE IF NOT EXISTS Pacjenci (
    ID VARCHAR(10) PRIMARY KEY UNIQUE,
    Imię VARCHAR(50),
    Nazwisko VARCHAR(50)
);
```

| ID   | Imię     | Nazwisko |
| ---- | -------- | -------- |
| P100 | Anna     | Jeleń    |
| P105 | Jarosław | Nicpoń   |
| P108 | Joanna   | Nosek    |
| P120 | Jan      | Kałuża   |
| P130 | Jerzy    | Lis      |
| P123 | Olga     | Nowacka  |

### (3/4) Nowa tabela- Zabiegi

```sql
CREATE TABLE IF NOT EXISTS Zabiegi (
    IDZabiegu VARCHAR(10) PRIMARY KEY UNIQUE,
    NazwaZabiegu VARCHAR(100)
);
```

| IDZabiegu | NazwaZabiegu      |
| --------- | ----------------- |
| Z500      | Borowanie         |
| Z496      | Lakowanie         |
| Z503      | Usuwanie kamienia |

### (4/4) Nowa tabela- Wizyty

```sql
CREATE TABLE IF NOT EXISTS Wizyty (
    IDZabiegu VARCHAR(10),
    IDPacjenta VARCHAR(10),
    IDPracownika VARCHAR(10),
    DataGodzina DATETIME
);
```

| IDZabiegu | IDPacjenta | IDPracownika | DataGodzina      |
| --------- | ---------- | ------------ | ---------------- |
| Z500      | P100       | S1011        | 12.03.2020 10.00 |
| Z496      | P105       | S1011        | 12.03.2020 13.00 |
| Z500      | P108       | S1011        | 14.03.2020 10.00 |
| Z503      | P108       | S1024        | 16.03.2020 17.00 |
| Z500      | P120       | S1045        | 18.03.2020 09.00 |
| Z496      | P130       | S1034        | 20.03.2020 08.00 |
| Z503      | P123       | S1034        | 12.03.2020 15.00 |
