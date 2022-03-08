/*
Table: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key of this table.
Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest courseid. The output must be sorted by increasing studentid.

The query result format is in the following example:

Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+
Result table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+
*/

-- Table Creation Code:
CREATE TABLE Enrollments (
  `student_id` INTEGER,
  `course_id` INTEGER,
  `grade` INTEGER
);

INSERT INTO Enrollments
  (`student_id`, `course_id`, `grade`)
VALUES
  ('2', '2', '95'),
  ('2', '3', '95'),
  ('1', '1', '90'),
  ('1', '2', '99'),
  ('3', '1', '80'),
  ('3', '2', '75'),
  ('3', '3', '82');
  
-- Solution:
with cte as (Select student_id, course_id, grade, ROW_NUMBER() over (Partition by student_id ORDER BY grade DESC, course_id ASC) as rank_number
From Enrollments)

Select student_id, course_id, grade
From cte 
Where rank_number = 1