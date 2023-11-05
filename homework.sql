Задача 1:
Приведите десять типовых бизнес-процессов для предметной области 
ВИДЕО-ХОСТИНГ (Youtube), а также их соответствие по CRUD.

Загрузка видео
Create
Просмотр видео:
Read
Оценка видео
Create
Read
Комментирование видео:
Create
Read
Подписка на каналы
Create
Read
Создание канала:
Create
Редактирование видео:
Update
Удаление видео
Delete
Монетизация контента:
Create
Read
Update
Управление настройками приватности:
Update

2. Вывести название и стоимость товаров от 20 EUR.
SELECT ProductName, Price * 1 AS Price_eur
FROM [Products]
WHERE
Price >=20

3. Вывести страны поставщиков.
SELECT Country FROM [Suppliers]

4. В упорядоченном по стоимости виде вывести название и стоимость товаров от всех поставщиков, 
кроме поставщика 1.

SELECT ProductName, Price
FROM [Products]
Where not SupplierID = 1
Order by Price

5. Вывести контактные имена клиентов, кроме тех, что из France и USA.
SELECT ContactName
FROM [Customers]
WHERE
NOT Country IN ('France', 'USA')

6. вывести страны клиентов
SELECT DISTINCT
    Country
FROM Customers

7. вывести всех клиентов
SELECT *
FROM Customers

8. Вывести данные о поставщиках
SELECT
	SupplierName, 
    Country
FROM Suppliers

9. Вывести клиентов из `Germany`
SELECT *
FROM Customers
WHERE
	Country='Germany'
    
    9.Вывести город и почтовый индекс клиентов из `France`
SELECT
	City,
    PostalCode -- проекция
FROM Customers
WHERE
	Country='France' -- фильтрация

    10.Вывести клиентов из `Germany` (`Berlin`)
SELECT *
FROM Customers
WHERE
	Country='Germany'
    AND
    City='Berlin'

    11.Вывести клиентов не из `Germany`
SELECT *
FROM Customers
WHERE
NOT Country = 'Germany'

12.Вывести товары с ценой от `50` до `100` EUR
SELECT *
FROM Products
WHERE Price >= 50
AND Price <= 100

13.Вывести название и стоимость всех товаров**
SELECT
	ProductName,
    Price
FROM Products

14.Вывести клиентов из `Germany` и `France`
SELECT *
FROM Customers
WHERE Country='Germany'
OR Country='France'

15.Вывести клиентов, кроме тех, что из `UK` и `USA`
SELECT *
FROM Customers
WHERE
NOT Country='UK'
AND
NOT Country='USA'

16.Вывести номера телефонов поставщиков из `UK` и `Brazil`**
SELECT
	Phone
FROM Suppliers
WHERE Country = 'UK'
OR Country = 'Brazil'

17.Вывести название и стоимость товаров из категорий `1` и `3` со стоимостью до `50` EUR**
SELECT
	ProductName,
    Price
FROM Products
WHERE Price <= 50
AND CategoryID IN (1, 3)

18.Вывести товары с ценой от `80` до `190` EUR не из категории `5`**
SELECT *
FROM Products
WHERE Price >= 80 AND Price <= 190
AND
NOT CategoryID=5

19.Вывести товары с ценой от `10` до `50` EUR из категорий `1, 2, 3`**
SELECT *
FROM Products
WHERE Price BETWEEN 10 AND 50
AND CategoryID IN (1, 2, 3)

20.Вывести товары из `5` категории по возрастанию цены**
SELECT *
FROM Products
WHERE CategoryID=5
ORDER BY Price ASC

21.Вывести три самых дорогих товара**
SELECT *
FROM Products
ORDER BY Price DESC
LIMIT 3 OFFSET 0 -- стр. 1
-- LIMIT 3 OFFSET 3 -- стр. 2
-- LIMIT 3 OFFSET 6 -- стр. 3

22.Вывести название и стоимость одного самого дорогого товара из категории `1`
SELECT
	ProductName, -- проекция
   	Price        -- полей
FROM Products
WHERE CategoryID=1  -- фильтрация
ORDER BY Price DESC -- сортировка
LIMIT 1 -- лимитирование

23.Вывести товар, который находится на третьем месте среди самых дорогих**
SELECT *
FROM Products
ORDER BY Price DESC
LIMIT 1 OFFSET 2


