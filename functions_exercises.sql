

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

USE employees;

DESCRIBE employees; 

SELECT first_name, last_name
FROM employees
WHERE first_name IN  ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; 


#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name IN  ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name; 

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name IN  ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

#Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE "e%e"
ORDER BY emp_no; 


#Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

SELECT hire_date, last_name
FROM employees
WHERE last_name LIKE "e%e"
ORDER BY hire_date ASC;

#Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

SELECT hire_date, last_name
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date ASC;

###FUNCTIONS EXERCISES

#Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

SELECT CONCAT (first_name, ' ', last_name) as full_name
FROM employees
WHERE last_name LIKE "e%e";

#Convert the names produced in your last query to all uppercase.

SELECT CONCAT (UPPER(first_name), ' ', UPPER(last_name)) as full_name
FROM employees
WHERE last_name LIKE "e%e";

#Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT CONCAT (first_name, ' ', last_name) as full_name, DATEDIFF(NOW(), hire_date) AS how_many_days
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';


#Find the smallest and largest current salary from the salaries table.

USE salaries;
DESCRIBE salaries;

SELECT MIN(salary) from salaries; 
SELECT MAX(salary) from salaries;


#Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

USE employees; 
select lower(concat(
    substr(first_name, 1, 1), # first initial of first name
    substr(last_name, 1, 4), # first 4 of last name
		 "_",
		 substr(hire_date, 6, 2), # month
		 substr(hire_date, 3, 2) # 2 yr
)) as username,first_name, last_name, birth_date
from employees; 