# Zadanie 2- Terytoria operacyjne klientow

### 1. Rozwiązanie

```sql
WITH OperatingTerritory AS (SELECT customer.CustomerID                            AS customerid,
                             customer.TerritoryID                           AS customerterritoryid,
                             CONCAT(person.FirstName, ' ', person.LastName) AS salespersoninthisteritory
                      FROM sales.customer customer
                               JOIN
                           sales.salesperson sales_person ON customer.TerritoryID = sales_person.TerritoryID
                               JOIN
                           person.person person ON sales_person.BusinessEntityID = person.BusinessEntityID)

SELECT *
FROM OperatingTerritory;
```
