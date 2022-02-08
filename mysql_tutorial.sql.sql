-- Basic functions in sql are select- column_name, from- table_name, where - condition
use sql_store; -- sql_store is the database which we are going to use
SELECT 
    *
FROM
    customers
WHERE
    customer_id = 1;
-- Using the And operator on where clause
SELECT 
    *
FROM
    customers
WHERE
    birth_date >= '1990-01-01'
        AND points <= 3000;
 -- Using In statement
SELECT 
    *
FROM
    customers
WHERE
    state IN ('VA' , 'GA', 'FL');
 -- Using Like statement
SELECT 
    *
FROM
    customers
WHERE
    address LIKE '%TRAIL%'
        OR address LIKE '%AVENUE%';
-- Using regexp. It is effective version of like Fuction
SELECT 
    *
FROM
    customers
WHERE
    address REGEXP 'VENUE|TRAIL';
    
SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP '[bc]a';
SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP 'ey$ ';
 
 -- Using Null Functions
 SELECT 
    *
FROM
    orders
WHERE
    shipper_id IS NULL;
    
SELECT 
    *
FROM
    customers
WHERE
    phone IS NOT NULL;
 
-- Using Order_by Function
SELECT 
    *
FROM
    customers
ORDER BY first_name;
 -- Top 3 Loyal customers 
SELECT 
    *
FROM
    customers
ORDER BY points DESC
LIMIT 3;

-- Using Inner Join  function it is same as join function
SELECT 
    order_id, first_name, o.customer_id
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id;

SELECT 
    o.order_id, o.product_id, quantity, o.unit_price
FROM
    order_items o
        JOIN
    products p ON o.product_id = p.product_id;
    
-- Using self Join
Use sql_hr; -- whenever you change the database you need to mention it.
SELECT 
    e.employee_id, e.first_name, m.first_name manager
FROM
    employees e
        JOIN
    employees m ON e.reports_to = m.employee_id;
-- Using Mutiple Join
Use sql_store;
SELECT 
    o.order_id, o.order_date, c.first_name, os.name AS status
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        JOIN
    order_statuses os ON o.status = os.order_status_id;
    
Use sql_invoicing;
SELECT 
    p.date, p.invoice_id, p.amount, c.name, pm.name
FROM
    payments p
        JOIN
    clients c ON p.client_id = c.client_id
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id;
-- Using outer join
Use sql_store;
SELECT 
    *
FROM
    orders o
        RIGHT JOIN
    customers c ON o.customer_id = c.customer_id;

SELECT 
    *
FROM
    orders o
        LEFT JOIN
    customers c ON o.customer_id = c.customer_id;
    
-- Using compound join
 
SELECT 
    o.order_id,
    o.order_date,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        LEFT JOIN
    shippers sh ON o.shipper_id = sh.shipper_id
        JOIN
    order_statuses os ON o.status = os.order_status_id;
-- Use using clause instead of ON clause
SELECT 
    *
FROM
    orders o
        JOIN
    customers c USING (customer_id);

use sql_invoicing;
SELECT 
    p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM
    payments p
        JOIN
    clients c USING (client_id)
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id;

-- using natural join
Use sql_store;
SELECT 
    o.order_id, c.first_name
FROM
    orders o
        NATURAL JOIN
    customers c;
-- Using cross join
SELECT 
    c.first_name AS customer_name, p.name AS product
FROM
    customers c
        CROSS JOIN
    products p
ORDER BY c.first_name;

-- using Unions function
SELECT 
    order_id, order_date, 'Active' AS status
FROM
    orders
WHERE
    order_date >= '2019-01-01' 
UNION SELECT 
    order_id, order_date, 'Archieved' AS status
FROM
    orders
WHERE
    order_date <= '2019-01-01';

SELECT 
    customer_id, first_name AS name, points, 'bronze' AS Type
FROM
    customers
WHERE
    points < 2000 
UNION SELECT 
    customer_id, first_name AS name, points, 'silver' AS Type
FROM
    customers
WHERE
    points BETWEEN 2000 AND 3000 
UNION SELECT 
    customer_id, first_name AS name, points, 'Gold' AS Type
FROM
    customers
WHERE
    points > 3000
ORDER BY name;

-- Using Update and Delete Data
INSERT INTO customers
values (default, 'john', 'smith', '1990-01-01', NULL, 'address','LA','CA',1000);
CREATE TABLE order_archieved AS SELECT * FROM
    orders;

-- Using sub queries to insert data
INSERT INTO order_archieved
select *
from orders
where order_date < '2019-01-01';
use sql_invoicing;
CREATE TABLE invoice_archieved AS SELECT * FROM
    invoices;

use sql_invoicing;

    
--  Before Using upadate function disable safe mode in your mysql preference
UPDATE invoices 
SET 
    payment_date = '2022-01-04'
WHERE
    payment_date IS NULL;

Use sql_store;
UPDATE customers 
SET 
    points = points + 50
WHERE
    birth_date < '1990-01-01';

UPDATE orders 
SET 
    comments = 'Gold Customers'
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            customers
        WHERE
            points > 3000);

-- Using Delete function Be carefull
use sql_invoicing;
DELETE FROM invoices 
WHERE
    client_id = (SELECT 
        client_id
    FROM
        clients
    
    WHERE
        name = 'Myworks');

-- Now we are going to use different dataset for that you need to create a new table

-- First Create the table called employee
use mydb;
create table employee
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);
-- INSERT the values
insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);
COMMIT;
-- Using Basic aggregate function
select DEPT_NAME, max(SALARY) as Max_salary
from employee
GROUP BY DEPT_NAME;
-- Using window function
select *, 
max(salary) over(PARTITION BY DEPT_NAME) as max_salary
from employee;
select *, ROW_NUMBER() over(partition by DEPT_NAME ORDER BY emp_ID) AS RN
from employee ;

-- Fetch the data using subquery
select * from ( 
select *, ROW_NUMBER() over(partition by DEPT_NAME ORDER BY emp_ID) AS RN
from employee) em
where RN < 3;
-- Fetch the top 3 employees in each dept
select * from (
select *, rank() over(partition by DEPT_NAME ORDER BY salary desc) as rnk
from employee ) emr
where emr.rnk < 4;
-- Using lead() and Lag()  function
select *, 
lag(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) as pre_salary,
lead(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) as next_emp
from employee;
select *, 
lag(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) as pre_salary,
case when SALARY > lag(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) then "Higher"
	 when SALARY < lag(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) then "Lower"
     when SALARY = lag(salary,1,0) over(PARTITION BY Dept_Name order by emp_ID ) then "Same"
     end sal_range
from employee;
-- We are going to use remaining window functions
-- For that I am going to create another table called product
CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
COMMIT;

-- First value
-- To extract the most expensive products form each category
select *,
first_value (product_name) over(partition by product_category order by price desc)  as expensive
from product;
-- Last value for extracting least expensive products
select *,
first_value (product_name) over(partition by product_category order by price desc)  as expensive,
last_value (product_name) over(partition by product_category order by price DESc
range between unbounded PRECEDING and UNBOUNDED FOLLOWING )  as least_expensive
from product;
-- Using N th value function
-- Write the query to extract the second most expensive product
select *,
FIRST_VALUE (product_name) over w  as expensive,
last_value (product_name) over w as least,
nth_value (product_name, 2) over w as second_expensive
from product
 window w as (partition by product_category order by price desc
			  range between unbounded preceding and unbounded following);
-- Using Ntile function
-- write a query to segregate all the expensive phones, mid range phones and the cheaper phones.

select product_name,product_category,
case when x.buckets = 1 then "Expensive"
	 when x.buckets = 2 then "Medium"
     when x.buckets = 1 then "Cheapest" END Budget
from (
select *,
ntile(3) over(order by price desc) as buckets
from product) as x;
-- Usig cume_dist function
-- query to fetch all the products which are constituting the first 30%
-- of the data in products table based on price
/* Formula = (current row value / total row values) */
select product_name, cume_percentage
from (
select *,
CUME_DIST () over (order by price desc) as cume_distribution,
round(CUME_DIST () over (order by price desc) * 100,2) as cume_percentage
from product) x
where x.cume_percentage <= 30; 

-- using percent_rank function
-- Formula = current row -1 / total row - 1
select *, 
round(PERCENT_RANK() over(order by price)*100,2) percentage_rank
from product;










        

			





    

    


