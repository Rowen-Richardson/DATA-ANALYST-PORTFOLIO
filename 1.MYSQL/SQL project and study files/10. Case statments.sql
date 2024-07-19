-- Case statments 
#normally used for logic 
SELECT first_name,
last_name,
age,
CASE
WHEN age <= 30 THEN 'Young'
WHEN age BETWEEN 31 and 50 THEN 'Old'
WHEN age >= 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics;

-- We are looking for the Pay Increase and Bonus
-- So if < 50000 = 5% raise
-- > 50000 = 7%
-- if the work in Finance = 10% bonus

SELECT first_name, last_name, salary,
CASE
WHEN salary < 50000 THEN salary + (salary * 0.05)
WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS New_Salary,
CASE 
WHEN dept_id = 6 THEN salary * .10
END As Bonus
FROM employee_salary;

SELECT * 
FROM employee_salary;
SELECT *
FROM parks_departments;