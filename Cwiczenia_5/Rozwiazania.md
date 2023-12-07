# 📝 Zadanie 1- Relacje funkcyjne

Dla tabeli zamowienia **(id_produktu, nazwa_produktu, id_klienta, nazwa_klienta,
data_zamowienia, cena_produktu, ilość, VAT, suma_brutto, suma_netto)** określ wszystkie
zależności funkcyjne.

**Odpowiedź:**

1. **Id_produktu** -> nazwa_produktu, cena_produktu, VAT
2. **Id_klienta** -> nazwa_klienta
3. **Id_klienta, data_zamowienia** -> suma_brutto, suma_netto
4. **cena_produktu, vat**-> cena_brutto, cena_netto
5. **data_zamowienia, id_produktu, id_klienta**->ilosc

---

# 📝 Zadanie 2- Klucze kandydujace

Wypisz klucze kandydujace

**Odpowiedź:**

1. **id_produktu**
2. **id_klienta**
3. **data_zamowienia**

---

# 📝 Zadanie 3- Klucze kandydujace

Dla tabeli pomieszczenia **(id_pomieszczenia, numer_pomieszczenia, id_budynku,
powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy)** określ wszystkie
zależności funkcyjne oraz klucze kandydujące.

**Zależności funkcyjne:**

1. **id_pomieszczenia** -> numer_pomieszczenia, id_budynku, powierzchnia, liczba_okien, liczba_drzwi
2. **id_budynku** -> ulica, miasto, kod_pocztowy

**Klucze kandydujące:**

1. **id_pomieszczenia**
2. **id_budynku, numer_pomieszczenia**
