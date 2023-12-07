# Tabela 2- Normalizacja

### Oryginał

| NazwaProduktu   | Dostawca1         | Dostawca2            | AdresDostawcy1                      | AdresDostawcy2                       | Cena                        |
| --------------- | ----------------- | -------------------- | ----------------------------------- | ------------------------------------ | --------------------------- |
| Makaron Nitki   | Makarony Polskie  | Lubelski Makaron     | Turystyczna 40, 31-435 Kraków       | Piłsudskiego 332a, 04-242 Lublin     | Netto 130 zł, brutto 150 zł |
| Keczup pikantny | Polskie przetwory | Przetwory pomidorowe | Wojska Polskiego 44a, 31-342 Kraków | Rolnicza 22/4 30-243 Tarnów          | Netto 200 zł, brutto 220 zł |
| Sos pomidorowy  | Polskie przetwory | Małopolskie smaki    | Wojska Polskiego 44a, 31-342 Kraków | Mickiewicza 223/77, 35-434 Nowy Targ | Netto 89 zł, brutto 110 zł  |

### (1/4) Nowa tabela- KodyPocztowe

```sql
CREATE TABLE IF NOT EXISTS KodyPocztowe (
    KodPocztowy VARCHAR(10) PRIMARY KEY,
    Miasto VARCHAR(50)
);
```

| KodPocztowy | Miasto    |
| ----------- | --------- |
| 31-342      | Kraków    |
| 31-435      | Kraków    |
| 04-242      | Lublin    |
| 30-243      | Tarnów    |
| 35-434      | Nowy Targ |

### (2/4) Nowa tabela- Producenci

```sql
CREATE TABLE IF NOT EXISTS Producenci (
    IDProducenta INT PRIMARY KEY AUTO_INCREMENT,
    Nazwa VARCHAR(50) UNIQUE,
    Ulica VARCHAR(100),
    KodPocztowy VARCHAR(10)
);
```

| IDProducenta | Nazwa                | Ulica                | KodPocztowy |
| ------------ | -------------------- | -------------------- | ----------- |
| 1            | Makarony Polskie     | Turystyczna 40       | 31-435      |
| 2            | Lubelski Makaron     | Piłsudskiego 332a    | 04-242      |
| 3            | Polskie przetwory    | Wojska Polskiego 44a | 31-342      |
| 4            | Przetwory pomidorowe | Rolnicza 22/4        | 30-243      |
| 5            | Małopolskie smaki    | Mickiewicza 223/77   | 35-434      |

### (3/4) Nowa tabela- Produkty

```sql
CREATE TABLE IF NOT EXISTS Produkty (
    IDProduktu INT PRIMARY KEY AUTO_INCREMENT,
    NazwaProduktu VARCHAR(100),
    Netto FLOAT,
    Brutto FLOAT
);
```

| IDProduktu | NazwaProduktu   | Netto | Brutto |
| ---------- | --------------- | ----- | ------ |
| 1          | Makaron Nitki   | 120   | 150    |
| 2          | Keczup pikantny | 180   | 200    |
| 3          | Sos pomidorowy  | 75    | 100    |

### (4/4) Nowa tabela- DostawcyProduktow

```sql
CREATE TABLE IF NOT EXISTS ProduktyDostawcy (
    IDProduktu INT,
    IDProducenta INT,
);
```

| IDProduktu | IDProducenta |
| ---------- | ------------ |
| 1          | 1            |
| 1          | 2            |
| 2          | 3            |
| 2          | 4            |
| 3          | 3            |
| 3          | 5            |
