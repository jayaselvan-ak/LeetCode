-- https://leetcode.com/studyplan/top-sql-50/

-- 2356. Number of Unique Subjects Taught by Each Teacher
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50
SELECT teacher_id,
       Count(DISTINCT subject_id) AS cnt
FROM   teacher
GROUP  BY teacher_id; 

-- 1141. User Activity for the Past 30 Days I
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50
SELECT activity_date           AS DAY,
       COUNT(DISTINCT user_id) AS active_users
FROM   activity
WHERE  activity_date BETWEEN Date_add('2019-07-27', interval - 29 DAY) AND
                             '2019-07-27'
GROUP  BY activity_date; 

-- 1070. Product Sales Analysis III
-- https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50
SELECT product_id,
       year AS first_year,
       quantity,
       price
FROM   sales
WHERE  ( product_id, year ) IN (SELECT product_id,
                                       Min(year) AS mn_yr
                                FROM   sales
                                GROUP  BY product_id); 

-- 596. Classes More Than 5 Students
-- https://leetcode.com/problems/classes-more-than-5-students/description/?envType=study-plan-v2&envId=top-sql-50
SELECT class
FROM   courses
GROUP  BY class
HAVING Count(student) > 4; 

-- 1729. Find Followers Count
-- https://leetcode.com/problems/find-followers-count/description/?envType=study-plan-v2&envId=top-sql-50
SELECT user_id,
       Count(DISTINCT follower_id) AS followers_count
FROM   followers
GROUP  BY user_id; 

-- 619. Biggest Single Number
-- https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50
SELECT Max(num) AS num
FROM  (SELECT num
       FROM   mynumbers
       GROUP  BY num
       HAVING Count(num) = 1
       ORDER  BY num DESC) AS temp; 

-- 1045. Customers Who Bought All Products
-- https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50
SELECT customer_id
FROM   customer
GROUP  BY customer_id
HAVING Count(distinct product_key) = (SELECT Count(product_key)
                             FROM   product); 
