-- https://leetcode.com/studyplan/top-sql-50/

-- 620. Not Boring Movies
-- https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50
SELECT *
FROM   cinema
WHERE  id % 2 = 1
       AND description != "boring"
ORDER  BY rating DESC; 

-- 1251. Average Selling Price
-- https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50
SELECT p.product_id,
       Ifnull(Round(Sum(units * price) / Sum(units), 2), 0) AS average_price
FROM   prices p
       LEFT JOIN unitssold u
              ON p.product_id = u.product_id
                 AND u.purchase_date BETWEEN start_date AND end_date
GROUP  BY product_id; 

-- v2
SELECT   product_id,
         CASE
                  WHEN Sum(units) IS NULL THEN 0
                  ELSE Round(Sum(total_price) / Sum(units), 2) END as average_price
                  FROM     (
                                      SELECT     p.product_id,
                                                 units,
                                                 units * price AS total_price
                                      FROM       unitssold     AS u
                                      RIGHT JOIN prices        AS p
                                      ON         p.product_id = u.product_id
                                      AND        purchase_date BETWEEN start_date AND        end_date) AS temp
                  GROUP BY product_id;

-- 1075. Project Employees I
-- https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50
SELECT project_id,
       Round(Sum(experience_years) / Count(experience_years), 2) AS
       average_years
FROM   project AS p
       LEFT JOIN employee AS e
              ON p.employee_id = e.employee_id
GROUP  BY project_id; 

-- 1633. Percentage of Users Attended a Contest
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50
SELECT contest_id,
       Round(Count(user_id) / (SELECT Count(user_id)
                               FROM   users) * 100, 2) AS percentage
FROM   register
GROUP  BY contest_id
ORDER  BY percentage DESC,
          contest_id; 

-- 1211. Queries Quality and Percentage
-- https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50
SELECT query_name,
       Round(SUM(rating / position) / Count(*), 2) AS quality,
       Round(SUM(IF(rating < 3, 1, 0)) / Count(*) * 100, 2) AS poor_query_percentage
FROM   queries
GROUP  BY query_name; 

-- 1193. Monthly Transactions I
-- https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50
SELECT Substring(trans_date, 1, 7)            AS month,
       country,
       Count(*)                               AS trans_count,
       SUM(IF(state = "approved", 1, 0))      AS approved_count,
       SUM(amount)                            AS trans_total_amount,
       SUM(IF(state = "approved", amount, 0)) AS approved_total_amount
FROM   transactions
GROUP  BY month,
          country; 

-- 4. Immediate Food Delivery II
-- https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50
SELECT Round(SUM(IF(min_ord_dt = min_del_dt, 1, 0)) / Count(*) * 100, 2) AS
       immediate_percentage
FROM   (SELECT customer_id,
               Min(delivery_id)                 AS id,
               Min(order_date)                  AS min_ord_dt,
               Min(customer_pref_delivery_date) AS min_del_dt
        FROM   delivery
        GROUP  BY customer_id) AS temp; 

-- 550. Game Play Analysis IV
-- https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50
SELECT Round(Count(DISTINCT player_id) / (SELECT Count(DISTINCT player_id)
                                          FROM   activity), 2) AS fraction
FROM   activity
WHERE  ( player_id, Date_sub(event_date, interval 1 day) ) IN
              (SELECT player_id,
               Min(event_date) AS first_login
                                                               FROM   activity
              GROUP  BY player_id); 
			  
-- v2
WITH temp
     AS (SELECT player_id,
                event_date,
                Row_number()
                  OVER(
                    partition BY player_id
                    ORDER BY event_date) AS row_num
         FROM   activity),
     temp2
     AS (SELECT *
         FROM   temp
         WHERE  player_id IN (SELECT player_id
                              FROM   temp
                              GROUP  BY player_id
                              HAVING Count(*) > 1))
SELECT Ifnull(Round(Sum(Datediff(t2.event_date, t1.event_date) = 1) / (SELECT
                                  Count(DISTINCT player_id)
                                                                       FROM
                    activity)
                     , 2), 0) AS fraction
FROM   temp2 AS t1
       INNER JOIN temp2 AS t2
               ON t1.player_id = t2.player_id
WHERE  t1.row_num = 1
       AND t2.row_num = 2; 
