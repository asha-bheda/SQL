
/*
* employee table

employee_id	first_name	last_name	dept_id	manager_id	salary	expertise
100	        John    	White   	IT      	103	    120000	Senior
101	        Mary    	Danner  	Account     109	    80000	junior
102	        Ann	        Lynn	    Sales	    107	    140000	Semisenior
103	        Peter	    O'connor	IT	        110	    130000	Senior
106	        Sue	        Sanchez	    Sales	    107	    110000	Junior
107	        Marta	    Doe	        Sales	    110	    180000	Senior
109	        Ann	        Danner	    Account	    110	    90000	Senior
110	        Simon	    Yang	    CEO     	null	250000	Senior
111	        Juan	    Graue	    Sales	    102	    37000	Junior 
*/

/* 1. Example #1 - Ranking Rows Based on a Specific Ordering Criteria */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee order by rank;


/* 2. Example #2 - List The First 5 Rows of a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee order by rank limit 5;


/* 3 Example #3 - List the Last 5 Rows of a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary ASC) AS rank from employee order by rank limit 5;


/* Example #4 - List The Second Highest Row of a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee order by rank limit 1 offset 1;


with employee_ranking as (SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee)
    select * from employee_ranking where rank = 2
    
    /* Example #5 - List the Second Highest Salary By Department */

SELECT
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise
    from employee order by salary DESC limit 1 offset 1;

/* Example #6 - List the First 50% Rows in a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee order by rank limit (select count(*)/2 from employee);

WITH employee_ranking AS (
    SELECT
    employee_id,
    last_name,
    first_name,
    salary,
    NTILE(2) over (order by salary desc) as salary_rank) 
    SELECT * FROM employee_ranking WHERE salary_rank = 1;


/*  NTILE function divides rows of data into equal groups and returns the rank of those groups. */

/* Example #7 - List the Last 25% Rows in a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    RANK() OVER (ORDER BY salary DESC) AS rank from employee order by rank limit (select count(*)/4 from employee) offset (select count(*)/2 from employee);

WITH employee_ranking AS (
    SELECT
    employee_id,
    last_name,
    first_name,
    salary,
    NTILE(4) over (order by salary desc) as salary_rank) 
    SELECT * FROM employee_ranking WHERE salary_rank = 1;

/* Example #8 - Number the Rows in a Result Set */

SELECT 
    employee_id,
    first_name,
    last_name,
    dept_id,
    manager_id,
    salary,
    expertise,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_number from employee order by row_number;

/* Example #9 - List All Combinations of Rows from Two Tables */