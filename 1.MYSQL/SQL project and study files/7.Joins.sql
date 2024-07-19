-- Joins

SELECT *
FROM  employee_demographics;

SELECT *
FROM  employee_salary;

SELECT dem.employee_id, age, occupation
FROM  employee_demographics AS dem
INNER JOIN employee_salary  AS sal #inner join returns rows that are the same in both colums 
	ON dem.employee_id = sal.employee_id
;


-- Outer Join

SELECT *
FROM  employee_demographics AS dem
RIGHT JOIN employee_salary  AS sal #OUTER / left and right joins the tables we are quering infromation from so if info is on the from line thats left and if info is on the join line that's right
	ON dem.employee_id = sal.employee_id
;

-- SELF JOIN 

SELECT emp1.employee_id AS emp_santa,
emp1.first_name As first_name_santa,
emp1.last_name As last_name_santa,
emp2.employee_id AS emp,
emp2.first_name As first_name_emp,
emp2.last_name As last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id +1 = emp2.employee_id
;


-- Joining Multiple tables together

SELECT *
FROM  employee_demographics AS dem
INNER JOIN employee_salary  AS sal #inner join returns rows that are the same in both colums 
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
	ON sal.dept_id = pd.department_id
;    
    
SELECT *
FROM parks_departments;