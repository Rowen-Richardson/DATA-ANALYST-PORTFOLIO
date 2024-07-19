-- WHERE Clause --
# Where only fullfiles a specific condition
SELECT *
from parks_and_recreation.employee_demographics
where first_name = 'Leslie'
;


SELECT *
from parks_and_recreation.employee_salary
where salary <= 50000
;

SELECT *
from parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators
SELECT *
from parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;


-- LIKE Statment --
-- % and _ (where the % means anything and underscore _ means any value or set value) --
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a___%'
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '1989%'
;



















