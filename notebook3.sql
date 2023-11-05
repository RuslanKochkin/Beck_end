# DB #3 / Oct 13, 2023

## Ссылки

- [инструмент онлайн-проектирования](https://dbdiagram.io/d/652921d3ffbf5169f0a0e4d9)
- [генератор UUID](https://www.uuidgenerator.net/version4)
- [генератор хешей](https://emn178.github.io/online-tools/sha1.html)
- [хеширование паролей](https://www.kaspersky.ru/blog/the-wonders-of-hashing/3633/)

**Задача. Вывести имена клиентов не из `Germany` и не из `France`**

```sql
SELECT 
	CustomerName
FROM Customers

WHERE
	NOT Country IN ('Germany','France')
```

**Задача. Вывести данные о трех последних заказах**

(проекция: `номер_заказа`, `фамилия_менеджера`)

```sql
SELECT 
	Orders.OrderID, 
	Employees.LastName

FROM Orders

JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID

ORDER BY Orders.OrderDate DESC
LIMIT 3
```

## Агрегация данных в SQL

**Базовые категории запросов**

1. **CRUD** - более простые запросы
2. **Aggregation** - получение вычисленных данных (итоги, статистика, аналитика)

**Базовые операторы (функции) агрегации**

- `COUNT()` расчет ко-ва строк
- `AVG()` расчет сред/ариф. знач.
- `MAX()` расчет макс. значения
- `MIN()` расчет мин. значения
- `SUM()` расчет суммы

**Пример. Работа с клиентами**

```sql
-- вывести общее ко-во клиентов
SELECT
	COUNT(*) AS total_customers
FROM Customers

-- вывести ко-во клиентов из Germany
SELECT
	COUNT(*) AS germany_customers
FROM Customers
WHERE
	Country = 'Germany'
```

**Пример. Работа с товарам**

```sql
-- вывести общее ко-во товаров
SELECT
	COUNT(*) AS total_products
FROM Products

-- вывести ко-во товаров с ценой от 20 EUR
SELECT
	COUNT(*) total_products
FROM Products
WHERE
	Price >= 20

-- сред/цена по всем товарами
SELECT
	AVG(Price) AS avg_price
FROM Products

-- сред/цена по товарам из категории 1
SELECT
	AVG(Price) AS avg_price
FROM Products
WHERE
	CategoryID = 1
```

**Пример. Вывести статистику по товарам**

```sql
SELECT
	AVG(Price) AS avg_price,
	MIN(Price) AS min_price,
	MAX(Price) AS max_price,
	COUNT(*) AS total_products,
	SUM(Price) as products_sum
FROM Products
```

**Задача. Вывести ко-во поставщиков из `USA`**

```sql
SELECT
	COUNT(*) AS usa_suppliers
FROM Suppliers

WHERE
	Country = 'USA'
```

**Задача. Вывести ко-во клиентов из `USA`, `UK`, `France`**

```sql
SELECT
	COUNT(*) AS total_customers
FROM Customers

WHERE
	Country IN ('USA', 'UK', 'France')
```

**Задача. Вывести среднюю стоимость товаров до `150` EUR (вкл.)**

```sql
SELECT
	AVG(Price) AS avg_price
FROM Products

WHERE
	Price <= 150
```

**Задача. Вывести ко-во заказов у менеджера `5`**

```sql
SELECT
    COUNT(*) AS orders_count
FROM Orders

WHERE
    EmployeeID = 5
```

**Задача. Вывести сред/стоимость товаров из категорий `1, 2, 5`, у которых название начинается с `t`**

```sql
SELECT
	AVG(Price) AS avg_price
FROM Products

WHERE
	CategoryID IN (1, 2, 5)
	AND
	ProductName LIKE 't%'
```

**Задача. Посчитать стоимость заказа `10248`**

```sql
SELECT
	SUM(Products.Price * OrderDetails.Quantity) AS order_cost
FROM OrderDetails

JOIN Products ON OrderDetails.ProductID = Products.ProductID

WHERE
	OrderDetails.OrderID = 10248
```

**Задача. Вывести `ко-во заказов`, которое оформил клиент `1`**

```sql
SELECT
	COUNT(*) AS total_orders
FROM Orders

WHERE
	CustomerID = 1
```

**Задача. Вывести, сколько раз был продан (заказан) товар `72`**

```sql
SELECT
	COUNT(*) AS sold_count
FROM OrderDetails

WHERE
	ProductID = 72
```

**Задача. Вывести `среднюю стоимость` напитка (`Beverages`) из `USA`**

```sql
SELECT 
	AVG(Products.Price) AS avg_price
-- ROUND(AVG(Products.Price), 4) AS avg_price

FROM Products

JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
JOIN Categories ON Products.CategoryID = Categories.CategoryID

WHERE
	Categories.CategoryName = 'Beverages'
	AND
	Suppliers.Country = 'USA'
```

**Задача. Вывести ко-во заказов, которое компания `Speedy Express` доставила в `Brazil`**

```sql
SELECT
	COUNT(*) AS total_shipped_to_brazil

FROM Orders

JOIN Shippers ON Orders.ShipperID=Shippers.ShipperID
JOIN Customers ON Orders.CustomerID=Customers.CustomerID

WHERE
		Shippers.ShipperName='Speedy Express'
    AND
    Customers.Country='Brazil'
```

## Проектирование БД

**Общие тезисы**

1. На одном сервере могут находиться **СУБД (DBMS)**
- **сетевой порт** - сетевой идентификатор процесса (программы)
1. В одной **СУБД** может находиться несколько **БД**
2. В одной **БД** может храниться несколько типов сущностей (объектов)
3. Стандартный подход: **ОДНА БД == ОДИН ПРОЕКТ**
4. Стандартный подход: **ОДНА СУЩНОСТЬ == ОДНА ЗАПИСЬ**

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/95d3eea4-bdd9-4866-805a-55b03d066b78/a968e9c3-178b-42ca-a514-44c1a7baa7a4/Untitled.png)

## Общие этапы проектирования БД

1. Анализ предметной обасти (бизнес-процессов)
2. Выделение сущностей и их свойств (характеристик)
3. Связывание сущностей между собой (установление связей)
    1. с помощью ключевых полей (`первичный` и `внешний` ключи)
4. Проверка решения (гипотезы)

## Первичный ключ (primary key)

- Является идентификатором каждой сущности

**Свойства**

- уникальный
- неизменяемый
- ненулевой

**Стандартные подходы к определению значения**

1. Авто-инкремент
2. Случайные значения (`UUID`, `GUID`, `ULID`)

## Базовые виды связей между сущностями

- `1:1` (один к одному)
- `1:M` (один ко многим)
- `M:M` (многие ко многим)

## Схема БД “онлайн-магазин (песочница)”

**Связи**