-- Window Functions 
#ARE LIKE group bys but don't put things in one row they are more like partitions or a group that keeps a unique row

SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(partition by gender) #partition by separates like grouping 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(partition by gender ORDER BY dem.employee_id) AS Rolling_Total #(Rolling total continues adding from the top to bottom) #partition by separates like grouping 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
    
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
Row_Number() OVER(PARTITION BY gender ORDER BY salary DESC) row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) rank_num, #gives the number ranked so instead of 6 it gives us 7
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num #give the next number numaricly and not ranked
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;