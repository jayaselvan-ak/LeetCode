-- https://leetcode.com/studyplan/top-sql-50/

-- 1667. Fix Names in a Table
-- https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50
SELECT user_id,
       Concat(Ucase(Substring(NAME, 1, 1)), Lcase(Substring(NAME, 2))) AS NAME
FROM   users; 

-- 1527. Patients With a Condition
-- https://leetcode.com/problems/patients-with-a-condition/description/?envType=study-plan-v2&envId=top-sql-50
SELECT patient_id,
       patient_name,
       conditions
FROM   patients
WHERE  conditions LIKE 'DIAB1%'
        OR conditions LIKE '% DIAB1%'; 

-- 196. Delete Duplicate Emails
-- https://leetcode.com/problems/delete-duplicate-emails/description/?envType=study-plan-v2&envId=top-sql-50
DELETE p1
FROM   person p1,
       person p2
WHERE  p1.email = p2.email
       AND p1.id > p2.id; 

-- 176. Second Highest Salary
-- https://leetcode.com/problems/second-highest-salary/description/?envType=study-plan-v2&envId=top-sql-50
SELECT Max(salary) AS SecondHighestSalary
FROM   employee
WHERE  salary <> (SELECT Max(salary)
                  FROM   employee); 

-- 1484. Group Sold Products By The Date
-- https://leetcode.com/problems/group-sold-products-by-the-date/description/?envType=study-plan-v2&envId=top-sql-50
SELECT sell_date,
       Count(DISTINCT product)                                           AS
       num_sold,
       Group_concat(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS
       products
FROM   activities
GROUP  BY sell_date
ORDER  BY sell_date ASC; 

-- 1327. List the Products Ordered in a Period
-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50
SELECT product_name,
       s_unit AS unit
FROM   (SELECT product_id,
               Sum(unit) AS s_unit
        FROM   orders
        WHERE  order_date LIKE '2020-02-%'
        GROUP  BY product_id
        HAVING s_unit > 99) AS temp
       LEFT JOIN products
              ON products.product_id = temp.product_id; 

-- 1517. Find Users With Valid E-Mails
-- https://leetcode.com/problems/find-users-with-valid-e-mails/description/?envType=study-plan-v2&envId=top-sql-50
SELECT *
FROM   users
WHERE  mail REGEXP '^[A-Za-z][A-Za-z0-9_\.\-]*@leetcode(\\?com)?\\.com$'; 

