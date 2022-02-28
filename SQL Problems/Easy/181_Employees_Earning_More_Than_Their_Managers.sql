/*
SQL Schema
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 

Write an SQL query to find the employees who earn more than their managers.

Return the result table in any order.

The query result format is in the following example.

Example 1:

Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.

*/

-- Table Creation Code
Table Creation Code:
CREATE TABLE Employee (
  `Id` INTEGER,
  `Name` VARCHAR(10),
  `Salary` INTEGER,
  `ManagerId` VARCHAR(4)
);

INSERT INTO Employee
  (`Id`, `Name`, `Salary`, `ManagerId`)
VALUES
  ('1', 'Joe', '70000', '3'),
  ('2', 'Henry', '80000', '4'),
  ('3', 'Sam', '60000', 'NULL'),
  ('4', 'Max', '90000', 'NULL'),
  ('5', 'Ricardo', '100000', '7'),
  ('6', 'Pablo', '50000', '7'),
  ('7', 'Noelle', '80000', 'NULL'),
  ('8', 'Anna', '90000', '1');

-- Solution
Select e.Name as employee
From Employee e
Where e.ManagerId in (Select e1.id
                	From Employee e1
                   	Where e.salary > e1.salary);