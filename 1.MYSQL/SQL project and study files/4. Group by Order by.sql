-- Group by or Order by --

SELECT *
FROM employee_demographics;


SELECT gender, AVG(age), Max(age), Min(age), Count(age)		#this needs to match with the group by 
FROM employee_demographics
GROUP BY gender
;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

-- ORDER BY 
SELECT * 
FROM employee_demographics
ORDER BY gender, age #Order by always orders things in ASC which means assending and DESC would do the opposite 
;















