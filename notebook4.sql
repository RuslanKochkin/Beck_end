# DB #4 / Oct 16, 2023

**Задача. Вывести данные о товарах с ценой от `10` до `150` EUR**

(проекция: `ср_цена`, `ко-во_товаров`)

```sql
SELECT 
	AVG(Price) AS avg_price,
	COUNT(*) AS products_count
FROM Products

WHERE
 Price BETWEEN 10 AND 150
```

**Задача. Вывести заказы менеджера `5`**

(проекция: `имя_менеджера`, `фамилия_менеджера`, `номер_заказа`)

```sql
SELECT 
	Orders.OrderID,
	Employees.FirstName,
	Employees.LastName
FROM Orders

JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID

WHERE 
	Employees.EmployeeID = 5
```

## **Группировка в SQL (механизм агрегации) / оператор `GROUP BY`**

**Пример. Вывести страны покупателей**

```sql
SELECT DISTINCT
	Country
FROM Customers

SELECT
    COUNT(*) AS total_customers
FROM Customers

-- конечное решение
SELECT
		Country,
    COUNT(*) AS total_customers
FROM Customers

GROUP BY Country

ORDER BY total_customers DESC
```

**Пример. Вывести кол/распределение товаров по категориям**

```sql
SELECT
		CategoryID,
    COUNT(*) AS total_products
FROM Products

GROUP BY CategoryID

ORDER BY total_products DESC
```

**Задача. Вывести кол/распределение товаров по поставщикам (без `JOIN`)**

```sql
SELECT
		SupplierID,
    COUNT(*) AS total_products
FROM Products

GROUP BY SupplierID

ORDER BY total_products DESC
```

**Задача. Вывести кол/распределение товаров по поставщикам**

(проекция: `название_компании_поставщика`, `ко-во_поставленных_товаров`)

```sql
SELECT
		Suppliers.SupplierName,
    COUNT(*) AS total_products
FROM Products

JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID

GROUP BY Suppliers.SupplierID

ORDER BY total_products DESC
```

**Задача. Вывести кол/распределение заказов по клиентам**

(проекция: `имя_клиента`, `ко-во_заказов`)

```sql
SELECT
		Customers.CustomerName,
    COUNT(*) AS total_orders
FROM Orders

JOIN Customers ON Orders.CustomerID=Customers.CustomerID

GROUP BY Customers.CustomerID

ORDER BY total_orders DESC
```

**Задача. Вывести статистику по заказам для менеджеров `1, 2, 5` (для каждого отдельно)**

проекция: `фамилия_менеджера`, `ко-во_заказов`

```sql
SELECT 
	Employees.LastName, 
	COUNT(*) AS count_orders 
FROM Orders

JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID

WHERE
	Orders.EmployeeID IN (1, 2, 5)

GROUP BY Orders.EmployeeID

ORDER BY count_orders DESC
```

**Задача. Вывести ТОП-1 компанию-перевозчика по количеству доставок**

(проекция: `название_компании`, `ко-во_заказов`)

```sql
SELECT
		Shippers.ShipperName,
    COUNT(*) AS total_orders
FROM Orders

JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID

GROUP BY Orders.ShipperID

ORDER BY total_orders DESC
LIMIT 1
```

**Задача. Вывести стоимость каждого заказа в упорядоченном виде**

(проекция: `номер_заказа`, `сумма_заказа`)

```sql
SELECT
		OrderDetails.OrderID,
    SUM(OrderDetails.Quantity * Products.Price) AS order_cost

FROM OrderDetails

JOIN Products ON OrderDetails.ProductID=Products.ProductID

GROUP BY OrderDetails.OrderID

ORDER BY order_cost DESC
```

## Оператор `HAVING`

- аналог `WHERE`, который позволяет отфильтровать агрегированные данные

**Пример. Вывести заказы со стоимостью от `10000` (EUR)**

```sql
SELECT
		OrderDetails.OrderID,
    SUM(OrderDetails.Quantity * Products.Price) AS order_cost

FROM OrderDetails

JOIN Products ON OrderDetails.ProductID=Products.ProductID

GROUP BY OrderDetails.OrderID

HAVING
	order_cost >= 10000

ORDER BY order_cost DESC
```

**Задача. Вывести поставщиков, у которых средняя стоимость товара выше `40` EUR**

(проекция: `название_компании_поставщика`, `сред_стоимость`)

```sql
SELECT 
		Suppliers.SupplierName,
		AVG(Products.Price) AS avg_price
FROM Products

JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID

GROUP BY Products.SupplierID
HAVING
	avg_price > 40

ORDER BY avg_price DESC
```

**Задача. Вывести страны, в которые было отправлено `3` и более заказов**

(проекция: `страна`, `ко-во заказов`)

```sql
SELECT
		Customers.Country,
    COUNT(*) AS total_orders
FROM Orders

JOIN Customers ON Orders.CustomerID = Customers.CustomerID

GROUP BY Customers.Country
HAVING
	total_orders >= 3

ORDER BY total_orders DESC
```

## Основные типы данных в MySQL

- каждый столбец (поле) таблицы должен иметь указание на тип данных

### Числовые

- `int` / `integer`
- `float`

### Строковые

- `varchar(x)`
    - `x` - макс. ко-во символов
- `text(x)`
    - `x` - макс. ко-во символов

### Логические

- `bool`

### Дата / время

- `datetime` / `**timestamp**`
- `date`
- `time`

## Схема БД “онлайн-шахматы”

**Сущности**

1. `players`
    1. `псевдоним`
2. `matches`
    1. `флаг_завершенности`
    2. `кто_победитель`
    3. `кто_с_кем_играл`
3. `chats`
    1. `в_рамках_какого_матча`
4. `messages`
    1. `содержимое`
    2. `кто_автор`
    3. `в_рамках_какого_чата`
5. `maps`
    1. `название`

## Ссылки

- [пример схемы БД “онлайн-школа”](https://dbdiagram.io/d/online_school-652d79b5ffbf5169f0cb9013)
- [инструмент онлайн-проектирования БД](https://dbdiagram.io/d/)
- [песочница](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all)


#


Ссылки
пример схемы БД “кинотеатр”
пример схемы БД “видео-хостинг”
супер-песочница
бесплатное облако MongoDB
как установить MySQL на Windows
справочник по SQL
справочник по MongoDB
Примеры запросов

// Количественное распределение юзеров по странам
db.users.aggregate([
    {
        $group: {
            _id: '$country', // поле группировки
            total_users: { $count: {} }
        }
    }
])

// Вывести общее ко-во юзеров
db.users.aggregate([
    {
        $group: {
            _id: null, // поле группировки
            total_users: { $count: {} }
        }
    }
])
Screenshot from 2023-10-27 19-50-46.png

Задача. Вывести страны поставщиков

SELECT DISTINCT
    Country
FROM Suppliers
Задача. Вывести название и стоимость в USD товаров от поставщиков 1 и 4

SELECT 
    ProductName,
    Price * 1.05 AS Price_usd
FROM Products

WHERE
    SupplierID IN (1, 4)
Задача. Вывести названия товаров с ценой от 10 до 150 EUR из категории 4

SELECT
        ProductName,
    Price
FROM Products

WHERE
        CategoryID = 4
    AND
    Price BETWEEN 10 AND 150;
Задача. Вывести клиентов, кроме тех, что из UK и USA (без использования оператора IN)

SELECT *
FROM Customers

WHERE
    NOT Country='UK'
    AND
    NOT Country='USA'
Задача. Вывести номера телефонов поставщиков из UK и Brazil (без использования оператора IN)

SELECT
        Phone
FROM Suppliers

WHERE
        Country = 'UK'
    OR
    Country = 'Brazil'
Задача. Вывести заказы клиентов 90 и 81

(проекция: номер_заказа, имя_клиента)

SELECT
    Orders.OrderID,
    Customers.CustomerName
FROM Orders

JOIN Customers ON Orders.CustomerID = Customers.CustomerID

WHERE
    Orders.CustomerID IN (90, 81)
Ключевое слово USING()
Пример

JOIN Customers USING(CustomerID)
SELECT
    Orders.OrderID,
    Customers.CustomerName
FROM Orders

JOIN Customers USING(CustomerID)
-- JOIN Customers ON Orders.CustomerID = Customers.CustomerID

WHERE
    Orders.CustomerID IN (90, 81)
Задача. Вывести названия и ID товаров, которые не были заказаны ни разу

SELECT
        Products.ProductID,
    Products.ProductName
FROM Products

LEFT JOIN OrderDetails USING(ProductID)

WHERE
    OrderDetails.ProductID IS NULL
Задача. Вывести ТОП-3 самых дорогих товаров с ценой до 200 EUR

SELECT *
FROM Products

WHERE
    Price <= 200
    
ORDER BY Price DESC
LIMIT 3
Задача. Вывести ко-во товаров и их среднюю стоимость от поставщика 1

SELECT
        COUNT(*) AS total_products,
    AVG(Price) AS avg_price
FROM Products

WHERE
    SupplierID = 1;
Задача. Вывести, сколько раз был заказан товар 72

SELECT
    COUNT(*) AS sold_count
    -- SUM(Quantity)
FROM OrderDetails

WHERE
    ProductID = 72
Пример. Вывести статистику по каждому поставщику

SELECT
        SupplierID,
        COUNT(*) AS total_products,
    AVG(Price) AS avg_price
FROM Products

GROUP BY SupplierID
-- HAVING total_products >= 5
Задача. Вывести страны, где ко-во клиентов 10 и более

(проекция: название_страны, ко-во_клиентов)

SELECT
        Country,
    COUNT(*) AS total_customers
FROM Customers

GROUP BY Country

HAVING
    total_customers >= 10
Задача. Вывести менеджеров, у которых ко-во заказов 10 и более

(проекция: фамилия_менеджера, ко-во_заказов)

SELECT
        Employees.LastName,
    COUNT(*) AS total_orders
FROM Employees

JOIN Orders USING(EmployeeID)

GROUP BY Employees.EmployeeID

HAVING
    total_orders >= 10
Схема БД видео-хостинг
Основные сущности

users
videos
reactions (реакции на видео)
donations (пожертвования)
Screenshot from 2023-10-27 22-20-50.png

Screenshot from 2023-10-27 22-23-12.png

Структура SQL
**DQL (Data Query Language)**
SELECT
SELECT DISTINCT
**DDL (Data Definition Language)**
CREATE - создать объект (напр., БД, таблица и т.д.)
DROP - удалить
ALTER - изменить
RENAME - переименовать
**DML (Data Manipulation Language)**
INSERT INTO - добавить записи
UPDATE - изменить записи
DELETE - удалить записи
DCL (Data Control Language)
TCL (Transaction Control Language)
Основные типы данных в MySQL
каждый столбец (поле) таблицы должен иметь указание на тип данных
SQL: DDL
Создание БД
CREATE DATABASE db_name;
CREATE DATABASE IF NOT EXISTS db_name; -- с проверкой, что указанная БД не существует
Создание таблиц
CREATE TABLE <название_таблицы> (<структура>);
CREATE TABLE IF NOT EXISTS <название_таблицы> (<структура>);

CREATE TABLE users (
    -- название_поля тип_данных доп_хар-ки
    user_id int
);
Удалить таблицу
DROP TABLE <название_таблицы>;
Создание таблиц. БД видео-хостинг
CREATE TABLE IF NOT EXISTS users (
    user_id int,
    created_at timestamp,
    username varchar(64),
    country varchar(64),
    is_blocked bool
);
Задача. Создать таблицу videos

CREATE TABLE IF NOT EXISTS videos (
  video_id int,
  created_at timestamp,
  title varchar(128),
  author_id int,
  duration_secs int
);
Валидация данных в SQL / SQL Constraints
Основные ограничения:

primary key (unique + not null)
unique уникальное
not null не пустое
foreign key внешний ключ
check проверка условий
default установка значения по умолчанию
Пример. Создать таблицу products

CREATE TABLE IF NOT EXISTS products (
    product_id int primary key auto_increment,
    title varchar(128) not null,
    price float check (price > 0),
    created_at timestamp default current_timestamp,
    supplier_id int,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) -- добавить привязку (проверку) к suppliers
);
Задача. Создать таблицу users с использованием механизма валидации данных

CREATE TABLE users (
    user_id int primary key auto_increment,
    created_at timestamp default current_timestamp,
    username varchar(64) not null,
    country varchar(64) not null,
    is_blocked bool default false
);
Пример. Добавить двух юзеров

INSERT INTO users (username, country)
VALUES
        ('hacker', 'USA'),
    ('Ivan000', 'Germany')