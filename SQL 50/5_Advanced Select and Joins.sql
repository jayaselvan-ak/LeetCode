-- https://leetcode.com/studyplan/top-sql-50/

-- 1731. The Number of Employees Which Report to Each Employee
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
SELECT e.employee_id,
       e.NAME,
       Count(m.employee_id) AS reports_count,
       Round(Avg(m.age))    AS average_age
FROM   employees AS e
       INNER JOIN employees AS m
               ON e.employee_id = m.reports_to
GROUP  BY e.employee_id,
          e.NAME
order by e.employee_id; 

-- 1789. Primary Department for Each Employee
-- https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50
SELECT employee_id,
       department_id
FROM   employee
GROUP  BY employee_id
HAVING Count(employee_id) = 1
UNION
SELECT employee_id,
       department_id
FROM   employee
WHERE  primary_flag = 'Y';

-- 610. Triangle Judgement
-- https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50
SELECT x,
       y,
       z,
       CASE
         WHEN x + y > z
               and x + z > y
               and z + y > x THEN "Yes"
         ELSE "No"
       END AS triangle
FROM   triangle; 

-- 180. Consecutive Numbers
-- https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50
WITH cte
     AS (SELECT num,
                Lead(num, 1)
                  OVER() num1,
                Lead(num, 2)
                  OVER() num2
         FROM   logs)
SELECT DISTINCT num ConsecutiveNums
FROM   cte
WHERE  num = num1
       AND num = num2; 

-- 1164. Product Price at a Given Date
-- https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50
SELECT DISTINCT product_id,
                10 AS price
FROM   products
WHERE  product_id NOT IN(SELECT DISTINCT product_id
                         FROM   products
                         WHERE  change_date <= '2019-08-16')
UNION
SELECT product_id,
       new_price AS price
FROM   products
WHERE  ( product_id, change_date ) IN (SELECT product_id,
                                              Max(change_date) AS date
                                       FROM   products
                                       WHERE  change_date <= '2019-08-16'
                                       GROUP  BY product_id); 

-- 1204. Last Person to Fit in the Bus
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/?envType=study-plan-v2&envId=top-sql-50
SELECT q1.person_name
FROM   queue q1
       JOIN queue q2
         ON q1.turn >= q2.turn
GROUP  BY q1.turn
HAVING Sum(q2.weight) <= 1000
ORDER  BY Sum(q2.weight) DESC
LIMIT  1; 

-- 1907. Count Salary Categories
-- https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50
SELECT "Low Salary"        AS category,
       Sum(income < 20000) AS accounts_count
FROM   accounts
UNION
SELECT "Average Salary"                    AS category,
       Sum(income BETWEEN 20000 AND 50000) AS accounts_count
FROM   accounts
UNION
SELECT "High Salary"       AS category,
       Sum(income > 50000) AS accounts_count
FROM   accounts; 
