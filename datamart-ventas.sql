CREATE DATABASE VentasTottus;
GO
USE VentasTottus;
GO

CREATE TABLE "DIM_PRODUCTO_DESTINO" (
    "ProductID" int,
    "Name" nvarchar(50),
    "CategoryID" int,
    "CategoryName" nvarchar(50),
	CONSTRAINT PKPRO PRIMARY KEY("ProductID")
)

CREATE TABLE "DIM_CLIENTE_DESTINO" (
    "CustomerID" int,
	"DemographicSegment" varchar(7),
	CONSTRAINT PKCLI PRIMARY KEY("CustomerID")
)

CREATE TABLE "DIM_TIEMPO_DESTINO" (
    "DateKey" int,
    "Day" int,
    "Month" int,
    "Quarter" int,
    "Year" int,
CONSTRAINT PKTIEMPO PRIMARY KEY ("DateKey") 
)

CREATE TABLE "DIM_TERRITORIO_DESTINO" (
    "TerritoryID" int,
    "Name" nvarchar(50),
CONSTRAINT PKTERRITORIO PRIMARY KEY ("TerritoryID")
)

CREATE TABLE "FACT_VENTAS_DESTINO" (
    "CustomerID" int,
    "ProductID" int,
    "TerritoryID" int,
    "DateKey" int,
    "SalesAmount" money,
CONSTRAINT PK1 FOREIGN KEY ("CustomerID") 
REFERENCES DIM_CLIENTE_DESTINO("CustomerID"),
CONSTRAINT PK2 FOREIGN KEY ("ProductID") 
REFERENCES DIM_PRODUCTO_DESTINO("ProductID"),
CONSTRAINT PK3 FOREIGN KEY ("TerritoryID") 
REFERENCES DIM_TERRITORIO_DESTINO("TerritoryID"),
CONSTRAINT PK4 FOREIGN KEY ("DateKey") 	
REFERENCES DIM_TIEMPO_DESTINO("DateKey")
)