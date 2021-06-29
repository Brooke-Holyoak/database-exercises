
USE employees;

DESCRIBE employees;

SELECT first_name
FROM `employees`
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- this returned 709 rows




SELECT first_name
FROM employees
WHERE first_name = "Irena"
OR first_name = "Vidya" 
OR first_name = "Maya";
-- this returned 709 rows


/*Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.*/

SELECT first_name
FROM employees
WHERE
   (first_name = "Irena"
OR first_name = "Vidya" 
OR first_name = "Maya")
AND gender = "M";

SELECT last_name
FROM empl





