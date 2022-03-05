/*
Description

Given three tables: salesperson, company, orders. Output all the names in the table salesperson, who didn’t have sales to company ‘RED’.

Example Input

Table: salesperson

+----------+------+--------+-----------------+-----------+
| sales_id | name | salary | commission_rate | hire_date |
+----------+------+--------+-----------------+-----------+
|   1      | John | 100000 |     6           | 4/1/2006  |
|   2      | Amy  | 120000 |     5           | 5/1/2010  |
|   3      | Mark | 65000  |     12          | 12/25/2008|
|   4      | Pam  | 25000  |     25          | 1/1/2005  |
|   5      | Alex | 50000  |     10          | 2/3/2007  |
+----------+------+--------+-----------------+-----------+
The table salesperson holds the salesperson information. Every salesperson has a sales_id and a name. Table: company

+---------+--------+------------+
| com_id  |  name  |    city    |
+---------+--------+------------+
|   1     |  RED   |   Boston   |
|   2     | ORANGE |   New York |
|   3     | YELLOW |   Boston   |
|   4     | GREEN  |   Austin   |
+---------+--------+------------+
The table company holds the company information. Every company has a com_id and a name. Table: orders

+----------+----------+---------+----------+--------+
| order_id |  date    | com_id  | sales_id | amount |
+----------+----------+---------+----------+--------+
| 1        | 1/1/2014 |    3    |    4     | 100000 |
| 2        | 2/1/2014 |    4    |    5     | 5000   |
| 3        | 3/1/2014 |    1    |    1     | 50000  |
| 4        | 4/1/2014 |    1    |    4     | 25000  |
+----------+----------+---------+----------+--------+
The table orders holds the sales record information, salesperson and customer company are represented by salesid and comid. output

+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
*/

-- Table Creation Code:
CREATE TABLE salesperson (
  `sales_id` INTEGER,
  `name` VARCHAR(4),
  `salary` INTEGER,
  `commission_rate` INTEGER,
  `hire_date` DATETIME
);

INSERT INTO salesperson
  (`sales_id`, `name`, `salary`, `commission_rate`, `hire_date`)
VALUES
  ('1', 'John', '100000', '6', '2006-4-1'),
  ('2', 'Amy', '120000', '5', '2010-5-1'),
  ('3', 'Mark', '65000', '12', '2008-12-25'),
  ('4', 'Pam', '25000', '25', '2005-1-1'),
  ('5', 'Alex', '50000', '10', '2007-2-3');

CREATE TABLE company (
  `com_id` INTEGER,
  `name` VARCHAR(6),
  `city` VARCHAR(8)
);

INSERT INTO company
  (`com_id`, `name`, `city`)
VALUES
  ('1', 'RED', 'Boston'),
  ('2', 'ORANGE', 'New York'),
  ('3', 'YELLOW', 'Boston'),
  ('4', 'GREEN', 'Austin');

CREATE TABLE orders (
  `order_id` INTEGER,
  `order_date` DATETIME,
  `com_id` INTEGER,
  `sales_id` INTEGER,
  `amount` INTEGER
);

INSERT INTO orders
  (`order_id`, `order_date`, `com_id`, `sales_id`, `amount`)
VALUES
  ('1', '2014-1-1', '3', '4', '100000'),
  ('2', '2014-2-1', '4', '5', '5000'),
  ('3', '2014-3-1', '1', '1', '50000'),
  ('4', '2014-4-1', '1', '4', '25000');

CREATE TABLE salesperson (
  `sales_id` INTEGER,
  `name` VARCHAR(4),
  `salary` INTEGER,
  `commission_rate` INTEGER,
  `hire_date` DATETIME
);

INSERT INTO salesperson
  (`sales_id`, `name`, `salary`, `commission_rate`, `hire_date`)
VALUES
  ('1', 'John', '100000', '6', '2006-4-1'),
  ('2', 'Amy', '120000', '5', '2010-5-1'),
  ('3', 'Mark', '65000', '12', '2008-12-25'),
  ('4', 'Pam', '25000', '25', '2005-1-1'),
  ('5', 'Alex', '50000', '10', '2007-2-3');

CREATE TABLE company (
  `com_id` INTEGER,
  `name` VARCHAR(6),
  `city` VARCHAR(8)
);

INSERT INTO company
  (`com_id`, `name`, `city`)
VALUES
  ('1', 'RED', 'Boston'),
  ('2', 'ORANGE', 'New York'),
  ('3', 'YELLOW', 'Boston'),
  ('4', 'GREEN', 'Austin');

CREATE TABLE orders (
  `order_id` INTEGER,
  `order_date` DATETIME,
  `com_id` INTEGER,
  `sales_id` INTEGER,
  `amount` INTEGER
);

INSERT INTO orders
  (`order_id`, `order_date`, `com_id`, `sales_id`, `amount`)
VALUES
  ('1', '2014-1-1', '3', '4', '100000'),
  ('2', '2014-2-1', '4', '5', '5000'),
  ('3', '2014-3-1', '1', '1', '50000'),
  ('4', '2014-4-1', '1', '4', '25000');

-- Solution:
with cte as (Select distinct s.name
From salesperson s
Inner Join orders o on (o.sales_id = s.sales_id)
Inner Join company c On (o.com_id = c.com_id)
Where c.name = 'RED')

Select s.name 
From salesperson s
Where s.name  not in (Select cte.name
                     From cte)

