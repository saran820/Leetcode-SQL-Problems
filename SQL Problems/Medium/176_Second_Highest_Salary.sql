/*
Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.

+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+

*/

-- Table Creation Code:
CREATE TABLE Employee (
  `Id` INTEGER,
  `Salary` INTEGER
);

INSERT INTO Employee
  (`Id`, `Salary`)
VALUES
  ('1', '100');
  ('2', '200'),
  ('3', '300');

CREATE TABLE Result (
  `SecondHighestSalary` INTEGER,
  `ignore` VARCHAR(1)
);

-- Solution:
Select Max(Salary) as SecondHighestSalary
From Employee
Where Salary < (Select Max(Salary) From Employee);