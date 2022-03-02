/*
Query the customer_number from the orders table for the customer who has placed the largest number of orders.

It is guaranteed that exactly one customer will have placed more orders than any other customer.

The orders table is defined as follows:

| Column            | Type      |
|-------------------|-----------|
| order_number (PK) | int       |
| customer_number   | int       |
| order_date        | date      |
| required_date     | date      |
| shipped_date      | date      |
| status            | char(15)  |
| comment           | char(200) |
Sample Input

| order_number | customer_number | order_date | required_date | shipped_date | status | comment |
|--------------|-----------------|------------|---------------|--------------|--------|---------|
| 1            | 1               | 2017-04-09 | 2017-04-13    | 2017-04-12   | Closed |         |
| 2            | 2               | 2017-04-15 | 2017-04-20    | 2017-04-18   | Closed |         |
| 3            | 3               | 2017-04-16 | 2017-04-25    | 2017-04-20   | Closed |         |
| 4            | 3               | 2017-04-18 | 2017-04-28    | 2017-04-25   | Closed |         |
Sample Output

| customer_number |
|-----------------|
| 3               |

Explanation

The customer with number '3' has two orders, which is greater than either customer '1' or '2' because each of them  only has one order.
So the result is customer_number '3'.
*/

-- Table Creation Code:
CREATE TABLE orders (
  `order_number` INTEGER,
  `customer_number` INTEGER,
  `order_date` DATETIME,
  `required_date` DATETIME,
  `shipped_date` DATETIME,
  `status` VARCHAR(6),
  `comment` CHAR(1)
);

INSERT INTO orders
  (`order_number`, `customer_number`, `order_date`, `required_date`, `shipped_date`, `status`, `comment`)
VALUES
  ('1', '1', '2017-04-09', '2017-04-13', '2017-04-12', 'Closed', ''),
  ('2', '2', '2017-04-15', '2017-04-20', '2017-04-18', 'Closed', ''),
  ('3', '3', '2017-04-16', '2017-04-25', '2017-04-20', 'Closed', ''),
  ('4', '3', '2017-04-18', '2017-04-28', '2017-04-25', 'Closed', ''),
  ('5', '2', '2017-04-20', '2017-04-25', '2017-04-29', 'Closed', '');

-- Solution:
Select customer_number 
from (Select customer_number, rank() over(order by count(order_number) desc) as rn
From orders
Group By customer_number) a
Where a.rn<2


