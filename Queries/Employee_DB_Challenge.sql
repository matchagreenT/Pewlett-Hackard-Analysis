-- Creating tables for Employee_DB_Challenge
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
 	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE dept_emp (
 	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
 	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

drop table unique_titles cascade

-- Creating retirement tables for retirees
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	e.hire_date,
    t.title,
    t.from_date,
	t.to_date
INTO unique_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (t.to_date = '9999-01-01');

select * from retirement_line

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title
INTO retires
FROM retirement_line


select * from unique_titles

-- Create Mentorship table
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibility
FROM unique_titles as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

select * from mentorship_eligibility

drop table mentorship_eligibility
