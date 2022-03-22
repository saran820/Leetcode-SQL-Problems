/*
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

+------+----------+-----------+----------+
|Id    |Name 	    |Department |ManagerId |
+------+----------+-----------+----------+
|101   |John 	    |A 	        |null      |
|102   |Dan 	    |A 	        |101       |
|103   |James 	  |A 	        |101       |
|104   |Amy 	    |A 	        |101       |
|105   |Anne 	    |A 	        |101       |
|106   |Ron 	    |B 	        |101       |
+------+----------+-----------+----------+
Given the Employee table, write a SQL query that finds out managers with at least 5 direct report. For the above table, your SQL query should return:

+-------+
| Name  |
+-------+
| John  |
+-------+
Note: No one would report to himself.
*/

--Table Creation Code:
CREATE TABLE Employee (
  `Id` INTEGER,
  `Name` VARCHAR(5),
  `Department` VARCHAR(1),
  `ManagerId` VARCHAR(4)
);

INSERT INTO Employee
  (`Id`, `Name`, `Department`, `ManagerId`)
VALUES
  ('101', 'John', 'A', 'null'),
  ('102', 'Dan', 'A', '101'),
  ('103', 'James', 'A', '101'),
  ('104', 'Amy', 'A', '101'),
  ('105', 'Anne', 'A', '101'),
  ('106', 'Ron', 'B', '101');

-- Solution:
with cte as (Select ManagerId, Count(ManagerId) as cnt
From Employee
Where ManagerId is not null
Group By ManagerId
Having cnt >= 5 )

Select e.Name 
From Employee e
Inner Join cte (e.Id = cte.ManagerId)