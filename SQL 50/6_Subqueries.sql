-- https://leetcode.com/studyplan/top-sql-50/

-- 1978. Employees Whose Manager Left the Company
-- https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50
SELECT employee_id
FROM   employees
WHERE  salary < 30000
       AND manager_id NOT IN (SELECT DISTINCT employee_id
                              FROM   employees)
ORDER  BY employee_id; 

-- 626. Exchange Seats
-- https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50
SELECT CASE
         WHEN ( id = (SELECT Max(id)
                      FROM   seat)
                AND id % 2 = 1 ) THEN id
         WHEN ( id % 2 = 1 ) THEN id + 1
         WHEN ( id % 2 = 0 ) THEN id - 1
       end AS id,
       student
FROM   seat
ORDER  BY id; 

-- 1341. Movie Rating
-- https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50
SELECT user_id,
       Concat(Ucase(Substring(NAME, 1, 1)), Lcase(Substring(NAME, 2))) AS NAME
FROM   users; 

-- 1321. Restaurant Growth
-- https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50


-- 602. Friend Requests II: Who Has the Most Friends
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50


-- 585. Investments in 2016
-- https://leetcode.com/problems/investments-in-2016/description/?envType=study-plan-v2&envId=top-sql-50


-- 185. Department Top Three Salaries
-- https://leetcode.com/problems/department-top-three-salaries/description/?envType=study-plan-v2&envId=top-sql-50

