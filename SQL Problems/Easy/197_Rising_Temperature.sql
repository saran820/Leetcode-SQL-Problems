/*
SQL Schema
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

--Table Creation Code:
CREATE TABLE Weather (
  `Id` INTEGER,
  `RecordDate` DATETIME,
  `Temperature` INTEGER
);

INSERT INTO Weather
  (`Id`, `RecordDate`, `Temperature`)
VALUES
  ('1', '2015-01-01', '10'),
  ('2', '2015-01-02', '25'),
  ('3', '2015-01-03', '20'),
  ('4', '2015-01-04', '30');

--Solution:
Select q.id
From(Select id, recordDate, lag(recordDate,1) OVER (Order by recordDate) as prev_date, temperature, lag(temperature, 1) over(Order by recordDate) as prev_temp
From Weather) q
Where q.temperature > q.prev_temp
And datediff(recordDate,prev_date) = 1

