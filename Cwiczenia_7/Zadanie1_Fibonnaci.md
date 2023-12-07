# Ciag Fibonnaciego

### 1. Utworzenie funkcji, ktora stworzy kolejne elmenty ciagu

```sql
CREATE OR REPLACE FUNCTION stworz_ciag_fibonnaciego(n INT)
RETURNS SETOF INT AS $$
DECLARE
    a INT := 0;
    b INT := 1;
    counter INT := 0;
BEGIN
    WHILE counter <= n LOOP
        RETURN NEXT a;
        counter := counter + 1;
        a := a + b;
        b := a - b;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;
```

### 2. Utworzenie procedury wypisujacej wygenerowane elementy

```sql
CREATE OR REPLACE PROCEDURE fibonacci(n INT)
LANGUAGE plpgsql AS $$
DECLARE
    fib_number INT;
BEGIN
    RAISE NOTICE 'Pierwsze 10 elemnetow ciagu Fibonacciego %:', n;

    FOR fib_number IN SELECT * FROM  stworz_ciag_fibonnaciego(n) LOOP
        RAISE NOTICE '%', fib_number;
    END LOOP;
END;
$$;
```

# Sprawdzenie

### 1. Wywolanie procedury

```sql
CALL fibonacci(10);
```
