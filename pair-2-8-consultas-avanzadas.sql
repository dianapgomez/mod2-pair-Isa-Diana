USE northwind;

-- Productos más baratos y caros de nuestra la bases de datos:
-- Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. Dales el alias lowestPrice y highestPrice.--

SELECT*
FROM products;


SELECT ProductName, MAX(UnitPrice) AS highestPrice
FROM products
GROUP BY ProductName
ORDER BY highestPrice DESC;

SELECT ProductName, MIN(UnitPrice) AS lowesttPrice
FROM products
GROUP BY ProductName
ORDER BY lowesttPrice ASC;

--  Conociendo el numero de productos y su precio medio: 
-- Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos (en general, no por cada producto).

SELECT ProductName, COUNT(*) AS total_productos
FROM products
GROUP BY ProductName
ORDER BY total_productos DESC;

SELECT ProductName, ROUND(AVG(UnitPrice), 2) AS precio_medio
FROM products
GROUP BY ProductName
ORDER BY precio_medio DESC;

SELECT COUNT(ProductName) AS total_productos, ROUND(AVG(UnitPrice), 2) AS precio_medio_total
FROM products;

-- Sacad la máxima y mínima carga de los pedidos de UK:
-- Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de carga para un pedido (freight) enviado a Reino Unido (United Kingdom).

SELECT *
FROM orders;

SELECT ShipCountry, MAX(freight) AS carga_maxima
FROM orders
GROUP BY ShipCountry
HAVING Shipcountry IN ("UK");

SELECT ShipCountry, MIN(freight) AS carga_minima
FROM orders
GROUP BY ShipCountry
HAVING Shipcountry IN ("UK");

-- Qué productos se venden por encima del precio medio: 
-- Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer qué productos en concreto se venden por encima del precio medio para todos los productos de la empresa, ya que sospechan que dicho número es demasiado elevado. También quieren que ordenemos los resultados por su precio de mayor a menor.
-- 📌NOTA: para este ejercicio puedes necesitar dos consultas separadas y usar el resultado de la primera para filtrar la segunda.

SELECT COUNT(ProductName) AS total_productos, ROUND(AVG(UnitPrice), 2) AS precio_medio_total
FROM products;

SELECT ProductName, UnitPrice,
	CASE
		WHEN UnitPrice > 28.87 THEN "Por encima de la media"
		ELSE "Por debajo de la media" END AS precios
	FROM products
    ORDER BY UnitPrice DESC;
    
-- Qué productos se han descontinuado:
-- De cara a estudiar el histórico de la empresa nos piden una consulta para conocer el número de productos que se han descontinuado. 
-- El atributo Discontinued es un booleano: si es igual a 1 el producto ha sido descontinuado.

SELECT *
FROM products;

SELECT COUNT(Discontinued) AS cantidad_productos_descontinuados
FROM products
WHERE Discontinued = 1;

--  Detalles de los productos de la query anterior:
-- Adicionalmente nos piden detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName. 
-- Como puede que salgan demasiados resultados, nos piden que los limitemos a los 10 con ID más elevado, que serán los más recientes. 
-- No nos pueden decir del departamento si habrá pocos o muchos resultados, pero lo limitamos por si acaso.

SELECT ProductID, ProductName
FROM products
WHERE Discontinued = 0
LIMIT 10;

-- Relación entre número de pedidos y máxima carga:
-- Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).
SELECT*
FROM orders;

SELECT EmployeeID, COUNT(*) AS pedidos_por_empleado, MAX(freight) maxima_carga
FROM orders
GROUP BY EmployeeID;


-- Descartar pedidos sin fecha y ordénalos:
-- Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". 
-- En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. 
-- También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla.

SELECT EmployeeID, COUNT(*) AS pedidos_por_empleado, MAX(freight) maxima_carga 
FROM orders
WHERE ShippedDate IS NOT NULL
GROUP BY EmployeeID;

