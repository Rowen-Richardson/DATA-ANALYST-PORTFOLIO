-- Stored Procedures normally used for repetation 

SELECT *
FROM employee_salary
WHERE salary >= 50000;

#USE parks_and_rec is always good to call the fill you want to use
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();

DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries3();



DELIMITER $$
CREATE PROCEDURE large_salaries5(p_employee_id INT)
BEGIN
	SELECT 
    es.salary,
    ed.first_name,
    ed.last_name
	FROM employee_salary es
    Join 
    employee_demographics ed
    on 
    es.employee_id = ed.employee_id
    WHERE 
    es.employee_id = p_employee_id
    ;
END $$
DELIMITER ;

CALL large_salaries5(6);