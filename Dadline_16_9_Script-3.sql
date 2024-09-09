CREATE DATABASE quanlycongty;
USE quanlycongty;


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    salary DECIMAL(10, 2),
    start_date DATE,
    department_id INT
);

CREATE TABLE access_rights (
    access_id INT PRIMARY KEY,
    employee_id INT,
    access_level VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255)
);

INSERT INTO employees (employee_id, employee_name, salary, start_date, department_id)
VALUES
    (1, 'John Doe', 60000, '2021-01-15', 1),
    (2, 'Jane Smith', 70000, '2020-05-20', 2),
    (3, 'Bob Johnson', 55000, '2022-03-10', 1),
    (4, 'Alice Williams', 80000, '2021-08-05', 3),
    (5, 'Charlie Brown', 65000, '2020-12-01', 2);

INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'IT'),
    (2, 'Sales'),
    (3, 'HR');

INSERT INTO access_rights (access_id, employee_id, access_level)
VALUES
    (1, 1, 'Admin'),
    (2, 2, 'User'),
    (3, 3, 'User'),
    (4, 4, 'Admin'),
    (5, 5, 'User');

   
SELECT *
FROM employees;


SELECT e.employee_name, e.salary
FROM employees e;


SELECT *
FROM employees
WHERE salary > 50000;

SELECT d.department_name, COUNT(e.employee_id) 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name ;



SELECT employee_name
FROM employees
ORDER BY employee_name ASC;


SELECT e.employee_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary BETWEEN 40000 AND 60000
ORDER BY e.salary DESC;


SELECT SUM(salary) FROM employees; 


SELECT e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;


SELECT d.department_name, COUNT(e.employee_id) 
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) >= 3; 




SELECT e.employee_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id BETWEEN 1 AND 2;


SELECT e.employee_name,e.start_date
FROM employees e
WHERE start_date > '2020-01-01';


SELECT AVG(salary) FROM employees;


SELECT e.employee_name, e.salary
FROM employees e
ORDER BY e.salary DESC 
LIMIT 5;


SELECT e.employee_name
FROM employees e
WHERE e.employee_name LIKE '%a%';


SELECT e.employee_name, a.access_level
FROM employees e
JOIN access_rights a ON e.employee_id = a.employee_id
WHERE a.access_level = "admin";


SELECT d.department_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_salary DESC;



SELECT e.employee_name,e.start_date
FROM employees e
ORDER BY e.start_date ASC;


SELECT d.department_name, e.employee_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE (e.salary, e.department_id) IN (
    SELECT MAX(salary), department_id
    FROM employees
    GROUP BY department_id
);



SELECT e.employee_name, a.access_level
FROM employees e
LEFT JOIN access_rights a ON e.employee_id = a.employee_id;








 


