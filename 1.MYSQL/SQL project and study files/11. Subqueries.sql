-- Subqueries
#this was a department look up to find out who works in the Parks and Rec department and what they salary is 
SELECT *
FROM employee_demographics
WHERE employee_id 
IN (SELECT employee_id #the brackets or IN () make it a subquery which means we basically looking for info in a specific order or place 
FROM employee_salary
WHERE dept_id = 1)
;


SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;



SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

select AVG(max_age)
FROM
(SELECT gender, AVG(age)as avg_age, 
MAX(age) as max_age, 
MIN(age) as min_age, 
COUNT(age) as count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table;






