

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

/*I saved after lunch, but apparently I didn't save between lunch and now.  So I lost everything I've done from 2ish-6.  I had it all complete, and I'll try to work through it all again... Here's what is on our germain githib for now... Mine was a bit different with really good notes too!! :(*/

# Exercise 4, Find  the current titles of employees currently working in the Customer Service department.
select title, count(title)
from dept_emp
join departments using(dept_no)
join titles using(emp_no)
where departments.dept_name = "Customer Service"
and dept_emp.to_date > curdate()
and titles.to_date > curdate()
group by title
order by title;


-- Exercise 5. Find the current salary of all current managers.
select dept_no, salary, concat(first_name, " ", last_name) as "Current Manager"
from salaries
join dept_manager using(emp_no)
join employees using(emp_no)
join departments using(dept_no)
where dept_manager.to_date > curdate()
and salaries.to_date > curdate();

# Exercise 6
# Find the number of current employees in each department.
select dept_no, dept_name, count(*) as num_employees
from departments
join dept_emp using(dept_no)
where to_date > curdate()
group by dept_no
order by dept_no;

# Exercise 7 
# Which department has the highest average salary? Hint: Use current not historic information.

select dept_name, avg(salary) as average_salary
from salaries
join dept_emp using(emp_no)
join departments using(dept_no)
where dept_emp.to_date > curdate()
and salaries.to_date > curdate()
group by dept_name
order by average_salary DESC;

# Exercise 8
# Who is the highest paid employee in the Marketing department? 
select first_name, last_name, salary
from departments
join dept_emp using(dept_no)
join salaries using(emp_no)
join employees using(emp_no)
where salaries.to_date > curdate()
and dept_emp.to_date > curdate()
and dept_name = "Marketing"
order by salary DESC
limit 1;


# Exercise 9
# Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from salaries
join dept_manager using(emp_no)
join departments using(dept_no)
join employees using(emp_no)
where salaries.to_date > curdate()
and dept_manager.to_date > curdate()
order by salary DESC
limit 1;

