-- Ejercicios Pair, 2.11 Operadores-Filtros --

USE northwind;

/*Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquellas compañías que están afincadas en ciudades
que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la compañía y el nombre de contacto.
*/

SELECT City AS ciudad, CompanyName AS nombre_compañia, ContactName AS nombre_contacto
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';

/*Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos
que han hecho todas las ciudades que empiezan por "L". */

SELECT c.City AS ciudad, c.CompanyName AS nombre_compañia, c.ContactName AS nombre_contacto, COUNT(o.orderID) AS total_pedidos
FROM customers AS c
INNER JOIN orders AS o
ON c.CustomerID = o.CustomerID
WHERE city LIKE 'L%'
GROUP BY city,CompanyName,ContactName;

/*Todos los clientes cuyo "country" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tengan el titulo de "Sales" en "ContactTitle" .
Extraer el nombre de contacto, su titulo de contacto y el nombre de la compañía.*/

SELECT ContactName AS nombre_contacto, ContactTitle AS titulo_contacto, CompanyName AS nombre_compañía
FROM customers
WHERE ContactTitle NOT LIKE '%Sales%';

/*Todos los clientes que no tengan una "A" en segunda posición en su nombre.

Devolved unicamente el nombre de contacto.*/


SELECT ContactName AS nombre_contacto
FROM customers
WHERE ContactName NOT LIKE '_A%';

/*Extraer toda la información sobre las compañías que tengamos en la bases de datos

Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la bases de datos.
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente).
Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal.
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.

Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/


SELECT city AS ciudad,CompanyName AS nombre_compañia,ContactName AS nombre_contacto, 'customers' AS Relationship
FROM customers
UNION
SELECT city,CompanyName,ContactName,'suppliers'
FROM suppliers;

-- Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".

SELECT CategoryName
FROM categories
WHERE Description  LIKE '%sweet%' OR Description LIKE '%Sweet%';

/*Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la bases de datos:

💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar
dos columnas usando concat para unir dos columnas. */

SELECT CONCAT(firstname, " ", lastname) AS nombre_completo, 'employees' AS type
FROM employees
UNION
SELECT ContactName, 'customers'
FROM customers;











