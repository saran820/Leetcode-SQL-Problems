/*
SQL Schema
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
Write an SQL query that reports the first login date for each player.

The query result format is in the following example:

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/

-- Table Creation Code:

CREATE TABLE Activity (
  `player_id` INTEGER,
  `device_id` INTEGER,
  `event_date` DATETIME,
  `games_played` INTEGER
);

INSERT INTO Activity
  (`player_id`, `device_id`, `event_date`, `games_played`)
VALUES
  ('1', '2', '2016-03-01', '5'),
  ('1', '2', '2016-05-02', '6'),
  ('2', '3', '2017-06-25', '1'),
  ('3', '1', '2016-03-02', '0'),
  ('3', '4', '2018-07-03', '5');

-- Solution/s:
Select a1.player_id, a1.event_date as first_login
From Activity a1
Where a1.event_date = (Select min(event_date)
                       From Activity a2
                       Where a1.player_id = a2.player_id);
 
Select a1.player_id, min(a1.event_date)
From Activity a1
Group By a1.player_id;