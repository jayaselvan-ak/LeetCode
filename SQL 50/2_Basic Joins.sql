-- https://leetcode.com/studyplan/top-sql-50/

-- 1378. Replace Employee ID With The Unique Identifier
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50
select 
  unique_id, 
  name 
from 
  Employees as E 
  left join EmployeeUNI as EU ON E.id = EU.id;
  
-- 1068. Product Sales Analysis I
-- https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50
select 
  product_name, 
  year, 
  price 
from 
  Product 
  inner join Sales on Product.product_id = Sales.product_id;

-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/?envType=study-plan-v2&envId=top-sql-50
select 
  customer_id, 
  count(Visits.visit_id) as count_no_trans 
from 
  Visits 
  left join Transactions on Visits.visit_id = Transactions.visit_id 
where 
  Transactions.amount is null 
group by 
  customer_id;
  
-- 197. Rising Temperature
-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50
select 
  w1.id
from 
  Weather w1, 
  Weather w2 
where 
  datediff(w1.recordDate, w2.recordDate) = 1 
  and w1.temperature > w2.temperature;

-- 1661. Average Time of Process per Machine
-- https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50
SELECT a1.machine_id,
       round(avg(a2.timestamp-a1.timestamp),3) AS processing_time
FROM Activity AS a1
LEFT JOIN Activity AS a2 ON a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
AND a1.activity_type = 'start'
AND a2.activity_type = 'end'
GROUP BY a1.machine_id;

-- 577. Employee Bonus
-- https://leetcode.com/problems/employee-bonus/?envType=study-plan-v2&envId=top-sql-50
select 
  name, 
  bonus 
from 
  Employee as E 
  left join Bonus as B on E.empId = B.empid 
where 
  bonus < 1000 
  or bonus is null;

-- v2
select 
  name, 
  bonus 
from 
  (
    select 
      name, 
      bonus 
    from 
      Employee as E 
      left join Bonus as B on E.empId = B.empid
  ) as temp 
where 
  bonus < 1000 
  or bonus is null;

-- 1280. Students and Examinations
-- https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50
SELECT 
  s.student_id, 
  s.student_name, 
  sub.subject_name, 
  COUNT(e.student_id) AS attended_exams 
FROM 
  Students s CROSS 
  JOIN Subjects sub 
  LEFT JOIN Examinations e ON s.student_id = e.student_id 
  AND sub.subject_name = e.subject_name 
GROUP BY 
  s.student_id, 
  s.student_name, 
  sub.subject_name 
ORDER BY 
  s.student_id, 
  sub.subject_name;

-- v2
select 
  temp.student_id, 
  temp.student_name, 
  temp.subject_name, 
  case when attended_exams_temp is null then 0 else attended_exams_temp end as attended_exams 
from 
  (
    select 
      * 
    from 
      students cross 
      join subjects
  ) as temp 
  left join (
    select 
      student_id, 
      subject_name, 
      count(student_id) as attended_exams_temp 
    from 
      Examinations 
    group by 
      student_id, 
      subject_name
  ) as E on temp.student_id = E.student_id 
  and temp.subject_name = E.subject_name 
order by 
  temp.student_id, 
  temp.subject_name;

-- 570. Managers with at Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/?envType=study-plan-v2&envId=top-sql-50
Select 
  m.name 
from 
  employee as e 
  inner join employee as m on e.managerId = m.id 
group by 
  m.id 
having 
  count(m.id) > 4;

-- v2
select 
  name 
from 
  Employee 
where 
  id in (
    select 
      managerId 
    from 
      Employee 
    group by 
      managerId 
    having 
      count(managerId) >= 5
  );

-- 1934. Confirmation Rate
-- https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50
SELECT s.user_id,
       Round(Avg(IF(c.action = "confirmed", 1, 0)), 2) AS confirmation_rate
FROM   signups AS s
       left join confirmations AS c
              ON s.user_id = c.user_id
GROUP  BY user_id;

-- v2
select
    s.user_id,
    case
        when round(sum(cnt) / count(*), 2) is null
            then 0
        else
            round(sum(cnt) / count(*), 2)
    end as confirmation_rate
from
    Signups as s
    left join
        (
            select
                user_id,
                case
                    when action = "confirmed"
                        then 1
                    else
                        0
                end as cnt
            from
                Confirmations
        )   as C
            on s.user_id = c.user_id
group by
    s.user_id;
