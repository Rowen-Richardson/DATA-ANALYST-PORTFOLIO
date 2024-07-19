-- String Functions

SELECT length('skyfall');

SELECT first_name, length(first_name)
FROM employee_demographics
ORDER BY 2 ;

SELECT upper('sky');
SELECT lower('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;


SELECT RTRIM('           SKY          ');


SELECT first_name, 
left(first_name,4),
right(first_name, 4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) AS birth_month
FROM employee_demographics;


SELECT first_name, replace(first_name, 'a','z') As Nw_names
FROM employee_demographics;


SELECT locate('x','Alexander');

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) As full_name #will be used all the time
FROM employee_demographics;