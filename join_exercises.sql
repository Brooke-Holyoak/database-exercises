

/*Join Example Database
Use the join_example_db. Select all the records from both the users and roles tables.

Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.*/


USE join_example_db;

DESCRIBE roles;
DESCRIBE users; 

SELECT * 
FROM users
JOIN roles ON users.role_id = roles.id; 

SELECT * 
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT * 
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

/*Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.*/

SELECT roles.id, roles.name AS Role, COUNT(users.role_id) AS Role_Count
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY roles.id; 
-- there is 1 admin, 1 author, 2 reviewers and 0 commenters

##Employees DB Join Exercises are below

USE employees;

-- write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) AS Manager
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date LIKE "9999%";

-- Find the name of all departments currently managed by women

SELECT departments.dept_name AS Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) AS Manager
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE employees.gender LIKE "F" AND dept_manager.to_date LIKE "9999%";

-- Find the current titles of employees currently working in the Customer Service department.

SELECT *
from titles
JOIN dept_emp ON titles.emp_no = dept_emp.emp_no; 

SELECT titles.title AS Title, COUNT(titles.emp_no) AS Count
from titles
JOIN dept_emp ON titles.emp_no = dept_emp.emp_no
GROUP BY titles.title;-- this is coming along, still working through it, I have a full count, now I just need to narrow it


