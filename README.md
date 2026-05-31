# Итоговое задание по базам данных

## Описание
Решение 13 задач по 4 базам данных:
- Транспортные средства (2 задачи)
- Автомобильные гонки (5 задач)
- Бронирование отелей (3 задачи)
- Структура организации (3 задачи)

## Описание баз данных

### 1. Транспортные средства (transport)
Таблицы: `Vehicle` (производитель, модель, тип), `Car`, `Motorcycle`, `Bicycle`.  
Связи: модель из `Vehicle` связана с конкретными ТС.

### 2. Автомобильные гонки (racing)
Таблицы: `Classes`, `Cars`, `Races`, `Results`.  
Связи: автомобили принадлежат классам, результаты гонок привязаны к автомобилям.

### 3. Бронирование отелей (hotel)
Таблицы: `Hotel`, `Room`, `Customer`, `Booking`.  
Связи: номера принадлежат отелям, бронирования связывают клиентов и номера.

### 4. Структура организации (organization)
Таблицы: `Departments`, `Roles`, `Employees`, `Projects`, `Tasks`.  
Связи: сотрудники подчиняются менеджерам, проекты привязаны к отделам, задачи — к сотрудникам.

## Используемые технологии
- MySQL (phpMyAdmin)
- SQL

## Структура репозитория
```
db-final-project/
│
├── README.md
│
├── transport/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── transport_task1.sql
│   └── transport_task2.sql
│
├── racing/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── racing_task1.sql
│   ├── racing_task2.sql
│   ├── racing_task3.sql
│   ├── racing_task4.sql
│   └── racing_task5.sql
│
├── hotel/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── hotel_task1.sql
│   ├── hotel_task2.sql
│   └── hotel_task3.sql
│
└── organization/
    ├── create_tables.sql
    ├── insert_data.sql
    ├── org_task1.sql
    ├── org_task2.sql
    └── org_task3.sql
```

## Как развернуть и запустить
1. Установить **MySQL** и **phpMyAdmin** (или **XAMPP**)
2. Создать 4 базы данных: `transport`, `racing`, `hotel`, `organization`
3. Для каждой базы:
   - Выполнить `create_tables.sql` для создания таблиц
   - Выполнить `insert_data.sql` для заполнения тестовыми данными
4. Выполнить соответствующий SQL-запрос из нужной папки (например, `transport_task1.sql`)

## Примечание

Все решения основаны на тестовых данных, предоставленных в задании.  
Результаты выполнения запросов соответствуют ожидаемым выводам из условия.
