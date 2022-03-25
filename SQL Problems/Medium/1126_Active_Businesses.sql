/*

Table: Events

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |
| event_type    | varchar |
| occurences    | int     |
+---------------+---------+
(business_id, event_type) is the primary key of this table.
Each row in the table logs the info that an event of some type occured at some business for a number of times.
Write an SQL query to find all active businesses.

An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

The query result format is in the following example:

Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+

Result table:
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+
Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively.
Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.

*/

-- Table Creation Code:
CREATE TABLE Events (
  `business_id` INTEGER,
  `event_type` VARCHAR(10),
  `occurences` INTEGER
);

INSERT INTO Events
  (`business_id`, `event_type`, `occurences`)
VALUES
  ('1', 'reviews', '7'),
  ('3', 'reviews', '3'),
  ('1', 'ads', '11'),
  ('2', 'ads', '7'),
  ('3', 'ads', '6'),
  ('1', 'page views', '3'),
  ('2', 'page views', '12');

--Solution:

-- Taking average of every event
with cte as (Select event_type, round(avg(occurences),1) as occur
From Events
Group By event_type),

-- Calculating sum of the same type of events for every business
cte1 as (Select business_id, event_type, sum(occurences) as numEvents
From Events e
Group By business_id, event_type
Having numEvents > (Select occur
                    From cte
                    Where e.event_type = cte.event_type))

--Selecting only those businesses which have atleast 2 such events > avg for that event
Select business_id
From cte1
Group By business_id
Having count(business_id)>1
