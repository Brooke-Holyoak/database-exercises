
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


/* 2. Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199. */

USE sakila; 

describe payment; 

CREATE TEMPORARY TABLE germain_1475.new_payment_amounts AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM payment;

USE germain_1475;

SELECT *
FROM new_payment_amounts;

DESCRIBE new_payment_amounts;

ALTER TABLE new_payment_amounts modify amount decimal(7,2);

UPDATE new_payment_amounts
SET amount = amount * 100; -- initially gave an error that row 44 was too large.  see above for modifying how many characters can be in amount.
-- this changes amount to have two decimal places, we want just a whole number without decimals.

ALTER TABLE new_payment_amounts modify amount INT; -- now amounts have been changed. 


/*Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?*/

USE employees; 

Select avg(salary)
FROM salaries 
WHERE to_date > now(); -- current average salary is 72012.2359

-- the above is the current OVERALL average salary, not by department.

SELECT * 
from salaries;

SELECT * 
from dept_emp;

CREATE TEMPORARY TABLE germain_1475.department_salaries AS
SELECT emp_no, salary, salaries.to_date AS salary_to_date, dept_no, dept_emp.to_date AS dept_to_date
FROM salaries
JOIN dept_emp USING(emp_no); 

SELECT dept_no, avg(salary)
FROM germain_1475.department_salaries
WHERE salary_to_date > now()
GROUP BY dept_no; -- checking to be sure I can see the current salaries by dept in my temp table.

-- now I will add the columns I need to get the zscores.

ALTER TABLE germain_1475.department_salaries ADD zscore float(10, 3);

ALTER TABLE germain_1475.department_salaries
ADD numerator INT;

ALTER TABLE germain_1475.department_salaries
ADD denominator INT;

select * 
FROM germain_1475.department_salaries
LIMIT 50; 

-- all columns needed are created (zscore, numerator, and denominator).  Now set up these columns to have the needed data.

UPDATE germain_1475.department_salaries
SET numerator = salary - (select avg(salary) from salaries);

UPDATE germain_1475.department_salaries
SET denominator = (select STD(salary) from salaries);

update germain_1475.department_salaries
set zscore = numerator/denominator; 

-- Now do a query to get the average salary by dept and the zscores in relation to the overall historic salary average.

SELECT dept_no, avg(salary), avg(zscore)
FROM germain_1475.department_salaries
WHERE salary_to_date > now()
GROUP BY dept_no
ORDER BY avg(zscore);

-- best dept to work for currently would be dept 7, and the worst would be dept 3













###scratch work below###
/*create temporary table ryan.zscore AS
select n, 
n - (select avg(n) from numbers) as "numerator", 
(select std(n) from numbers) as "denominator"
from numbers;*/

CREATE TEMPORARY TABLE germain_1475.zscores AS
select salary, salary - (select avg(salary) from salaries) as "numerator", (select STD(salary) from salaries) AS "denominator"
FROM salaries;

/*use ryan;

-- add a new column to the temp table
alter table zscore add zscore float(10, 3);

-- set the values for that column on the temp table
update zscore set zscore = numerator / denominator;

-- zscore = (x - avg(x)) / std(x)
select * from zscore;*/

use germain_1475; 

alter table zscores add zscore float(10, 3);



update zscores set zscore = numerator/denominator; 

select * from zscores; 
















