/*
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

The query result format is in the following example:

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

-- Table Creation Code:
CREATE TABLE Products (
  `product_id` INTEGER,
  `new_price` INTEGER,
  `change_date` DATETIME
);

INSERT INTO Products
  (`product_id`, `new_price`, `change_date`)
VALUES
  ('1', '20', '2019-08-14'),
  ('2', '50', '2019-08-14'),
  ('1', '30', '2019-08-15'),
  ('1', '35', '2019-08-16'),
  ('2', '65', '2019-08-17'),
  ('3', '20', '2019-08-18');

--Solution:
with cte as (Select p3.product_id, p3.new_price as price
  			 From Products p3
  			 Where (p3.product_id, p3.change_date) in (Select p1.product_id, Max(p1.change_date) as recent_date
			 From Products p1
			 Where p1.change_date <= '2019-08-16'
			 Group By p1.product_id)),
             
cte1 as (Select distinct p2.product_id
From Products p2)

Select cte1.product_id, coalesce(cte.price, 10) as price
From cte1
Left Join cte On (cte1.product_id = cte.product_id)
