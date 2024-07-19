-- Having vs Where
SELECT gender, AVG(age)
FROM  employee_demographics
GROUP BY gender 
HAVING AVG(age) > 40
;


SELECT occupation, AVG(salary)
FROM  employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 70000 #Having only filters on the agregated collums 
;