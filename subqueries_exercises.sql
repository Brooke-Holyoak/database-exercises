
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
AND to_date > NOW();


## 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

## 4. Find all the current department managers that are female. List their names in a comment in your code.

## 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

## 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?