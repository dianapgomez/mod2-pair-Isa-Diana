/* Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.*/

USE northwind;

SELECT *
FROM orders;

SELECT OrderID, Customerid, EmployeeID, OrderDate
FROM orders as p
WHERE p.OrderDate = (SELECT MAX(OrderDate)
					FROM orders
                    WHERE EmployeeID = p.EmployeeId);
                    

/*Extraed información de los productos "Beverages"
En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/

SELECT*
FROM categories;

SELECT ProductID, ProductName, CategoryID
FROM products  AS p
INNER JOIN categories AS c
USING (CategoryID)
WHERE categoryID IN (SELECT categoryID
						FROM categories
                        WHERE categoryName = "Beverages");

/* Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

SELECT *
FROM suppliers;

SELECT*
FROM customers;

SELECT c.Country AS Customer_Country
FROM suppliers AS s
RIGHT JOIN customers AS c
USING (country)
WHERE s.Country IS NULL AND c.Country IS NOT NULL
GROUP BY c.country;



SELECT country
FROM customers
WHERE country NOT IN (SELECT country
						FROM suppliers)
GROUP BY country;

/* Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.*/

SELECT*
FROM products;

SELECT *
FROM orderdetails;

SELECT od.OrderId, p.ProductId, od.Quantity
FROM orderdetails AS od
LEFT JOIN products AS p
USING (ProductID)
WHERE productID =6 AND quantity >= 20 IN (SELECT customerID
											FROM customers
                                            WHERE orderID= od.OrderId)

;





