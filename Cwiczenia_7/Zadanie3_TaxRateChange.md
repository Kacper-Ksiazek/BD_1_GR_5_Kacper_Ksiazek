# Zmiany TaxRate

### 1. Tworzymy funkcje porownujace stare i nowe oprocentowanie

```sql
CREATE OR REPLACE FUNCTION sprawdz_zmiane_oprocentowania()
RETURNS TRIGGER AS $$
DECLARE
    old_tax_rate DECIMAL;
    new_tax_rate DECIMAL;
    max_change DECIMAL := 0.3; -- 30% maksymalna zmiana
BEGIN
    old_tax_rate := OLD.TaxRate;
    new_tax_rate := NEW.TaxRate;

    IF old_tax_rate IS NOT NULL AND new_tax_rate IS NOT NULL THEN
        IF ABS(new_tax_rate - old_tax_rate) / old_tax_rate > max_change THEN
            RAISE EXCEPTION 'Zmiana wartości w polu TaxRate o więcej niż 30%% jest niedozwolona.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### 2. Ustawiamy triggera ktory bedzie reagowac na zmiany wartosci TaxRate

```sql
CREATE TRIGGER monitoruj_zmiane_oprocentowania
BEFORE UPDATE OF TaxRate ON Sales.SalesTaxRate
FOR EACH ROW
WHEN (OLD.TaxRate IS DISTINCT FROM NEW.TaxRate)
EXECUTE FUNCTION sprawdz_zmiane_oprocentowania();
```

# Sprawdzenie

### 1. Proba ryzykownej zmiany wartosci kolumny TaxRate

```sql
UPDATE Sales.SalesTaxRate
SET TaxRate = 1000000
WHERE SalesTaxRateID = 1;
```
