# Zamiana wielkosci liter nazwiska na duze

### 1. Utworzenie funkcji powiekszajacej nazwisko

```sql
CREATE OR REPLACE FUNCTION powieksz_nazwisko()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.lastname = UPPER(NEW.lastname);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### 2. Dodatnie trigera, ktory wykona powyzsza funkcje

```sql
CREATE TRIGGER powieksz_nazwisko_trigger
    BEFORE INSERT OR UPDATE
    ON person.person
    FOR EACH ROW
EXECUTE FUNCTION powieksz_nazwisko();
```

---

# Sprawdzanie

### 1. Utworzenie bezpiecznego rekordu

```sql
INSERT INTO person.person (businessentityid, persontype, namestyle, title, firstname, middlename, lastname, suffix,
                           emailpromotion, additionalcontactinfo, demographics, rowguid, modifieddate)
VALUES (1000, 'EM', false, 'Mr.', 'Ken', 'J', 'ksiazek', NULL, 0, NULL, NULL, '92C4279F-1207-48A3-8448-4636514EB7E2',
        '2009-01-07 00:00:00.000');
```

### 2. Sprawdzenie jego nazwiska

```sql
SELECT lastname FROM person.person WHERE businessentityid = 1000;
```
