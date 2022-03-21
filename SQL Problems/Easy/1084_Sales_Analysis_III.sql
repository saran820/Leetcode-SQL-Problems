/*
Reports the products that were only sold in spring 2019. That is, between 2019-01-01 and 2019-03-31 inclusive. Select the product that were only sold in spring 2019.

Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+

Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+

Result table:
+-------------+--------------+
| product_id  | product_name |
+-------------+--------------+
| 1           | S8           |
+-------------+--------------+
The product with id 1 was only sold in spring 2019 while the other two were sold after.

*/

--Table Creation Code:
CREATE TABLE Product (
  `product_id` INTEGER,
  `product_name` VARCHAR(6),
  `unit_price` INTEGER
);

INSERT INTO Product
  (`product_id`, `product_name`, `unit_price`)
VALUES
  ('1', 'S8', '1000'),
  ('2', 'G4', '800'),
  ('3', 'iPhone', '1400');

CREATE TABLE Sales (
  `seller_id` INTEGER,
  `product_id` INTEGER,
  `buyer_id` INTEGER,
  `sale_date` DATETIME,
  `quantity` INTEGER,
  `price` INTEGER
);

INSERT INTO Sales
  (`seller_id`, `product_id`, `buyer_id`, `sale_date`, `quantity`, `price`)
VALUES
  ('1', '1', '1', '2019-01-21', '2', '2000'),
  ('1', '2', '2', '2019-02-17', '1', '800'),
  ('2', '2', '3', '2019-06-02', '1', '800'),
  ('3', '3', '4', '2019-05-13', '2', '2800');


-- Solution:
Select p.product_name
From Product p
Left Join Sales s On (p.product_id = s.product_id)
Where s.sale_date between '2019-01-01' and '2019-03-31'
and p.product_name not in (Select p1.product_name
				   From Product p1
				   Left Join Sales s1 On (p1.product_id = s1.product_id)
				   Where s1.sale_date < '2019-01-01' or s1.sale_date > '2019-03-31')
