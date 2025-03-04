-- Ejercicios PAIR 2.9 UNIONES (JOINS I)

USE northwind;

/* 1.-
Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base
 de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
 Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.
 */
 
 SELECT *
	FROM orders;
--
SELECT CustomerID, COUNT(OrderID)
	FROM orders
    GROUP BY CustomerID;
    
--
SELECT o.CustomerID, c.CompanyName, COUNT(OrderID)
	FROM orders AS o
    INNER JOIN customers AS c
    ON o.CustomerID = c.CustomerID
    WHERE c.Country = "UK"
    GROUP BY CustomerID;
    
/*
Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición
anterior y han decidido pedirnos una serie de consultas adicionales. La primera de ellas
consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa
cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa,
el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
*/

SELECT *
	FROM orderdetails AS od; -- Quantity, and OrderID

SELECT *
	FROM customers AS c; -- CustomerID,CompanyName

SELECT *
	FROM orders AS o; -- OrderID, CustomerID, OrderDate
-- También usaremos la tabla "orders", ya que contiene OrderID y CustomerID para poder establecer nexos.

SELECT c.CompanyName, SUM(od.Quantity), YEAR(o.OrderDate)
	FROM orders AS o
    INNER JOIN customers AS c
    ON o.CustomerID = c.CustomerID
    INNER JOIN orderdetails AS od
    ON o.OrderID = od.OrderID
    WHERE c.Country = "UK"
    GROUP BY CompanyName, YEAR(o.OrderDate);
    
/*Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido,
desde la central nos han pedido una consulta que indique el nombre de cada compañía cliente junto
con cada pedido que han realizado y su fecha.
*/

SELECT  o.OrderID, c.CompanyName, o.OrderDate
	FROM orders AS o
    INNER JOIN customers AS c
    ON o.CustomerID = c.CustomerID
    GROUP BY OrderID;
    
/*

Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías,
nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha
vendido cada tipo de producto (teniendo en cuenta los descuentos).
*/

SELECT *
	FROM products; -- CategoryID, ProductName, ProductID
SELECT *
	FROM categories; -- CategoryID, CategoryName
SELECT *
	FROM orderdetails; -- ProductID, UnitPrice, Quantity, Discount
 --
 
SELECT  p.CategoryID, p.ProductName, c.CategoryName, SUM(od.UnitPrice*od.Quantity AS Total_pedido
	FROM products AS p
    INNER JOIN categories AS c
    ON p.CategoryID = c.CategoryID
    INNER JOIN orderdetails AS od
    ON od.ProductID = p.ProductID
    GROUP BY CategoryID, ProductName;
    
    -- Descuento (por probar +): SUM(od.UnitPrice*od.Quantity)*(1-(od.Discount/100))
    
-- BONUS

/*
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva
el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
*/

SELECT c.CompanyName, o.OrderID, o.OrderDate
	FROM customers AS c
    INNER JOIN orders AS o
    ON c.CustomerID = o.CustomerID
    ORDER BY OrderID;
    
    /*
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número
de pedidos que ha realizado cada cliente del propio Reino Unido de cara a conocerlos
mejor y poder adaptarse al mercado actual. Específicamente nos piden el nombre de cada
compañía cliente junto con el número de pedidos.
*/

SELECT c.CompanyName, COUNT(OrderID) AS NumeroPedidos
	FROM orders AS o
    INNER JOIN customers AS c
    ON o.CustomerID = c.CustomerID
    WHERE c.Country = "UK"
    GROUP BY CompanyName;

    
/*Desde la dirección de ventas nos solicitan generar todas las combinaciones posibles entre
empleadas y territorios de ventas. Queremos ver qué pasaría si cualquier empleada pudiera
trabajar en cualquier territorio. Nota Tal vez un CROSS JOIN sea la solucion....
*/
    SELECT e.EmployeeID, t.TerritoryID
		FROM employees AS e
		CROSS JOIN territories AS t;
         


