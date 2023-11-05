## `URI` для подключения

```jsx
mongodb+srv://ab:Os9yUOqHKfxhKO0M@cluster0.u54vil2.mongodb.net/admin?retryWrites=true&replicaSet=atlas-qut493-shard-0&readPreference=primary&srvServiceName=mongodb&connectTimeoutMS=10000&authSource=admin&authMechanism=SCRAM-SHA-1&3t.uriVersion=3&3t.connection.name=atlas-qut493-shard-0&3t.databases=admin&3t.alwaysShowAuthDB=true&3t.alwaysShowDBFromUserRole=true&3t.sslTlsVersion=TLS
```

## Принципиальные отличия MongoDB от RDBMS

1. Другой язык для выполнения запросов (`NoSQL - QUERY API`)
2. Модель данных - **ДОКУМЕНТНАЯ** (документ - ассоц/массив, карта)
3. Использует `JSON` и Binary `JSON` (`BSON`)
4. Динамическая схема данных (без схемы, `schemaless`) - каждый документ может иметь свой набор полей
5. Позволяет хранить вложенные структуры данных

## Базовые структуры данных

1. Скаляр (скалярное значение)
2. Массив (список значений)
3. Ассоц/массив (карта, документ, объект - пары ключ/значения)
4. Множество (список **уникальных** элементов)

```jsx
// пример
users = [
	{username: 'hacker', email: '123@example.org', is_blocked: true},
	{username: 'user1', email: 'hello@example.org', phone: '+0000000000'}
]
```

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/95d3eea4-bdd9-4866-805a-55b03d066b78/fb5bc416-d4b3-42a8-93b5-10b85bbccb23/Untitled.png)

## Категории запросов

1. `CRUD` - более простые запросы
2. Aggregation - получение вычисленных данных

## MongoDB: CRUD

**Create**

- `insertOne()` добавить один документ
    - один аргумент
        - ассоц/массив (объект)
- `insertMany()` добавить несколько документов
    - один аргумент
        - массив ассоц/массивов

**Read**

- `findOne()`  найти (выбрать) один документ
- `find()` найти (выбрать) несколько документов
    - аргументы
        - `filter`
        - `projection`
- `countDocuments()` ко-во совпадений
    - аргументы
        - `filter`

**Update**

- `updateOne()` изменить один документ
- `updateMany()` изменить несколько документов
    - аргументы
        - `filter`
        - `action`

**Delete**

- `deleteOne()` удалить один документ
- `deleteMany()` удалить несколько документов
    - аргументы
        - `filter`

![Screenshot from 2023-10-18 20-08-25.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/95d3eea4-bdd9-4866-805a-55b03d066b78/259cf63a-abaf-48aa-987c-cecc74209b7a/Screenshot_from_2023-10-18_20-08-25.png)

## БД `music` - сервис онлайн-музыки

**Основные сущности**

- `users`
- `tracks`
- `reactions` (реакции на треки, шкала от `1` до `5`)
- реализовать плейлисты (список воспроизведения)

**Пример. Добавление юзеров**

```jsx
db.users.insertMany([
    { _id: 1, fullname: 'Ivan Ivanov', country: 'Germany' },
    { _id: 2, fullname: 'Petr Ivanov', country: 'USA' },
    { _id: 3, fullname: 'Sidr Ivanov', country: 'Germany' },
    { _id: 4, fullname: 'hacker', country: 'USA' },
    { _id: 5, fullname: 'noname', country: 'France' }
])
```

**Пример. Вывести всех юзеров**

```jsx
db.users.find()
```

**Пример. Вывести юзеров из `Germany`**

```jsx
db.users.find(
    { country: 'Germany' } // filter
)

// с проекцией
// вывести имена юзеров из Germany
db.users.find(
    { country: 'Germany' }, // filter
    { fullname: 1, _id: 0 } // projection
)
```

**Пример. Вывести страны юзеров**

```jsx
db.users.find(
    {}, // filter
    { country: 1, _id: 0 } // projection
)
```

**Задача. Вывести страну юзера `1`**

```jsx
db.users.findOne(
    { _id: 1 }, // filter
    { country: 1, _id: 0 } // projection
)
```

**Задача. Вывести всех юзеров (без поля `_id`)**

```jsx
db.users.find(
    {},
    { _id: 0 }
)
```

**Задача. Добавить пять треков (`tracks`)**

```jsx
db.tracks.insertMany([
    { _id: 1, title: 'Track 1', duration_secs: 5 * 60, author_id: 1 },
    { _id: 2, title: 'Track 2', duration_secs: 4 * 60, author_id: 2 },
    { _id: 3, title: 'Track 3', duration_secs: 6 * 60, author_id: 3 },
    { _id: 4, title: 'Track 4', duration_secs: 7 * 60, author_id: 4 },
    { _id: 5, title: 'Track 5', duration_secs: 9 * 60, author_id: 5 }
])
```

**Задача. Вывести название и продолжительность трека `4`**

```jsx
db.tracks.findOne(
    { _id: 4 },
    { title: 1, duration_secs: 1, _id: 0 }
)
```

**Задача. Вывести все треки юзера `2` (кроме поля `author_id`)**

```jsx
db.tracks.find(
    { author_id: 2 },
    { author_id: 0, _id: 0 }
)
```

## Операторы сравнения

`$eq` равно (equal)

`$ne` не равно (not equal)

`$gt` больше (greater than)

`$gte` больше или равно (greater than or equal)

`$lt` меньше (less than)

`$lte` меньше или равно (less than or equal)

`$in` проверка принадлежности к списку значений

`$nin` (not in) не принадлежит списку значений

**Пример. Вывести треки с продолжительностью от `5` мин**

```jsx
db.tracks.find(
    { duration_secs: { $gte: 5 * 60 } }
)
```

**Задача. Вывести треки продолжительностью до одного часа (включительно)**

(проекция: `название`, `продолжительность`)

```jsx
db.tracks.find(
    { duration_secs: { $lte: 60 * 60 } },
    { title: 1, duration_secs: 1, _id: 0 }
)
```

**Задача. Вывести названия треков продолжительностью от `2` до `10` мин**

```jsx
db.tracks.find(
    { duration_secs: { $gte: 2 * 60, $lte: 10 * 60 } },
    { title: 1, _id: 0 }
)
```

## Метаданные любой сущности (технические характеристики)

- первичный ключ (`id`, `user_id`, `userID`)
- дата/время добавления записи (`datetime`, `timestamp`, `created`, `created_at`)

## Базовые операторы модификации (`updateOne` / `updateMany()`)

`$set` установить поля

`$unset` удалить (снять) поля

`$inc` инкремент полей (увеличить/уменьшить)

`$mul` умножение

**Пример. Заблокировать юзеров из `France`**

```jsx
db.users.updateMany(
    { country: 'France' }, // filter
    {
        $set: {
            is_blocked: true
        }
    } // action
)
```

**Задача. Вывести имена всех заблокированных юзеров**

```jsx
db.users.find(
    { is_blocked: true },
    { fullname: 1, _id: 0 }
)
```

**Пример. Удалить всех юзеров**

```jsx
db.users.deleteMany({})
```

**Пример. Вывести незаблокированных юзеров**

```jsx
db.users.find(
    { is_blocked: { $ne: true } }
)
```

**Задача. Вывести всех незаблокированных юзеров не из `Germany`**

```jsx
db.users.find(
    {
        is_blocked: { $ne: true },
        country: { $ne: 'Germany' }
    }
)
```

**Пример. Разблокировать всех юзеров**

```jsx
db.users.updateMany(
    {},
    {
        $unset: {
            is_blocked: null
        }
    }
)
```

**Задача. Заблокировать юзера `2`**

```jsx
db.users.updateOne(
    { _id: 2 },
    {
        $set: {
            is_blocked: true
        }
    }
)
```

**Задача. Разблокировать юзера `2` и установить ему произвольный `email-адрес`**

# DB #6 / Oct 20, 2023

## Ссылки

- [пример БД “онлайн-музыка”](https://dbdiagram.io/d/online_music-6532a9e2ffbf5169f01f9f38)

![Screenshot from 2023-10-20 19-55-14.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/95d3eea4-bdd9-4866-805a-55b03d066b78/8f5f14d7-3168-4b76-846b-5cf0428989e5/Screenshot_from_2023-10-20_19-55-14.png)

**Примеры запросов**

```jsx
// Вывести треки с продолжительностью от 5 мин
db.tracks.find(
    { duration_secs: { $gte: 5 * 60 } }
)

// Вывести юзеров из USA
db.users.find(
    { country: 'USA' } // filter
)

// Вывести страну юзера 1
db.users.findOne(
    { _id: 1 },
    { country: 1, _id: 0 }
)

// вывести имена юзеров из Germany
db.users.find(
    { country: 'Germany' }, // filter
    { fullname: 1, _id: 0 } // projection
)

// Заблокировать юзеров из France
db.users.updateMany(
    { country: 'France' }, // filter
    {
        $set: {
            is_blocked: true
        }
    } // action
)

// Вывести незаблокированных юзеров
db.users.find(
    { is_blocked: { $ne: true } } // filter
)

// Разблокировать всех юзеров
db.users.updateMany(
    {}, // filter
    { // action
        $unset: {
            is_blocked: null
        }
    }
)

// Разблокировать юзера 2 и установить ему произвольный email-адрес
db.users.updateOne(
    { _id: 2 },
    {
        $unset: { is_blocked: null },
        $set: { email: 'user@example.org' }
    }
)
```

## Подсчет ко-ва документов / метод `countDocuments()`

- один аргумент
    - `фильтр`
- возвращает `целое число` - ко-во совпадений

**Пример**

```jsx
db.users.countDocuments(
    { country: 'Germany' }
)
```

**Пример. Запрос на авторизацию (аутентификацию) юзера**

```jsx
db.users.countDocuments(
    {
        email: email,
        password: password,
        is_blocked: { $ne: true }
    }
)
```

**Задача. Вывести ко-во заблокированных юзеров не из `China`**

```jsx
db.users.countDocuments(
    {
        country: { $ne: 'China' },
        is_blocked: true
    }
)
```

**Задача. Вывести ко-во треков с продолжительностью до `30` мин (вкл.)**

```jsx
db.tracks.countDocuments(
    { duration_secs: { $lte: 30 * 60 } }
)
```

**Пример. Использование `$in`**

```jsx
// Вывести юзеров из `Germany` и `France`
db.users.find(
    {
        country: { $in: ['Germany', 'France'] }
    }
)
```

**Пример. Использование `$nin` (not in)**

```jsx
db.users.find(
    {
        country: { $nin: ['USA', 'China'] }
    }
)
```

**Задача. Вывести названия треков `1` и `3`**

```jsx
db.tracks.find(
    { _id: { $in: [1, 3] } },
    { title: 1, _id: 0 }
)
```

**Пример. Увеличить баланс всех юзеров на `20` EUR**

```jsx
db.users.updateMany(
    {},
    {
        $inc: { balance: 20 }
    }
)
```

**Задача. Уменьшить баланс юзеров из `France` на `5` EUR**

```jsx
db.users.updateMany(
    { country: 'France' }, // filter
    { $inc: { balance: -5 } } action
)
```

**Задача. Вывести ко-во незаблокированных юзеров с положительным балансом**

```jsx
db.users.countDocuments(
    {
        is_blocked: { $ne: true },
        balance: { $gt: 0 }
    }
)
```

**Задача. Заблокировать юзеров из `USA` с бансом от `5` EUR**

```jsx
db.users.updateMany(
    {
        country: 'USA',
        balance: { $gte: 5 }
    },
    {
        $set: { is_blocked: true }
    }
)
```

**Задача. Для всех заблокированных юзеров из `USA` с балансом до `1000` EUR необходимо:**

- их разблокировать
- увеличить баланс на `100` EUR

```jsx
db.users.updateMany(
    {
        country: 'USA',
        is_blocked: true,
        balance: { $lte: 1000 }
    },
    {
        $unset: { is_blocked: null },
        $inc: { balance: 100 }
    }
)
```

**Пример. Увеличить баланс всех юзеров на `15%`**

```jsx
db.users.updateMany(
    {},
    {
        $mul: { balance: 1.15 }
    }
)
```

**Задача. Уменьшить баланс всех незаблокированных юзеров с положительным балансом на `1%`**

```jsx
db.users.updateMany(
    {
        is_blocked: { $ne: true },
        balance: { $gt: 0 }
    },
    {
        $mul: { balance: .99 }
    }
)
```

**Задача. Разблокировать юзера `4` и уменьшить его баланс на `0.5%`**

```jsx
db.users.updateOne(
    {
        _id: 4
    },
    {
        $unset: { is_blocked: null },
        $mul: { balance: .995 }
    }
)
```

## Работа с массивами в MongoDB

**Базовые операторы работы с массивами**

- `$push` добавить значение в **массив**
- `$pull` удалить значение из массива
- `$pullAll` удалить несколько значений из массива
- `$addToSet` добавить значение в **множество**
- `$each` добавить список значений в массив или множество

**Пример. Добавить тег всем трекам**

```jsx
db.tracks.updateMany(
    {},
    {
        $push: {
            tags: 'super'
        }
    }
)
```

**Пример. Удалить тег из треков**

```jsx
db.tracks.updateMany(
    {},
    {
        $pull: {
            tags: 'super'
        }
    }
)
```

**Пример. Добавить элемент в множество**

```jsx
db.tracks.updateMany(
    {},
    {
        $addToSet: {
            tags: 'super'
        }
    }
)
```

**Пример. Добавить несколько элементов в множество**

```jsx
db.tracks.updateMany(
    {},
    {
        $addToSet: {
            tags: { $each: ['super', 'mega', 'new'] }
        }
    }
)
```

**Пример. Удалить несколько тегов (элементов массива)**

```jsx
db.tracks.updateMany(
    {},
    {
        $pullAll: {
            tags: ['super', 'mega']
        }
    }
)
```

**Задача. Добавить ко всем трекам, кроме треков `1` и `3`, тег `test`**

```jsx
db.tracks.updateMany(
    {
        _id: { $nin: [1, 3] }
    },
    {
        $addToSet: { tags: 'test' }
    }
)
```

**Пример. Поиск документов по тегу (тегам)**

```jsx
db.tracks.find(
    {
        tags: 'new'
    }
)

db.tracks.find(
    {
        tags: { $in: ['new', 'test'] }
    }
)

db.tracks.find(
    {
        tags: { $all: ['new', 'test'] }
    }
)
```

**Задача. Вывести все треки с тегом `test` и продолжительностью до одного часа**
Ссылки
пример схемы БД “чат поддержки”
Примеры запросов

// Авторизация (аутентификация) юзера
db.users.countDocuments(
    {
        email: email,
        password: password,
        is_blocked: { $ne: true }
    }
)

// Вывести ко-во заблокированных юзеров не из China
db.users.countDocuments(
    {
        country: { $ne: 'China' },
        is_blocked: true
    }
)

// Вывести юзеров из `Germany`, `France`
db.users.find(
    {
        country: { $in: ['Germany', 'France'] }
    }
)

// Заблокировать юзеров из France
db.users.updateMany(
    { country: 'France' }, // filter
    { // action
        $set: {
            is_blocked: true
        }
    }
)

// Удалить тег из треков
db.tracks.updateMany(
    {}, // filter
    { // action
        $pull: { tags: 'super' }
    }
)

// Добавить несколько элементов в множество
db.tracks.updateMany(
    {},
    {
        $addToSet: {
            tags: { $each: ['mega', 'new'] }
        }
    }
)
Операторы модификации

$set
$pull
$addToSet
$each
$unset
$push
$pullAll
$mul
$inc
Удаление MongoDB / Методы deleteOne() / deleteMany()
аргументы
filter
Задача. Добавить три юзера из China

db.users.insertMany([
    { fullname: 'China User 1', country: 'China' },
    { fullname: 'China User 2', country: 'China' },
    { fullname: 'China User 3', country: 'China' },
])
Пример. Удалить всех юзеров из China

db.users.deleteMany(
    { country: 'China' }
)
MongoDB Aggregation Framework
позволяет получить вычисленные данные
инструмент для анализа, обработки данных
реализуется методом aggregate()
представляет конвеер (pipeline), который содержит определенные этапы обработки (stages)
!https://prod-files-secure.s3.us-west-2.amazonaws.com/95d3eea4-bdd9-4866-805a-55b03d066b78/6f9da238-35a6-485f-80b9-ddd25dab8622/Untitled.png

Метод aggregate()
аргументы
массив этапов обработки (pipeline, конвеер)
[
    {}, // этап 1
    {}, // этап 2
    {}, // этап 3
    {}, // этап 4
]
Пример. Вывести всех юзеров

db.users.aggregate()
Основные стадии (этапы, stages) обработки - операторы
$match фильтрация
$sort сортировка
-1 по убыванию
1 по возрастанию
$project проекция
$limit лимитирование
$skip пропустить (документы)
$group группировка
$lookup объединение коллекций
$addFields добавить поля
$sample получить произвольные документы
$count возвращает ко-во документов
$unwind развернуть массив
Пример. Работа с юзерами

// вывести всех юзеров
db.users.aggregate()

// вывести юзеров с балансом от 20 (EUR)
db.users.aggregate([
    { // фильтрация
        $match: {
            balance: { $gte: 20 }
        }
    }
])

// вывести незаблокир. юзеров
db.users.aggregate([
    { // фильтрация
        $match: {
            is_blocked: { $ne: true }
        }
    }
])

// вывести всех юзеров по убыванию баланса
db.users.aggregate([
    { // сортировка
        $sort: { balance: -1 }
    }
])

// вывести ТОП-3 юзеров по макс. балансу
db.users.aggregate([
    {
        $sort: { balance: -1 }
    },
    { $limit: 3 }
])
Задача. Вывести одного незаблокированного юзера с минимальным балансом

db.users.aggregate([
    { $match: { is_blocked: { $ne: true } } }, // фильтрация
    { $sort: { balance: 1 } }, // сортировка (по возраст.)
    { $limit: 1 } // лимитирование
])
Пример. Вывести ко-во незаблокированных юзеров

// вар. 1
db.users.countDocuments(
    { is_blocked: { $ne: true } }
)

// вар. 2
db.users.aggregate([
    { $match: { is_blocked: { $ne: true } } },
    { $count: 'unblocked_users' }
])
Пример. Вывести имена юзеров

db.users.aggregate([
    {
        $project: {
            fullname: 1,
            _id: 0
        }
    }
])
Задача. Вывести баланс и имя юзера 1

db.users.aggregate([
    { $match: { _id: 1 } },
    { $project: { fullname: 1, balance: 1, _id: 0 } }
])
Задача. Вывести названия треков 1, 3, 5

db.tracks.aggregate([
    { $match: { _id: { $in: [1, 3, 5] } } },
    { $project: { title: 1, _id: 0 } }
])
Задача. Вывести имена юзеров с балансом от 10 до 1000 EUR

db.users.aggregate([
    { $match: { balance: { $gte: 10, $lte: 1000 } } },
    { $project: { fullname: 1, _id: 0 } }
])
Пример. Вывести юзера, который находится на втором месте по балансу

db.users.aggregate([
    { $sort: { balance: -1 } },
    { $skip: 1 },
    { $limit: 1 }
])
Задача. Вывести название и продолжительность трека, который находится на третьем месте по продолжительности

db.tracks.aggregate([
    { $sort: { duration_secs: -1 } },
    { $skip: 2 },
    { $limit: 1 },
    { $project: { title: 1, duration_secs: 1, _id: 0 } }
])
Пример. Вывести один произвольный трек

db.tracks.aggregate([
    {
        $sample: { size: 1 }
    }
])
Задача. Вывести имя одного произвольного незаблокированного юзера

db.users.aggregate([
    { $match: { is_blocked: { $ne: true } } },
    { $sample: { size: 1 } },
    { $project: { fullname: 1, _id: 0 } }
])
Пример. Вывести треки, включая данные об авторах

db.tracks.aggregate([
    {
        $lookup: {
            from: 'users', // название колл., откуда взять данные
            localField: 'author_id', // локальное поле
            foreignField: '_id', // внешнее поле
            as: 'author' // куда поместить результат
        }
    }
])
Задача. Вывести юзеров, у которых отсутствуют треки

db.users.aggregate([
    {
        $lookup: {
            from: 'tracks', // название колл., откуда взять данные
            localField: '_id', // локальное поле
            foreignField: 'author_id', // внешнее поле
            as: 'tracks' // куда поместить результат
        }
    },
    {
        $match: { tracks: [] }
    }
])
Оператор агрегации $unwind
позволяет “развернуть” массив (отказаться от массива)
{ $unwind: '$author' }
Пример

db.tracks.aggregate([
    {
        $lookup: {
            from: 'users', // название колл., откуда взять данные
            localField: 'author_id', // локальное поле
            foreignField: '_id', // внешнее поле
            as: 'author' // куда поместить результат
        }
    },
    { $unwind: '$author' }
])
Пример. Вывести названия треков и имена их авторов

db.tracks.aggregate([
    {
        $lookup: {
            from: 'users', // название колл., откуда взять данные
            localField: 'author_id', // локальное поле
            foreignField: '_id', // внешнее поле
            as: 'author' // куда поместить результат
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            title: 1,
            author_fullname: '$author.fullname'
        }
    }
])
Задача. Вывести данные о самом продолжительном треке

(проекция: название_трека, имя_автора)

db.tracks.aggregate([
    { $sort: { duration_secs: -1 } },
    { $limit: 1 },
    {
        $lookup: {
            from: 'users', // название колл., откуда взять данные
            localField: 'author_id', // локальное поле
            foreignField: '_id', // внешнее поле
            as: 'author' // куда поместить результат
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            title: 1,
            author_fullname: '$author.fullname'
        }
    }
])
Пример фильтрации
$match: { tracks: { $ne: [] } }
Пример. Добавить несколько реакций (на треки)

db.reactions.insertMany([
    { track_id: 1, author_id: 1, value: 5 },
    { track_id: 2, author_id: 2, value: 2 },
    { track_id: 3, author_id: 3, value: 1 },
    { track_id: 4, author_id: 4, value: 5 },
    { track_id: 5, author_id: 5, value: 3 },
    { track_id: 2, author_id: 1, value: 5 },
    { track_id: 2, author_id: 1, value: 4 },
    { track_id: 4, author_id: 2, value: 4 },
    { track_id: 4, author_id: 4, value: 2 },
    { track_id: 1, author_id: 4, value: 3 },
    { track_id: 1, author_id: 3, value: 3 }
])
Задача. Вывести ко-во реакций у юзеров 1 и 4, используя aggregate()

db.reactions.aggregate([
    { $match: { author_id: { $in: [1, 4] } } },
    { $count: 'reactions' }
])
Задача. Вывести данные о реакциях

(проекция: имя_юзера, оценка)

db.reactions.aggregate([
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            value: 1,
            author_fullname: '$author.fullname'
        }
    }
])
Задача. Вывести данные о реакциях юзера 1

(проекция: имя_юзера, оценка)

db.reactions.aggregate([
    {
        $match: { author_id: 1 }
    },
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            value: 1,
            author_fullname: '$author.fullname'
        }
    }
])
Задача. Вывести данные о реакциях юзеров 1 и 5

(проекция: имя_юзера, оценка, название_трека)

db.reactions.aggregate([
    { $match: { author_id: { $in: [1, 5] } } },
    {
        $lookup: {
            from: "users",
            localField: "author_id",
            foreignField: "_id",
            as: "author"
        }
    },
    { $unwind: "$author" },
    {
        $lookup: {
            from: "tracks",
            localField: "track_id",
            foreignField: "_id",
            as: "track"
        }
    },
    { $unwind: "$track" },
    {
        $project: {
            _id: 0,
            author_name: "$author.fullname",
            track_title: "$track.title",
            value: 1
        }
    }
])
Группировка / оператор $group
получает на входе документы
объединяет их в группы по заданному полю (или полям) группировки
на выходе - один документ равен одному уникальному значению поля группировки
Базовые операторы группировки (аккумуляторы)

$sum
$avg
$min
$max
$count
Пример. Вывести количественное распределение юзеров по странам

db.users.aggregate([
    {
        $group: {
            _id: '$country', // поле группировки
            total_users: { $count: {} }
        }
    }
])
Пример. Вывести статистику по всем юзерам

db.users.aggregate([
    {
        $group: {
            _id: null, // поле группировки
            total_users: { $count: {} },
            avg_balance: { $avg: '$balance' }
        }
    }
])
Задача. Вывести среднюю продолжительность треков по каждому автору

(без применения $lookup)

db.tracks.aggregate([
    {
        $group: {
            _id: '$author_id',
            avg_duration: { $avg: '$duration_secs' }
        }
    }
])
Задача. Вывести среднюю продолжительность всех треков

db.tracks.aggregate([
    {
        $group: {
            _id: null,
            avg_duration: { $avg: '$duration_secs' }
        }
    }
])
Задача. Вывести среднюю продолжительность треков по каждому автору

(проекция: имя_автора, сред_продолжительность)

db.tracks.aggregate([
    {
        $group: {
            _id: '$author_id',
            avg_duration: { $avg: '$duration_secs' }
        }
    },
    {
        $lookup: {
            from: 'users',
            localField: '_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            avg_duration: 1,
            author_fullname: '$author.fullname'
        }
    }
])
Задача. Вывести имя одного автора треков, у которого самая высокая средняя продолжительность

db.tracks.aggregate([
    {
        $group: {
            _id: '$author_id',
            avg_duration: { $avg: '$duration_secs' }
        }
    },
    { $sort: { avg_duration: -1 } },
    { $limit: 1 },
    {
        $lookup: {
            from: 'users',
            localField: '_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            _id: 0,
            author_fullname: '$author.fullname'
        }
    }
])
Задача. Вывести среднее значение по всем реакциям

db.reactions.aggregate([
    {
        $group: {
            _id: null,
            avg_reaction: { $avg: '$value' }
        }
    }
])
Задача. Вывести данные о треках

(проекция: название_трека, рейтинг_трека)

db.reactions.aggregate([
    {
        $group: {
            _id: '$track_id',
            rating: { $avg: '$value' }
        }
    },
    {
        $lookup: {
            from: 'tracks',
            localField: '_id',
            foreignField: '_id',
            as: 'track'
        }
    },
    { $unwind: '$track' },
    {
        $project: {
            _id: 0,
            rating: 1,
            track_title: '$track.title'
        }
    }
])
Задача. Вывести страну, в которой самый высокий рейтинг треков

(проекция: страна, ср_оценка)

db.reactions.aggregate([
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'user'
        }
    },
    {
        $unwind: '$user'
    },
    {
        $group: {
            _id: '$user.country',
            rating: { $avg: '$value' }
        }
    },
    {
        $sort: { rating: -1 }
    },
    {
        $limit: 1
    },
    {
        $project: {
            country: '$_id',
            rating: 1,
            _id: 0
        }
    }
])
Основные сущности БД “кинотеатр”
фильмы
сеансы
заказы
залы