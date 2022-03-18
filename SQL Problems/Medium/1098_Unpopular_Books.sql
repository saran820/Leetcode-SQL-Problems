/*
Table: Books

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| book_id        | int     |
| name           | varchar |
| available_from | date    |
+----------------+---------+
book_id is the primary key of this table.
Table: Orders

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| order_id       | int     |
| book_id        | int     |
| quantity       | int     |
| dispatch_date  | date    |
+----------------+---------+
order_id is the primary key of this table.
book_id is a foreign key to the Books table.
Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23.

The query result format is in the following example:

Books table:
+---------+--------------------+----------------+
| book_id | name               | available_from |
+---------+--------------------+----------------+
| 1       | "Kalila And Demna" | 2010-01-01     |
| 2       | "28 Letters"       | 2012-05-12     |
| 3       | "The Hobbit"       | 2019-06-10     |
| 4       | "13 Reasons Why"   | 2019-06-01     |
| 5       | "The Hunger Games" | 2008-09-21     |
+---------+--------------------+----------------+

Orders table:
+----------+---------+----------+---------------+
| order_id | book_id | quantity | dispatch_date |
+----------+---------+----------+---------------+
| 1        | 1       | 2        | 2018-07-26    |
| 2        | 1       | 1        | 2018-11-05    |
| 3        | 3       | 8        | 2019-06-11    |
| 4        | 4       | 6        | 2019-06-05    |
| 5        | 4       | 5        | 2019-06-20    |
| 6        | 5       | 9        | 2009-02-02    |
| 7        | 5       | 8        | 2010-04-13    |
+----------+---------+----------+---------------+

Result table:
+-----------+--------------------+
| book_id   | name               |
+-----------+--------------------+
| 1         | "Kalila And Demna" |
| 2         | "28 Letters"       |
| 5         | "The Hunger Games" |
+-----------+--------------------+

*/

--Table Creation Code:
CREATE TABLE Books (
  `book_id` INTEGER,
  `name` VARCHAR(18),
  `available_from` DATETIME
);

INSERT INTO Books
  (`book_id`, `name`, `available_from`)
VALUES
  ('1', 'Kalila And Demna', '2010-01-01'),
  ('2', '28 Letters', '2012-05-12'),
  ('3', 'The Hobbit', '2019-06-10'),
  ('4', '13 Reasons Why', '2019-06-01'),
  ('5', 'The Hunger Games', '2008-09-21');

CREATE TABLE Orders (
  `order_id` INTEGER,
  `book_id` INTEGER,
  `quantity` INTEGER,
  `dispatch_date` DATETIME
);

INSERT INTO Orders
  (`order_id`, `book_id`, `quantity`, `dispatch_date`)
VALUES
  ('1', '1', '2', '2018-07-26'),
  ('2', '1', '1', '2018-11-05'),
  ('3', '3', '8', '2019-06-11'),
  ('4', '4', '6', '2019-06-05'),
  ('5', '4', '5', '2019-06-20'),
  ('6', '5', '9', '2009-02-02'),
  ('7', '5', '8', '2010-04-13');

-- Solution:
-- filter by yearly sales
with cte as (Select *
             From Orders o
			 Where o.dispatch_date between "2018-06-23" and "2019-06-23")
             
-- Check for < 10 book sales       
Select b.book_id, b.name
From Books b
Left Join cte on (b.book_id = cte.book_id)
Where timestampdiff(Day, b.available_from, "2019-06-23") > 30
Group By b.book_id, b.name
Having sum(quantity) < 10 or sum(quantity) is null
