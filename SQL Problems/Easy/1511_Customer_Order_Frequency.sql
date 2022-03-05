/*
Table: Customers

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| country       | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information of the customers in the company.
Table: Product

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| description   | varchar |
| price         | int     |
+---------------+---------+
product_id is the primary key for this table.
This table contains information of the products in the company.
price is the product cost.
Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_id    | int     |
| order_date    | date    |
| quantity      | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information on customer orders.
customer_id is the id of the customer who bought "quantity" products with id "product_id".
Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.
Write an SQL query to report the customerid and customername of customers who have spent at least $100 in each month of June and July 2020.

Return the result table in any order.

The query result format is in the following example.

Customers
+--------------+-----------+-------------+
| customer_id  | name      | country     |
+--------------+-----------+-------------+
| 1            | Winston   | USA         |
| 2            | Jonathan  | Peru        |
| 3            | Moustafa  | Egypt       |
+--------------+-----------+-------------+

Product
+--------------+-------------+-------------+
| product_id   | description | price       |
+--------------+-------------+-------------+
| 10           | LC Phone    | 300         |
| 20           | LC T-Shirt  | 10          |
| 30           | LC Book     | 45          |
| 40           | LC Keychain | 2           |
+--------------+-------------+-------------+

Orders
+--------------+-------------+-------------+-------------+-----------+
| order_id     | customer_id | product_id  | order_date  | quantity  |
+--------------+-------------+-------------+-------------+-----------+
| 1            | 1           | 10          | 2020-06-10  | 1         |
| 2            | 1           | 20          | 2020-07-01  | 1         |
| 3            | 1           | 30          | 2020-07-08  | 2         |
| 4            | 2           | 10          | 2020-06-15  | 2         |
| 5            | 2           | 40          | 2020-07-01  | 10        |
| 6            | 3           | 20          | 2020-06-24  | 2         |
| 7            | 3           | 30          | 2020-06-25  | 2         |
| 9            | 3           | 30          | 2020-05-08  | 3         |
+--------------+-------------+-------------+-------------+-----------+

Result table:
+--------------+------------+
| customer_id  | name       |
+--------------+------------+
| 1            | Winston    |
+--------------+------------+
Winston spent $300 (300 * 1) in June and $100 ( 10 * 1 + 45 * 2) in July 2020.
Jonathan spent $600 (300 * 2) in June and $20 ( 2 * 10) in July 2020.
Moustafa spent $110 (10 * 2 + 45 * 2) in June and $0 in July 2020.

*/

-- Table Creation Code:
CREATE TABLE Customers (
  `customer_id` INTEGER,
  `name` VARCHAR(8),
  `country` VARCHAR(5)
);

INSERT INTO Customers
  (`customer_id`, `name`, `country`)
VALUES
  ('1', 'Winston', 'USA'),
  ('2', 'Jonathan', 'Peru'),
  ('3', 'Moustafa', 'Egypt');

CREATE TABLE Product (
  `product_id` INTEGER,
  `description` VARCHAR(11),
  `price` INTEGER
);

INSERT INTO Product
  (`product_id`, `description`, `price`)
VALUES
  ('10', 'LC Phone', '300'),
  ('20', 'LC T-Shirt', '10'),
  ('30', 'LC Book', '45'),
  ('40', 'LC Keychain', '2');

CREATE TABLE Orders (
  `order_id` INTEGER,
  `customer_id` INTEGER,
  `product_id` INTEGER,
  `order_date` DATETIME,
  `quantity` INTEGER
);

INSERT INTO Orders
  (`order_id`, `customer_id`, `product_id`, `order_date`, `quantity`)
VALUES
  ('1', '1', '10', '2020-06-10', '1'),
  ('2', '1', '20', '2020-07-01', '1'),
  ('3', '1', '30', '2020-07-08', '2'),
  ('4', '2', '10', '2020-06-15', '2'),
  ('5', '2', '40', '2020-07-01', '10'),
  ('6', '3', '20', '2020-06-24', '2'),
  ('7', '3', '30', '2020-06-25', '2'),
  ('9', '3', '30', '2020-05-08', '3');

-- Solution:
with cte as (
Select o.customer_id, sum(case when o.order_date like '2020-06%' THEN p.price * o.quantity end) AS JuneSpend,
        		    sum(case when o.order_date like '2020-07%' THEN p.price * o.quantity end) AS JulySpend
From Orders o
Inner Join Product p on (o.product_id = p.product_id)
Group By customer_id)

Select c.customer_id, c.name
From Customers c
Where c.customer_id in (Select cte.customer_id
                        From cte
                        Where cte.JuneSpend >= 100 and cte.JulySpend >= 100)
