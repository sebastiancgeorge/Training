--Design a database for an HR portal app.
--The database should contain the following attributes:
--
--1. User Details: Basic information about employees, including personal and contact details.
--
--2. Department Details: Information about different departments within the organisation.
--
--3. Designation Details: Records of designations held by employees, including the time periods for each designation.
--
--4. Salary Details: Salary records for employees, including the time periods for each salary amount.
--Add sample entries to this database:
--
--Add sample entries to this database.
--Insert data for 10 employees, 5 departments, and 5 designations.

create table departments (
id serial primary key,
department_name varchar(25) not null
);

create table employees (
id serial primary key ,
name varchar(25) not null ,
address varchar (25) , 
email varchar(25) ,
phno decimal(12) ,
dept_id int references departments(id) 
);

create table designations (
id serial primary key,
designation_name varchar(25),
employee_id int references employees(id),
start_date date,
end_date date
);

create table salaries (
id serial primary key,
employee_id int references employees(id),
amount decimal(10,2),
start_date date,
end_date date
);

INSERT INTO departments (department_name) VALUES
('Human Resources'),
('Finance'),
('Engineering'),
('Marketing'),
('Sales');

INSERT INTO employees (name, address, email, phno, dept_id) VALUES
('Alice Johnson', 'New York', 'alice@example.com', 9876543210, 1),
('Bob Smith', 'Chicago', 'bob@example.com', 9876543211, 2),
('Charlie Brown', 'Dallas', 'charlie@example.com', 9876543212, 3),
('David Miller', 'Seattle', 'david@example.com', 9876543213, 3),
('Emma Wilson', 'Boston', 'emma@example.com', 9876543214, 4),
('Frank Thomas', 'Denver', 'frank@example.com', 9876543215, 5),
('Grace Lee', 'Austin', 'grace@example.com', 9876543216, 1),
('Henry Walker', 'Miami', 'henry@example.com', 9876543217, 2),
('Isabella Hall', 'Phoenix', 'isabella@example.com', 9876543218, 4),
('Jack Young', 'San Diego', 'jack@example.com', 9876543219, 5);

INSERT INTO designations (designation_name, employee_id, start_date, end_date) VALUES
('HR Manager', 1, '2022-01-01', NULL),
('Accountant', 2, '2021-06-15', NULL),
('Software Engineer', 3, '2023-03-01', NULL),
('Senior Software Engineer', 4, '2022-08-10', NULL),
('Marketing Executive', 5, '2021-11-20', NULL),
('Sales Executive', 6, '2020-05-01', NULL),
('HR Executive', 7, '2023-01-10', NULL),
('Financial Analyst', 8, '2022-07-01', NULL),
('Marketing Manager', 9, '2021-09-15', NULL),
('Sales Manager', 10, '2020-12-01', NULL);

INSERT INTO salaries (employee_id, amount, start_date, end_date) VALUES
(1, 75000.00, '2022-01-01', NULL),
(2, 68000.00, '2021-06-15', NULL),
(3, 90000.00, '2023-03-01', NULL),
(4, 120000.00, '2022-08-10', NULL),
(5, 65000.00, '2021-11-20', NULL),
(6, 70000.00, '2020-05-01', NULL),
(7, 55000.00, '2023-01-10', NULL),
(8, 80000.00, '2022-07-01', NULL),
(9, 95000.00, '2021-09-15', NULL),
(10, 105000.00, '2020-12-01', NULL);

select name from employees e inner join departments d on e.dept_id = d.id where d.department_name = 'Engineering';

select name from employees e inner join salaries s on e.id = s.id where s.amount  > 60000 ;

select d.department_name , count(e.*) from employees e inner join departments d on e.dept_id = d.id group by d.department_name ;

select d.department_name , AVG(s.amount) from employees e 
inner join departments d 
on e.dept_id = d.id 
inner join salaries s on e.id = s.employee_id  
group by d.department_name;

select d.department_name , MIN(s.amount), MAX(s.amount ), AVG(s.amount) from employees e 
inner join departments d 
on e.dept_id = d.id 
inner join salaries s on e.id = s.employee_id  
group by d.department_name;

select e.name , s.amount  from employees e 
inner join departments d 
on e.dept_id = d.id 
inner join salaries s on e.id = s.employee_id  
where d.department_name = 'Engineering' and 
s.amount >50000 order by s.amount ;

select d.department_name , AVG(s.amount) as average from employees e 
inner join departments d 
on e.dept_id = d.id 
inner join salaries s on e.id = s.employee_id
group by d.department_name
having AVG(s.amount) > 60000 ;

select e.name , s.amount  from employees e 
inner join departments d 
on e.dept_id = d.id 
inner join salaries s on e.id = s.employee_id  
where s.amount > (select AVG(s2.amount ) from 
employees e2 inner join salaries s2 
on e2.dept_id = s2.employee_id  where e2.dept_id = e.dept_id );


