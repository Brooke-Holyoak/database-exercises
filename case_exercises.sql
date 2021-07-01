
## from subqueries to find employees NOT in the company
select *
from dept_emp
where to_date < now(); -- while this includes former employees, it also includes employees who have switched depts

select *
from dept_emp
where to_date > now(); /*this finds the current employees.  Now we can go to the employee table and find the employees NOT LIKE this.*/

Select count(*)
FROM employees
WHERE emp_no NOT IN (
SELECT emp_no 
FROM dept_emp
WHERE to_date > now()
);


/*Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

How many employees (current or previous) were born in each decade?*/

USE employees;

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp_no, dept_no, from_date, to_date,
	IF (to_date > now(), TRUE, FALSE)
	AS "is_current_employee"
FROM dept_emp;


SELECT emp_no, dept_no, from_date, to_date,
	IF (to_date > now(), TRUE, FALSE)
	AS "is_current_employee"

FROM dept_emp
;
-- what am I trying to do?  I want to keep only the most recent to_date for employees
;

SELECT emp_no, MAX(to_date) 
from dept_emp
GROUP By emp_no
; 

-- this gets me a result that only takes only the latest dates for the employees but I can't figure out how to connect this with the above.

SELECT de.emp_no,
    MAX(dnum.dept_no) as "Department Number",
    MIN(de.from_date) as "Start Date", MAX(de.to_date) as "End Date",
    IF (MAX(de.to_date) > NOW(), TRUE, FALSE) is_current_employee
FROM dept_emp de
LEFT JOIN (SELECT dept_no, emp_no FROM dept_emp
WHERE to_date = (SELECT MAX(to_date) FROM dept_emp)) dnum using (emp_no)
GROUP BY emp_no;


-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name, 
	CASE 
	WHEN last_name LIKE 'A%' THEN 'A-H'
	WHEN last_name LIKE 'B%' THEN 'A-H'
	WHEN last_name LIKE 'C%' THEN 'A-H'
	WHEN last_name LIKE 'D%' THEN 'A-H'
	WHEN last_name LIKE 'E%' THEN 'A-H'
	WHEN last_name LIKE 'F%' THEN 'A-H'
	WHEN last_name LIKE 'G%' THEN 'A-H'
	WHEN last_name LIKE 'H%' THEN 'A-H'
	WHEN last_name LIKE 'I%' THEN 'I-Q'
	WHEN last_name LIKE 'J%' THEN 'I-Q'
	WHEN last_name LIKE 'K%' THEN 'I-Q'
	WHEN last_name LIKE 'L%' THEN 'I-Q'
	WHEN last_name LIKE 'M%' THEN 'I-Q'
	WHEN last_name LIKE 'N%' THEN 'I-Q'
	WHEN last_name LIKE 'O%' THEN 'I-Q'
	WHEN last_name LIKE 'P%' THEN 'I-Q'
	WHEN last_name LIKE 'Q%' THEN 'I-Q'
	WHEN last_name LIKE 'R%' THEN 'R-Z'
	WHEN last_name LIKE 'S%' THEN 'R-Z'
	WHEN last_name LIKE 'T%' THEN 'R-Z'
	WHEN last_name LIKE 'U%' THEN 'R-Z'
	WHEN last_name LIKE 'V%' THEN 'R-Z'
	WHEN last_name LIKE 'W%' THEN 'R-Z'
	WHEN last_name LIKE 'X%' THEN 'R-Z'
	WHEN last_name LIKE 'Y%' THEN 'R-Z'
	WHEN last_name LIKE 'Z%' THEN 'R-Z'
	ELSE 'OTHER'
	END AS alpha_group
FROM employees; -- There HAS to be a shorter way to code this.  I get the right result, but that's ALOT to look at. ^^ BELOW is BETTER:

SELECT first_name, last_name, 
	CASE 
	WHEN SUBSTRING(last_name, 1, 1) BETWEEN "A" and "H" THEN "A-H"
	WHEN SUBSTRING(last_name, 1, 1) BETWEEN "I" and "Q" THEN "I-Q"
	WHEN SUBSTRING(last_name, 1, 1) BETWEEN "R" and "Z" THEN "R-Z"
	ELSE 'OTHER'
	END AS alpha_group
FROM employees; 


-- 3. How many employees (current or previous) were born in each decade?

SELECT
	CASE 
	WHEN birth_date LIKE '195%' THEN '50s'
	WHEN birth_date LIKE '196%' THEN '60s'
	WHEN birth_date LIKE '197%' THEN '70s'
	WHEN birth_date LIKE '198%' THEN '80s'
	WHEN birth_date LIKE '199%' THEN '90s'
END AS birth_decades,
COUNT(*) AS count_of_decades
	FROM employees
	GROUP BY birth_decades
	ORDER BY count_of_decades; 
	
-- I could also first check out the MAX and MIN birthdate so I avoid adding unnecessary buckets.

