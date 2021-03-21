-- use AdventureWorks2019  dataSet

USE [AdventureWorks2019]
GO

/*
1.
Indicate the national id number (nationalidnumber) and what is the rate (rate) 
registered by the company (EmployeePayHistory), for employees (employee) of female gender, 
and who were hired as of January 2009 (Hiredate ). 
The result must contain all the values ??registered in the first table, 
regardless of the fact that there is no similarity of values ??with the second table. 
*/

SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%RATE%'

SELECT * FROM [HumanResources].[Employee]

SELECT * FROM [HumanResources].[EmployeePayHistory]

SELECT E.NationalIDNumber, E.Gender , E.HireDate, P.Rate
FROM [HumanResources].[Employee] AS E
LEFT JOIN  [HumanResources].[EmployeePayHistory] AS P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.HireDate >= '2009-01-01' 
	AND E.Gender = 'F'

/*
2.
Indicate the business entity id (businessentityid), person id (personid), 
the contact type id (contacttypeid) which are registered in the business 
entity addresses (businessentityaddress), and the address type id ( addrestypeid)
for address id (addresid) greater than 1000. 
The last ones are stored in the company (businessentityaddress).
The result must not have null values in either table. 
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%businessentityaddress%'

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME LIKE '%contacttypeid%'

SELECT A.BusinessEntityID, A.AddressTypeID, C.PersonID, ContactTypeID 
FROM Person.BusinessEntityAddress AS A
INNER JOIN Person.BusinessEntityContact AS C
ON A.BusinessEntityID = C.BusinessEntityID
WHERE A.AddressID > 1000 

/*
3.
Indicate the product photo id (productphotoid), the photo file name (thumbnailphotofilename), 
the first 5 digits of the length of the photo (largephoto) registered by the company 
in the product photos (productphoto *), also the id of product (productid) of products 
that are numbered 920-931 (productproductphoto *) and also have a photo file name available.
Rename the new field as long.
*/

SELECT P.ProductPhotoID, P.ThumbnailPhotoFileName, LEFT(P.LargePhoto, 5) AS 'largephoto', PP.ProductID
FROM Production.ProductPhoto AS P
INNER JOIN Production.ProductProductPhoto AS PP
ON P.ProductPhotoID = PP.ProductPhotoID
WHERE PP.ProductID BETWEEN 920 AND 931
	AND P.ThumbnailPhotoFileName IS NOT NULL

--4
/*
Indicate the order number (workorderid), the sum of the quantity in order (orderqty)
for the orders registered by the company in the order orders (workerorder) 
and that have order id less than 100, operation sequence 1 and 2; 
and location id number 10 registered by the company as work order routing (workorderouting). 
*/

SELECT  * FROM Production.WorkOrderRouting R
WHERE R.OperationSequence BETWEEN 1 AND 2 AND R.LocationID = 10

SELECT O.WorkOrderID, o.OrderQty
FROM Production.WorkOrder O
WHERE O.WorkOrderID < 100 

SELECT O.WorkOrderID, SUM(o.OrderQty)
FROM Production.WorkOrder O
INNER JOIN Production.WorkOrderRouting R
ON O.WorkOrderID = R.WorkOrderID
WHERE O.WorkOrderID < 100 
	AND R.OperationSequence BETWEEN 1 AND 2 AND R.LocationID = 10
GROUP BY SUM(o.OrderQty)

--5
/*
Indicate the transaction id (transactionid), product id (productid), order reference id (referenceorderid), 
order line reference id (referenceorderlineid) and order registration date (modifieddate) 
for the product with id 784.
For this exercise, bear in mind that the company has registered the transactions in two tables: 
historical (transactionhistory) and historical file (transactionhistoryarchive), therefore they must be unified.
The resulting information is required to comprise the data stored on the minimum date of the history
and on the maximum date of the archive history, for this condition use subquery. 
In addition, in the historical table, only the information with the reference order id between the numbers 53455 and 53480 
should be obtained.
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%transactionhistory%' 
SELECT TOP 10 * FROM [Production].[TransactionHistory]
SELECT TOP 10 * FROM [Production].[TransactionHistoryArchive]

SELECT * 
FROM (
	SELECT TH.TransactionID, TH.ProductID, TH.ReferenceOrderID, TH.ReferenceOrderLineID, TH.ModifiedDate
	FROM [Production].[TransactionHistory] AS TH
	UNION 
	SELECT HA.TransactionID, HA.ProductID, HA.ReferenceOrderID, HA.ReferenceOrderLineID, HA.ModifiedDate
	FROM [Production].[TransactionHistoryArchive] AS HA
	) AS UnionTable
WHERE UnionTable.ProductID = 784 
	AND UnionTable.ReferenceOrderID BETWEEN 53455 AND 53480
