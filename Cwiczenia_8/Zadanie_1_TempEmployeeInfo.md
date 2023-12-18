# Zadanie 1- Najwyzsze stawki w historii plac

### 1. Utworzenie tabeli TempEmployeeInfo

```sql
CREATE TABLE IF NOT EXISTS public.TempEmployeeInfo
(
    id        INT PRIMARY KEY,
    full_name VARCHAR(100),
    max_rate  DECIMAL(10, 2)
);
```

### 2. Utworzenie CTE wypełniającego nowo utworzoną tabelę

```sql
WITH MaxRate AS (SELECT person.businessentityid                                              AS id,
                        TRIM(CONCAT(firstname, ' ', middlename, ' ', lastname, ' ', suffix)) AS full_name,
                        MAX(payhistory.rate)                                                 AS max_rate
                 FROM person.person person
                          JOIN humanresources.employeepayhistory payhistory
                               ON person.businessentityid = payhistory.businessentityid
                 GROUP BY person.businessentityid
                 ORDER BY id)
INSERT
INTO TempEmployeeInfo (id, full_name, max_rate)
SELECT *
FROM MaxRate;
```
