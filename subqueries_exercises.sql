
## Intro: Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

## 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

USE employees; 

-- What table do I need?  Employees
-- What do I need to do?  1. Find the hire date for employee 101010 2. Find all employees that match that.
-- Do the subquery first.


SELECT *
FROM employees
WHERE hire_date IN (
SELECT hire_date
FROM employees
WHERE emp_no LIKE "101010" -- 1990-10-22
) ;  -- There are 69 employees with the same hire date, including employee 101010





## 2. Find all the titles ever held by all current employees with the first name Aamod.

-- What Tables do I need?
-- 		Titles (table with title and to_date); Employees (table with employee first names)
-- What do I need to do?
--		I need to 1. Find employees with first name Aamod from employees. 
-- 				  2. Find all titles who have the same first name who are also current.


SELECT DISTINCT title -- without DISTINCT I get repeated titles
FROM titles
WHERE emp_no IN (
SELECT emp_no
FROM employees
WHERE first_name LIKE "Aamod"
)
AND to_date > NOW();  -- Results: Senior Staff, Engineer, Technique Leader, Senior Engineer, Staff and Assistant Engineer.


## 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

-- What tables do I need?  
--		Employees (it's asking for a number directly from this table)
--      

select *
from dept_emp
where to_date < now(); -- while this includes former employees, it also includes employees who have switched depts

select *
from dept_emp
where to_date > now(); /*this finds the current employees.  Now we can go to the employee table and find the employees NOT LIKE this.*/

Select *
FROM employees
WHERE emp_no NOT IN (
SELECT emp_no 
FROM dept_emp
WHERE to_date > now()
);
-- there are 59900 employees in the employee table who are not current


## 4. Find all the current department managers that are female. List their names in a comment in your code.

-- What tables do I need? dept_manager to find current managers, and employees to get names and gender

SELECT first_name, last_name, gender
FROM employees
WHERE emp_no IN (
SELECT emp_no 
FROM dept_manager
WHERE to_date > now()
);

## 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

-- What tables do I need? Salaries
-- What do I need to do?  find the average salary from all salaries.  then find which current employees have a salary that is greater than that
-- value.

SELECT emp_no, salary
FROM salaries
WHERE to_date > NOW() AND
salary > (
SELECT AVG(salary) FROM salaries
);



## 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- What tables do I need? Salaries
-- What do I need to do? Find current salaries. Find the highest or MAX salary. Find the STDDEV. Find which salaries are within one STDDEV.

SELECT emp_no, salary
FROM salaries
WHERE to_date > NOW() AND
salary >= (
(SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW())-
(SELECT STDDEV(salary)
FROM salaries
WHERE to_date > NOW())
);

-- 83 current salaries are within 1 standard deviation of the current highest salary of 158220.
-- 83/2582043 = .003% of all salaries ever. 83/240124 = .0035% of current salaries.

##Below are individual queries used to build the above query and solution.
SELECT STDDEV(salary)
FROM salaries
WHERE to_date > NOW();

SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW();

SELECT salary
FROM salaries
WHERE to_date > NOW();



