/*Para el DimProduct*/
SELECT 
    P.ProductID, 
    P.Name,
    PC.ProductCategoryID AS CategoryID,
    PC.Name AS CategoryName
FROM 
    Production.Product P
INNER JOIN 
    Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN 
    Production.ProductCategory PC ON PSC.ProductCategoryID = PC.ProductCategoryID
GROUP BY 
    P.ProductID, 
    P.Name,
    PC.ProductCategoryID,
    PC.Name
ORDER BY 
    P.ProductID ASC;

/*Cliente*/

SELECT 
    C.CustomerID,
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'Family'
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Student'
        ELSE 'Single'
    END AS DemographicSegment
FROM 
    Person.Person P 
INNER JOIN 
    Sales.Customer C ON P.BusinessEntityID = C.PersonID
WHERE 
    C.PersonID IS NOT NULL
ORDER BY
    C.CustomerID;





/*listado tabla tiempo*/
SELECT 
    DISTINCT CONVERT(int, FORMAT(S.OrderDate, 'yyyyMMdd')) AS DateKey,
    DAY(S.OrderDate) AS Day,
    MONTH(S.OrderDate) AS Month,
    DATEPART(QUARTER, S.OrderDate) AS Quarter,
    YEAR(S.OrderDate) AS Year
FROM 
    Sales.SalesOrderHeader S
ORDER BY 
    DateKey;

/*Listado tabla territorio*/
CREATE TABLE "DIM_TERRITORIO_DESTINO" (
    "TerritoryID" int,
    "Name" nvarchar(50),
CONSTRAINT PKTERRITORIO PRIMARY KEY ("TerritoryID")
)

SELECT 
    T.TerritoryID, 
    T.Name
FROM 
    Sales.SalesTerritory T
ORDER BY 
	T.TerritoryID;

/*Listado para hecho ventas origen*/
SELECT 
    S.CustomerID, 
    P.ProductID, 
    T.TerritoryID,
    CONVERT(int, FORMAT(S.OrderDate, 'yyyyMMdd')) AS DateKey,
    SUM(D.UnitPrice * D.OrderQty) AS SalesAmount
FROM 
    Sales.SalesOrderHeader S 
INNER JOIN 
    Sales.SalesOrderDetail D ON S.SalesOrderID = D.SalesOrderID
INNER JOIN 
    Production.Product P ON P.ProductID = D.ProductID 
INNER JOIN 
    Sales.SalesTerritory T ON T.TerritoryID = S.TerritoryID 
INNER JOIN 
    Sales.Customer C ON C.CustomerID = S.CustomerID
GROUP BY 
    S.CustomerID, 
    P.ProductID,
    T.TerritoryID,
	CONVERT(int, FORMAT(S.OrderDate, 'yyyyMMdd'))
ORDER BY 
    DateKey;


Select * from DIM_PRODUCTO_DESTINO
Select * from DIM_CLIENTE_DESTINO
Select * from DIM_TERRITORIO_DESTINO
Select * from DIM_TIEMPO_DESTINO
Select * from FACT_VENTAS_DESTINO

-- Top 10 productos más vendidos
-- Ventas por Categoria
-- Ventas por territorio
-- segemento de clientes que más se vende

select so.CustomerID from 
Sales.SalesOrderHeader so inner join Sales.Customer c ON c.CustomerID = so.CustomerID
Group by
so.CustomerID,so.SalesPersonID
Order By
so.CustomerID

DELETE FROM FACT_VENTAS_DESTINO