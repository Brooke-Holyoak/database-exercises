
/* Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
Update the table so that full name column contains the correct data
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?
Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?*/

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
-- Update the table so that full name column contains the correct data
-- Remove the first_name and last_name columns from the table.
-- What is another way you could have ended up with this same table?

USE employees; 


CREATE TEMPORARY TABLE germain_1475.employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);

SELECT * 
FROM germain_1475.employees_with_departments; 

DESCRIBE employees; -- first_name is VARCHAR(14), last_name is VARCHAR(16) so full_name should be at VARCHAR(31) to allow for a space.

USE germain_1475; 

select * from employees_with_departments; 

ALTER TABLE employees_with_departments ADD full_name VARCHAR(31); -- this creates the column with NULL values

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments 
DROP COLUMN first_name;  

ALTER TABLE employees_with_departments 
DROP COLUMN last_name; 

-- another way to create this table would be to create the full_name column by using the data from the employees.employees table.  













-- 2. Create a temporary table based on the payment table from the sakila database.


