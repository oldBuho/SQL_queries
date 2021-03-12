USE AdventureWorks2019_coderhouse
GO

/* 
1.
Indicate the business entity number (BusinessEntityId) and the first three
numbers of each national identification number (NationalIDNumber), of each
one of the employees (Employee). Rename the new column as id_three. 
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%NationalIDNumber%'

SELECT * FROM [HumanResources].[Employee]

SELECT HE.[BusinessEntityID], LEFT(HE.[NationalIDNumber], 3) AS 'id_three'
FROM [HumanResources].[Employee] AS HE


/*
2.
Enter the address id (addressid), address line one (Addressline1) and
the last four digits of each postal code (postalcode), of each registered address (address).
Remove spaces at the beginning and end of the resulting values.
Rename the new column as postal_4.
*/

SELECT  * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Addressline1%' 

SELECT TOP 1 [AddressID], [AddressLine1], TRIM(RIGHT([PostalCode], 4)) AS 'postal_4'
FROM [Person].[Address]

/*
3.
Indicate the state province id (stateprovinceid), and the concatenation of the country
region code (countryregioncode), name (name) and state province code (stateprovinceid) fields.
The result should use two separators first forward slash (/) and then hyphen (-). 
Example: CA / California-CA. Rename the new column as a region. 
The results in the new column must be in uppercase.
*/

SELECT  * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%countryregioncode%' 
UNION
SELECT  * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%stateprovinceid%' 

SELECT [StateProvinceID], UPPER(CONCAT([CountryRegionCode], '/', [Name], '-', [StateProvinceCode])) AS 'region'
FROM [Person].[StateProvince]

/*
4.
Indicate the product photo id (productphotoid) and the photo file name (thumbnailphotofilename). 
Replace the file type gif, by jpeg in each of the records (productphoto). 
Rename the new column as photo.
*/

SELECT  * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%thumbnailphotofilename%' 

SELECT [P].[ProductPhotoID], REPLACE([P].[ThumbnailPhotoFileName], '.gif', '.jpeg') AS 'photo'
FROM [Production].[ProductPhoto] AS [P]

/*
5.
Indicate the unit measure code, the name and the year in which each record was modified (modifieddate).
Rename the new column as year_modification.
*/

SELECT  * FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%modifieddate%' 

SELECT 
	[UnitMeasureCode], 
	[Name], 
	YEAR([ModifiedDate]) AS 'year_modification'
FROM [Production].[UnitMeasure]

/*
6.
Indicate the credit card id (Creditcardid), the type of card (cardtype) 
and the month (January, February, etc.) in which each record stored for credit cards (Creditcard)
was modified (modifieddate). Rename the new column Month_modification.
*/

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME LIKE '%cardtype%'

SELECT * FROM [Sales].[CreditCard]

SELECT [CreditCardID], [CardType], DATENAME(MONTH, [ModifiedDate]) AS Month_modification
FROM [Sales].[CreditCard]

/*
7
Indicate the transaction id (transactionid), the order reference id (referenceorderid) 
and the day of the month (transactiondate) on which the transaction was recorded in the
history (transactionhistoryarchive). 
Rename the new column as transaction_day.
*/

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME LIKE '%transactiondate%'

SELECT [TransactionID], [ReferenceOrderID], DATEPART(DAY, [TransactionDate]) AS transaction_day
FROM [Production].[TransactionHistoryArchive]

/*
8.
Indicate the order id (workorderid), the start date (stardate) and what the delivery date would be, 
if each order must be received 30 days after its start. 
Consult for each registered order (workorder). 
Rename the new column as estimated_delivery.
*/

SELECT * FROM Production.WorkOrder

SELECT
	WorkOrderID,
	StartDate,
	DATEADD(DAY, 30, StartDate) AS 'estimated_delivery'
FROM 
	Production.WorkOrder




/*
9.
Indicate the order id (workorderid) and how many days there are between the scheduled start date 
(scheduledstartdate) and the scheduled end date (scheduledenddate), for order id between 72060 and 72070. 
The information corresponding to the maximum record date (modifieddate), yes add the date manually. 
Rename the new column as difference_days.
*/

SELECT
	[WorkOrderID],
	[ScheduledStartDate],
	[ScheduledEndDate],
	DATEDIFF(DAY, [ScheduledStartDate], [ScheduledEndDate]) AS 'difference_days'
FROM
	[Production].[WorkOrderRouting]
WHERE
	[WorkOrderID] BETWEEN 72060 AND 72070 AND
	[ModifiedDate] = (
					SELECT 
						MAX([ModifiedDate])
					FROM 
						[Production].[WorkOrderRouting]
					)
									   					 				  				  				 
/*
10.
Indicate the sales order number (salesorderid) and the integer corresponding to the unit price (unitprice),
of all the records of the sales details (salesorderdetail), for the order number 43659. 
The information corresponding to the minimum is required record date (modifieddate), 
without adding the date condition manually.
Rename the new column as price_in_integers.
*/

SELECT
	[SalesOrderID],
	[UnitPrice],
	CAST([UnitPrice] AS INT) AS price_in_integers
	-- FLOOR([UnitPrice])
FROM 
	[Sales].[SalesOrderDetail]
WHERE 
	[SalesOrderID] = 43659 
	AND
	[ModifiedDate] = 
	(
	SELECT MIN([ModifiedDate])
	FROM [Sales].[SalesOrderDetail]
	)



