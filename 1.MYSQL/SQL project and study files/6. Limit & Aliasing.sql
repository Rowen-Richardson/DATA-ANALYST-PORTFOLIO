-- Limit & Aliasing

SELECT *
FROM  employee_demographics
ORDER BY age DESC
LIMIT 2,1 #Limit will only display the number of rows in a table that you are looking for so the comma in this example takes the comma next row
;


-- Aliasing

SELECT gender, AVG (age) avg_age
FROM  employee_demographics
GROUP BY gender
HAVING avg_age > 40
;