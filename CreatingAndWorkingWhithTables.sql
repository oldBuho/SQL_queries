CREATE DATABASE mercadolibre_borrar


CREATE TABLE tipo_usuario
(
id_tipo_usuario INT PRIMARY KEY,
descripcion VARCHAR(100)
)


CREATE TABLE usuarios
(
id_usuario INT PRIMARY KEY,
nombre VARCHAR(50) ,
apellido VARCHAR(50),
domicilio VARCHAR(100),
email VARCHAR(50),
telefono VARCHAR(50),
id_tipo_usuario INT FOREIGN KEY REFERENCES tipo_usuario(id_tipo_usuario)
)


CREATE TABLE productos
(
id_productos INT PRIMARY KEY, 
precio DECIMAL(18,2),
descripcion VARCHAR(50), 
categoria VARCHAR(50), 
valoracion DECIMAL(12,2),
descuento DECIMAL(12,2),
dimensiones VARCHAR(50),
stock INT,
contador_compras INT
)

-- DROP TABLE productos

ALTER TABLE usuarios 
ADD fecha_de_nacimiento DATE


INSERT INTO usuarios VALUES (1, 'Gustavo', 'Vargas', 'Olleros 3213', 'gv@g.com','+5491112345678', '1','1992-06-04')
INSERT INTO usuarios VALUES (2, 'Marta', 'Lopez', 'Cerrito 654513', 'ml@g.com','+5491112345999', '2','1983-09-01')
INSERT INTO usuarios VALUES (3, 'Facu', 'Perez', 'Libertador 123', 'fp@g.com','+54931654646', '1','1992-01-25')

INSERT INTO tipo_usuario(id_tipo_usuario, descripcion) VALUES (1, 'Comprador')
INSERT INTO tipo_usuario(id_tipo_usuario, descripcion) VALUES (2, 'Vendedor')

INSERT INTO productos([id_productos],[precio],[descripcion],[categoria]) VALUES (1, 1500.01, 'Boxers', 'Ropa e indumentaria')

SELECT * FROM [dbo].[productos]
SELECT * FROM [dbo].[tipo_usuario]

UPDATE usuarios
SET domicilio = 'Olleros 666'
WHERE id_usuario = 1


-- DELETE FROM usuarios
-- WHERE id_usuario = 1


-- string function e.g.

SELECT LEFT(nombre, 5), nombre
FROM [dbo].[usuarios]

SELECT CONCAT(nombre, '-', apellido, '--', domicilio) AS user_data
FROM [dbo].[usuarios]

SELECT UPPER(REPLACE(nombre, 'a', 'x'))
FROM 
WHERE id_tipo_usuario = 2

SELECT LTRIM(RTRIM(nombre)) FROM [dbo].[usuarios]
-- or
SELECT TRIM(nombre) FROM [dbo].[usuarios]

-- year function e.g

SELECT TOP 1 YEAR(GETDATE()) AS 'YEAR' FROM usuarios

SELECT * FROM usuarios
WHERE YEAR([fecha_de_nacimiento]) <> 1992

-- MONTH
SELECT * FROM usuarios
WHERE MONTH(fecha_de_nacimiento) = 06

-- DAY
SELECT * FROM usuarios
WHERE MONTH(fecha_de_nacimiento) = 01


-- mixed
SELECT * FROM usuarios
WHERE YEAR(fecha_de_nacimiento) = 1992
AND MONTH(fecha_de_nacimiento) = 01
AND DAY(fecha_de_nacimiento) < 15

-- DATEADD ej add 30 years to DOB
SELECT fecha_de_nacimiento,
DATEADD(YEAR, -10, fecha_de_nacimiento) AS 'dateadd'
FROM usuarios

-- substract one year
SELECT fecha_de_nacimiento,DATEADD(DAY, -365, fecha_de_nacimiento) AS dateAdd
FROM usuarios

--DATEPART

SELECT
DATEPART(DAY, fecha_de_nacimiento) AS 'día',
DATEPART(MONTH, fecha_de_nacimiento) AS 'mes'
FROM usuarios

-- CAST - change datatype, useful in JOIN
SELECT CAST(RIGHT(domicilio, 2) AS TEXT), domicilio 
FROM usuarios

-- simple sub-query just e.g.
SELECT * FROM usuarios
WHERE fecha_de_nacimietno = 
	(
	SELECT MAX(fecha_de_nacimiento) 
	FROM usuarios
	)

-- desafio generico 
SELECT *
FROM usuarios 
WHERE id_usuario = 1 OR id_usuario = 3

-- CREATE A NEW FIELD "AGE"
ALTER TABLE usuarios
ADD edad INT NULL DEFAULT 'no contesta'

-- SET STATEMENT TO EXTRACT DATA FORM DATE OF BIRTH
UPDATE [dbo].[usuarios]
SET edad =  DATEDIFF(DAY, fecha_de_nacimiento, GETDATE())/365

SELECT * FROM [dbo].[usuarios]

SELECT TOP 1 YEAR(GETDATE()) AS 'YEAR' FROM usuarios


-- EG 
SELECT * FROM usuarios
WHERE edad BETWEEN 28 AND 42

