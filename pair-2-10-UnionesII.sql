/* Empleadas que sean de la misma ciudad:
Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. 
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?*/

USE northwind;

SELECT*
FROM employees;

SELECT LastName, FirstName, Title, City, ReportsTo
FROM employees
WHERE city = "London";


SELECT e1.city AS Ciudad_Empleado, e1.FirstName AS Nombre_Empleado, e1.LastName AS Apellido_Empleado, e1.Title AS Título, e2.city AS Ciudad_Jefe, e2.FirstName AS Nombre_Jefe, e2.LastName AS Apellido_Jefe, e2.Title AS Título 
FROM employees AS e1, employees AS e2
WHERE e1.ReportsTo = e2.EmployeeID;


/*El equipo de marketing necesita una lista con todas las categorías de productos, incluso si no tienen productos asociados. 
Queremos obtener el nombre de la categoría y el nombre de los productos dentro de cada categoría. Podriamos usar un RIGTH JOIN con 'categories'?, usemos tambien la tabla 'products'.*/


SELECT *
FROM products;

SELECT*
FROM categories;

SELECT c.CategoryName, p.ProductName
FROM products AS p RIGHT JOIN categories AS c
ON p.CategoryId = c.CategoryId;

/* Desde el equipo de ventas nos piden obtener una lista de todos los pedidos junto con los datos de las empresas clientes. 
Sin embargo, hay algunos pedidos que pueden no tener un cliente asignado. Necesitamos asegurarnos de incluir todos los pedidos, incluso si no tienen cliente registrado.*/

SELECT *
FROM orders;

SELECT * 
FROM customers;

SELECT o.OrderId, c.CompanyName 
FROM orders AS o LEFT JOIN customers AS c
ON c.CustomerID = o.CustomerId;

/* El equipo de Recursos Humanos quiere saber qué empleadas han gestionado pedidos y cuáles no. 
Queremos obtener una lista con todas las empleadas y, si han gestionado pedidos, mostrar los detalles del pedido.*/

SELECT *
FROM employees;

SELECT *
FROM orders;

SELECT e.EmployeeID, o.OrderID, o.ShipName, o.ShipAddress, o.ShipCity
FROM employees AS e LEFT JOIN orders AS o
ON e.EmployeeID = o.EmployeeID;


/*Desde el área de logística nos piden una lista de todos los transportistas (shippers) y los pedidos que han enviado. 
Queremos asegurarnos de incluir todos los transportistas, incluso si no han enviado pedidos.*/

SELECT * 
FROM shippers;

SELECT*
FROM orders;

SELECT s.CompanyName AS transportista, o.OrderID AS pedido
FROM shippers AS s LEFT JOIN orders AS o
ON s.ShipperID = o.ShipVia;
