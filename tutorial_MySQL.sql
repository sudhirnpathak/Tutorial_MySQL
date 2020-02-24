-- SQL is not a case sensitive language, but as a best practice we capitalize the SQL keywords
-- create-databases.sql : The main database we will be using in this Mosh’s tutorial. 
-- This file contains all the sql codes to create all the databases that are there in this course.
-- Other individual files are provided if we want to create these individual databases in future.

-- ---------------------- SELECT -----------------------

-- Lets discuss how to retrieve data from a single table

USE sql_store;      -- The database to use for query. It will be highlighted in the navigator panel

SELECT *                           -- returns all the columns from the customers table
FROM customers;

SELECT first_name, last_name     -- returns columns first_name & last_name from the customers table
FROM customers;                  -- columns are returned in order specified in the select statement

SELECT last_name, first_name       -- order is reversed from the previous statment
FROM customers;

SELECT last_name, first_name, points, points + 10           -- mathematical operations on columns
FROM customers;                                             -- operations such as +, -, *, /, %

SELECT
    last_name,
    first_name,                               -- slightly more complicated math operations
    points,                                   -- assigning a name to the column using AS keyword
    (points + 10) * 100 AS discount_amount    -- to get column-name, separated by space        
FROM customers;                               -- we enclose in a string: 'discount amount'
											  
SELECT product_id FROM order_items;          -- no columns with same element in customers table
SELECT DISTINCT product_id FROM order_items; -- returns only distinct elements from product_id column 


-- --------------------- WHERE ----------------------------------------- 

-- We can use the where clause as a conditional statement to filter data 

USE sql_store;

SELECT first_name, last_name, points
FROM customers
WHERE points > 3000;             -- using where clause to select customers who satisfy the criteria

-- comparison operators we can use in sql are --
-- >			greater than
-- <			less than
-- >=			greater than or equal to
-- <=			less than or equal to
-- =			equal to
-- != or <>		not equal to

SELECT first_name, last_name, state
FROM customers
WHERE state = 'VA';                          -- select only those customers whose state is Virginia

SELECT first_name, last_name, state
FROM customers
WHERE state != 'va';                         -- case independent : VA/va both works same

SELECT first_name, last_name, birth_date
FROM customers                         -- MySQL has a datatype 'date' , with format YEAR-MONTH-DATE
WHERE birth_date > '1990-01-01';       -- customers born after Jan 1, 1990

SELECT first_name, last_name, points*2
FROM customers
WHERE points*2 < 2000;                 -- we can use mathematical operations in where clause

SELECT first_name, last_name, customer_id, points
FROM customers
WHERE customer_id * points < 2000;                 -- we can use mathematical operations on columns


-- ---------------------- AND, OR and NOT Operators ----------

-- We can combine multiple search conditions in filtering data

SELECT first_name, last_name, birth_date, points
FROM customers                                               -- customers born after Jan 1, 1990
WHERE birth_date > '1990-01-01' AND points >= 1000;          -- and have more than 1000 points

SELECT first_name, last_name, birth_date, points             -- AND has higher precedence than OR
FROM customers                                               -- we can control it using parenthesis 	
WHERE birth_date > '1990-01-01' OR points >= 1000 AND state = 'VA';

SELECT first_name, last_name, birth_date
FROM customers                                         -- using NOT operator
WHERE NOT birth_date > '1990-01-01';                   -- returns customers born before Jan 1, 1990


-- ------------------- IN Operator ---------------------

SELECT first_name, last_name, state
FROM customers                           -- returns customers who are either in VA, or GA, or FL
WHERE state IN ('VA', 'GA', 'FL');       -- IN: to avoid writing statments combined by OR condition

SELECT first_name, last_name, state
FROM customers
WHERE state NOT IN ('VA', 'GA', 'FL');   -- returns customers from states other than VA, GA and FL

-- To conclude, we use IN Operator when we have to compare an attribute with a list of values


-- ------------------- BETWEEN Operator -------------------

SELECT first_name, last_name, points
FROM customers                       -- customers with points between 1000-3000 (both inclusive)
WHERE points BETWEEN 1000 AND 3000;  -- better replacement for: points >= 1000 AND points <= 3000

SELECT first_name, last_name, birth_date
FROM customers                            -- customers born between Jan 1, 1990 and Jan 1, 2000
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'; 


-- ------------------- LIKE Operator --------------------

-- Let's see how to retrieve rows that match a specific string pattern

SELECT first_name, last_name         -- returns all customers whose last name starts with b
FROM customers                       -- % is the wild card character here, meaning anything after b						
WHERE last_name LIKE 'b%';           -- string is not case sensitive, we can use b% or B%	

SELECT first_name, last_name
FROM customers
WHERE last_name LIKE '%b%';          -- returns customers who have 'b' anywhere in their last name

SELECT first_name, last_name
FROM customers
WHERE last_name NOT LIKE '%b%';      -- returns customers, with no character b in their last name

SELECT first_name, address
FROM customers               -- returns customers whose address contains either 'trail' or 'avenue'
WHERE address LIKE '%trail%' OR address LIKE '%avenue%';		

SELECT first_name, last_name        -- returns customers who's last_name has exactly 6 characters 
FROM customers                      -- can be anything at first 5 but must be y in the end
WHERE last_name LIKE '_____y';      -- we are using 5 underscores here, 

SELECT first_name, last_name        -- returns customers with last name exactly 6 characters long
FROM customers                      -- starting with b and ending with y
WHERE last_name LIKE 'b____y';      -- 4 underscores here

-- To conclude, % represents any number of characters, and an underscore (_) represents a single character


-- ------------------ REGEXP Operator ---------------------------

-- REGEXP (Regular expression) are very powerful operators when it comes to searching for strings

SELECT first_name, last_name
FROM customers
WHERE last_name REGEXP 'field';	  -- returns customers who have 'field' anywhere in their last name

SELECT first_name, last_name
FROM customers                          -- ^ means beginning of the string
WHERE last_name REGEXP '^field';        -- returns customers whose last name starts with 'field'

SELECT first_name, last_name
FROM customers							  -- $ means end of the string
WHERE last_name REGEXP 'field$';          -- returns customers whose last_name ends with 'field'

SELECT first_name, last_name          -- we can also search for multiple words: | represents OR
FROM customers                        -- customers who have field or mac or rose in their last_name
WHERE last_name REGEXP 'field|mac|rose';

SELECT first_name, last_name
FROM customers                               -- customers whose last_name either starts with field,
WHERE last_name REGEXP '^field|mac|rose';    -- or contains mac or rose	

SELECT first_name, last_name
FROM customers                                  -- customers whose last_name either ends with field
WHERE last_name REGEXP 'field$|mac|rose';       -- or contains mac or rose

SELECT first_name, last_name
FROM customers                                 -- returns customers whose last_name contains either
WHERE last_name REGEXP '[gim]e';               -- ge, or ie, or me

SELECT first_name, last_name
FROM customers                                 -- returns customers whose last_name contains either
WHERE last_name REGEXP 'o[aes]';               -- oa, or oe, or os

SELECT first_name, last_name
FROM customers                          -- returns customers whose last name contains anything from
WHERE last_name REGEXP '[a-h]e';        -- ae, be, ......ge, he


-- ----------------- IS NULL Operator -------------------

-- Let's see how to get records with missing values

SELECT first_name, last_name
FROM customers
WHERE phone IS NULL;                   -- returns customers whose phone column entry is NULL

SELECT first_name, last_name
FROM customers
WHERE phone IS NOT NULL;       -- returns customers who have their phone number in the phone column


-- ----------------- ORDER BY -----------------------

-- In relational databases, every table has a primary key column
-- The values in primary key column must uniquely identify the records in the table
-- In customer table, customer_id is the primary key column
-- When we write a query, customers are sorted by customer_id by default
-- Let's see how we can sort the queries by different columns

SELECT *
FROM customers;                      -- returns customers sorted by customer_id

SELECT *
FROM customers
ORDER BY first_name;                 -- returns customers sorted alphabetically by their first_name

SELECT *
FROM customers
ORDER BY first_name DESC;     -- returns customers sorted reverse-alphabetically by their first_name

SELECT *                         -- we can use multiple columns for sorting
FROM customers                   -- returns customers first sorted by their state 
ORDER BY state, first_name;      -- and within state by their first name

SELECT *
FROM customers                          -- sorts customers by state first (descending order),
ORDER BY state DESC, first_name;        -- and within state by first_name (ascending order)

SELECT first_name, last_name            -- Some SQL implementation only allow sorting by columns,
FROM customers                          -- that are selected by SELECT
ORDER BY birth_date;                    -- However, in MySQL we can sort by any column 

SELECT *
FROM order_items
WHERE order_id = 2                       -- using ORDER BY over mathematical combination of columns
ORDER BY quantity * unit_price DESC;     -- orderded by total price in descending order

SELECT *, quantity * unit_price AS total_price		-- for clarity we output total_price
FROM order_items
WHERE order_id = 2									
ORDER BY quantity * unit_price DESC;				

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2                -- once we have defined the total_price alias				
ORDER BY total_price DESC;        -- we can use this alias in ORDER BY


-- ------------------------ LIMIT Clause -----------------------

-- Let's see how to limit number of records returned from a query

SELECT customer_id, first_name
FROM customers
LIMIT 3;                                        -- returns 3 records

SELECT customer_id, first_name, last_name
FROM customers
LIMIT 6, 3;                            -- returns 3 records, after skipping first 6 (called offset)

SELECT first_name, last_name, points
FROM customers
ORDER BY points DESC
LIMIT 3;                       -- the three most loyal customers, decided by the points accumulated

-- SQL keywords should come in order : SELECT, FROM, WHERE, ORDER BY, LIMIT. Otherwise SQL will complain.


-- -------------------- INNER JOIN --------------------

-- So far, we have only selected columns from a single table
-- In real world, we often select columns from many tables
-- Let's see how we do this

-- orders table : we are using customer_id to identify the customer who has placed the order
-- customers record like phone number, address are not stored in this table
-- this is because, a customer might have placed multiple orders
-- it makes it difficult to go to each record and change, when the customer changes her particulars
-- that's why we have separate tables for customers and orders

-- lets' see how to select orders in the orders table
-- but instead of showing customer_id, we show the full name of each customer

SELECT *
FROM orders									  		
INNER JOIN customers       -- combinining columns from orders-table to columns from customers-table
	ON orders.customer_id = customers.customer_id;  -- criteria to join the columns from two tables

-- we obtain columns of orders table first, followed by columns of customers table
-- instead of writing INNER JOIN, we can just use JOIN : it is understood to be INNER JOIN

SELECT order_id, first_name, last_name              
FROM orders
INNER JOIN customers                                  -- selects order_id from orders-table and
	ON orders.customer_id = customers.customer_id;    -- first_name, last_name from customers table

SELECT order_id, customer_id              
FROM orders
INNER JOIN customers                                    -- this wont run, as sql is ambiguous,
	ON orders.customer_id = customers.customer_id;      -- customer_id is in both tables

SELECT order_id, orders.customer_id        -- so we have to prefix with either orders. or customers.
FROM orders                                -- both works same, due to the ON condition
INNER JOIN customers
	ON orders.customer_id = customers.customer_id;

SELECT order_id, o.customer_id, first_name			
FROM orders o                    -- using aliases for the tables name as they appear at many places
INNER JOIN customers c                
	ON o.customer_id = c.customer_id; -- once we have used aliases, we can not use the original name
    

-- ------------------ JOINING ACROSS DATABASES -----------------

-- Let's see how to combine columns from tables across multiple databases
-- Let's join order_items table in sql_store database with products table in sql_inventory database

SELECT *
FROM order_items o
INNER JOIN sql_inventory.products p      -- prefixing sql_inventory as we are in sql_store database
	ON o.product_id = p.product_id;

SELECT *
FROM sql_store.order_items o      -- we are prefixing sql_store as we are in sql_inventory database
INNER JOIN products p             -- we have to prefix only tables that are not in current database
	ON o.product_id = p.product_id;


-- ----------------------- SELF JOINS -------------------------

-- In SQL, we can also join a table with itself 

-- Let's consider an example: 
-- consider employees table in sql_hr database, which contains various information about employees

-- Let's focus on two columns : 
-- employee_id (to identify the employee) and reports_to (to whom the employee reports, manager)

-- As an example, Darcy whose employee_id is 33391 reports to her manager Yovonnda (37270)
-- Yovonnda does not report to anyone (NULL value), so possibly she is CEO

-- If we want to write a query where we want the names of employee and their manager, 
-- we will have to use self-join
-- This is because both employee and manager are in the same table

SELECT e.employee_id, e.first_name, m.first_name 
FROM employees e   -- we use the same table with two aliases
JOIN employees m   -- we join report_to id of employees table e to employee_id in employees table m	
	ON e.reports_to = m.employee_id;

SELECT e.employee_id, e.first_name as Employee, m.first_name as Manager
FROM employees e    -- since we are selecting name from same column, we can use aliases for clarity
JOIN employees m
	ON e.reports_to = m.employee_id; 
    
-- Thus, joining a table with itself is pretty much same as joining a table with other tables
-- The only difference is that we have to use different aliases and prefix each column with a alias


-- ----------------------- Joining Multiple Tables ------------------------------

-- Let' see how to join more than two tables when writing a query

-- Let's look at the orders table in the sql_store database
-- We know how to join this table with the customers table to return customer particulars
-- We have a column 'status' in orders table but its description is not in this table. 
-- It is in order_statuses table
-- status is an integer number to identify the status of the order : processed, shipped, delivered

-- Let's write a query to join the orders table with, customers table and order_statuses table

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name as 'order status'
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id        -- joining orders table with the customers table
JOIN order_statuses os
	ON o.status = os.order_status_id;       -- joining orders table with the order_statuses table


-- ----------------------- Compound Join Condition --------------------

-- So far, we use a single column to uniquely identify the rows in a given table
-- For example, customer_id uniquely identifies the rows in the customers table

-- Sometimes, we can not use a single column to uniquely identify records in a given table
-- Such a situation can be seen for order_times: 
-- there is no column with unique values, duplicate values in order_id, product_id

-- Thus, in this table, to uniquely identify each order item,
-- we use the combination of values in two columns order_id, product_id

-- In the design mode, we can see that there are yellow icons on two keys, order_id, product id
-- This is called composite primary key : a composite primary key contains more than one column

-- Let's see how we join a table with composite primary key with other tables
-- Consider the table order_item_notes which we use to keep notes for each order item : 
-- here note_id uniquely identifies record of this table
-- Let's see how to join this table with order_items table
-- Remember that order_id & product_id combination uniquely identifies a row in order_items table

SELECT *
FROM order_items oi
JOIN order_item_notes oin
    ON oi.order_id = oin.order_id        -- compound join : joining using more than one condition
    AND oi.product_id = oin.product_id;  -- we join the two tables on these two conditions
    

-- ----------------------- Implicit Join Syntax -----------------------

SELECT order_id, first_name, last_name  -- this is a pretty basic join operation between two tables
FROM orders o                           -- this is for reference only
JOIN customers c                        -- we can write this query using implicit join syntax
	ON o.customer_id = c.customer_id;
    
SELECT order_id, first_name, last_name      -- implicit join syntax version of previous query
FROM orders o, customers c                  -- we mention both tables here
WHERE o.customer_id = c.customer_id;        -- condition has been implemented using where condition

-- It is recommended not to use implicit join syntax
-- If we miss the where condition, query is still valid and will give cross join (discussed later)
-- In the explicite join syntax (first query), if we don't mention the ON condition, SQL give errors


-- -------------------------- OUTER JOIN --------------------

-- To remind again, whenever we mention JOIN, it means INNER JOIN
-- SQL has another join, OUTER JOIN. Let's discuss why we need this outer join

-- Let's first write a query with inner join and then we convert that into outer join

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;                         -- we order the query by customer_id for clarity

-- There is something missing in above query
-- In query result, we have only those customers who have order in system: customer id 2,5,6,7,8,10
-- We can see in our customers table that we have other customers, (customer_id 1,3....)
-- Currently, we do not have orders from these customers, so we do not see them in query result

-- The reason we only saw customers who have an order is because of JOIN condition (ON condition)
-- The query returned only those customers for whom c.customer_id = o.customer_id is satisfied
-- This criteria is not satisfied for customers whose customer_id is not there in orders-table 

-- What if we want to see all the customers, whether they have an order or not
-- For this purpose we use outer join
-- In SQL, we have two outer joins : LEFT JOIN and RIGHT JOIN
-- When we use the LEFT JOIN, all the records from the left table,
-- (in this case, customers) are returned, whether the ON condition is true or not
-- So, we get all the customers. If they have an order, we will see the order_id, otherwise NULL

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
                                                
-- If we use the right join, all the orders from the right table (in this case, orders) 
-- will be returned, whether the ON condition is true or not

-- JOIN = INNER JOIN
-- LEFT JOIN = LEFT OUTER JOIN
-- RIGHT JOIN = RIGHT OUTER JOIN
-- These commands are same : we use the one on the left for simplicity


-- -------------------------- Outer Joins Between Many Tables -------------------------

-- Similar to inner joins, we can use outer joins between multiple tables

SELECT c.customer_id, c.first_name, o.order_id, sh.name as shipper_name
FROM customers c
LEFT JOIN orders o                                -- a left join between customers and orders table
	ON c.customer_id = o.customer_id
JOIN shippers sh                                  -- inner join orders table with the shippers table
	ON o.shipper_id = sh.shipper_id               -- shipper_id is the joining condition
ORDER BY c.customer_id;

-- This returns only those orders with a shipper_id
-- The orders with shipper_id = NULL does not satisfy the shipper_id matching criteria and 
-- wont be returned as this is an Inner join

-- If we want all the orders, whether they have a valid shipper_id or not, 
-- we replace inner join by a left outer join 

SELECT c.customer_id, c.first_name, o.order_id, sh.name as shipper_name
FROM customers c
LEFT JOIN orders o									
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh                               -- a left join to return all customers
	ON o.shipper_id = sh.shipper_id						
ORDER BY c.customer_id;

-- It is recommeded to use left joins, as mixing left & right joins makes code hard to understand
-- Whatever we want to achieve by using right join, can be obtained by using 
-- left join and swapping the position of tables


-- --------------------- Self Outer Joins ---------------------

-- Let's continue with the example of self inner join where we queried for employees & their manager
-- both of whom are in the same table
-- we go to sql_hr database for this example

SELECT e.employee_id, e.first_name as Employee, m.first_name as Manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id; -- same query we wrote while discussing self inner join

-- We can see that all employees have the same manager
-- However, there is something missing here.
-- We do not have a record for the manager itself : manager reports to NULL, 
-- and the ON condition is not satisfied with NULL value
-- To see manager's id, name, and that she reports to NULL, we will have to use OUTER JOIN

SELECT e.employee_id, e.first_name as Employee, m.first_name as Manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;
    

-- ------------------------ The USING Clause -----------------------

-- Let's get back to sql_store database

-- Consider this simple query where we join the orders table with the customers table

SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c                            -- we have the same column name in both tables
    ON o.customer_id = c.customer_id;       -- in such cases, we can use USING 

SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c
	USING(customer_id);   -- makes the code easier to read: can do only when column name is same

SELECT o.order_id, c.first_name, sh.name AS shipper
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);	    -- USING works for outer joins too !

-- The USING method only works when column name is exactly same across the tables

-- Let's see how it works with composite keys : when we use multiple conditions to join tables

SELECT *
FROM order_items oi
JOIN order_item_notes oin
    ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;                -- checking both conditions

SELECT *
FROM order_items oi
JOIN order_item_notes oin
    USING(order_id, product_id);                       -- simplifying the previous query with USING
    
    
-- ----------------------- Natural Joins --------------------

-- In MySQL, we have a simpler way to join tables, called Natural Joins, and is easier to code
-- It is not recommended to use Natural Joins, as sometimes it produces unexpected results    
    
SELECT o.order_id, c.first_name     -- with Natural Join, we do not explicitly specify column names
FROM orders o      -- the database engine looks at two tables and join them based on common columns
NATURAL JOIN customers c;                -- common columns means columns with the exactly same name
    
-- Natural Joins are really easy to code, but they can be little bit dangerous
-- As we are letting the db engine to figure out or guess the join, we do not have control over it
-- For this reason, Natural joins can produce unexpected results, and one is discouraged to use it


-- ------------------------ Cross Joins ----------------------

-- We use cross join to join every record from the first table with every record from the second table

SELECT c.first_name AS customer, p.name AS product        -- explicit cross join
FROM customers c                 -- joining every record from the customers table to products table
CROSS JOIN products p            -- so we do not need a condition here 
ORDER BY c.first_name;           -- we sort the result by customer's first name

SELECT c.first_name AS customer, p.name AS product   -- implicit cross join
FROM customers c, products p                         -- we just mention two tables together
ORDER BY c.first_name;                               -- this query is equivalent to the above query


-- ------------------------- Unions ----------------------------

-- We learnt that using joins, we can combine columns from multiple tables 
-- In SQL, we can also join rows from multiple tables : this is extremely powerful operation

SELECT order_id, order_date
FROM orders;							

-- We can see that the first order (order_id 1) was placed in current year 2019, 
-- while all others were placed in previous years

-- Say we want to create a report, where we want all the orders,
-- and label each order as 'active' if it is placed in 2019, otherwise 'archived'

SELECT order_id, order_date
FROM orders
WHERE order_date >= '2019-01-01';                   -- returns orders which are active

SELECT order_id, order_date, 'Active' AS status     -- In the above query, we put a label 'Active'
FROM orders                                     -- It puts the label 'Active' for all returned rows
WHERE order_date >= '2019-01-01';               -- We use status as the column name

SELECT order_id, order_date, 'Archived' AS status   -- Similar to above query, we can write a query 
FROM orders                                         -- to return orders placed in previous years
WHERE order_date < '2019-01-01';                    -- We use the label 'Archived' for these orders

-- We can combine the records returned by these two queries,
-- labeled 'Active' and 'Archived', using Union operator:

SELECT order_id, order_date, 'Active' AS status		
FROM orders                                         -- query returning the active records
WHERE order_date >= '2019-01-01'									
UNION                                               -- Union operator to join the two queries
SELECT order_id, order_date, 'Archived' AS status		 
FROM orders                                         -- query returning the archived records
WHERE order_date < '2019-01-01';						

-- Thus, using Union, we can combine records from multiple queries
-- In this example, both our queries are against the same table
-- We can also do queries against different tables, then combine their results into one result set

-- NOTE : Both queries, which we intend to combine with Union, must have same number of columns
-- For example, if one query returns 2 columns and the other returns 3 columns, 
-- SQL does not know how to combine these two query results
-- We can use Union multiple times : 2 unions to join 3 query results


-- ------------------------------- Column Attributes ------------------------

-- Before we discuss how to insert, update and delete, lets discuss about the column attributes

-- VARCHAR (variable character) vs CHAR (character):
-- Let's look at the customers table in design mode : We see that first_name is of type VARCHAR(50)

-- So, the first_name can be up to of 50 characters
-- The good thing with VARCHAR is that, if our name is of 5 characters, it assigns 5 spaces only, 
-- and does not waste another 45 spaces

-- On the other hand, if our first_name is of CHAR type, and our name is of 5 characters,
-- it assigns all 50 spaces to the name
-- Thus, as a best practice, we store string/text as VARCHAR type

-- Another column is AI (auto increment) : This is often used with primary_key column
-- Every time we insert a new record in table, we let database engine insert a value in AI column
-- Essentially, it gets the customer_id for the last row, and increment it by 1

-- For example, last value of customer_id is 10. 
-- When we add a new customer, MySQL will assign 11 to the new customer


-- ---------------------- Inserting a Single Row ---------------------------

-- Let's see how to insert a row into a table

INSERT INTO customers            -- we insert the row into the customers table 
VALUES (                         -- in parenthesis, we supply values for every column of this table
    DEFAULT,
    'John',                  -- varchar/char we enclose in quotes, single or double
    'Smith',
    '1990-01-01',            -- date also we enclose in quotes
    NULL,           -- columns where NN (NOT NULL) box is not checked, we can assign NULL value
    'address',
    'city',
    'CA',
    DEFAULT         -- with DEFAULT, the default value provided in the Default/Expression
    );              -- column of the design mode is assigned			

-- DEFAULT keyword lets SQL decide the customer_id on this new row, if AI is on. 
-- This is the preferred way.
-- If we provided a customer_id by ourself, it is possible that this customer_id already exists. 
-- SQL will give error, as duplicate values for primary_key are not allowed

-- Since we are passing values for six columns only, leaving out the three, 
-- we can equivalently write a query as:

INSERT INTO customers
    (first_name,
    last_name,
    birth_date,
    address,        -- It is not required to write columns in the order as it is in customers table
    city,           -- we just have to make sure that they are consistent across name - values
    state)
VALUES (
    'John',
    'Smith',
    '1990-01-01',
    'address',
    'city',
    'CA'
    );

SELECT * FROM customers;			-- let's check the table for the rows we inserted


-- ------------------------ Inserting Multiple Rows ---------------------

-- Let's see how to insert multiple rows in one go

INSERT INTO shippers
    (name)           -- we insert into name column only, as shipper_id column is primary key column
VALUES               -- and will automatically be taken care of
    ('Shipper1'),
    ('Shipper2'),
    ('Shipper3');       -- we add three rows in one go

SELECT * FROM shippers;


-- ------------------------- Inserting Hierarchical Rows -------------------

-- So far we have only learnt how to insert data into a single table
-- let's see how to insert data into multiple tables

-- Look at the orders table 
-- We have order_id, cutomer_id : So we know who has placed the order
-- We also know order_date, status of the order, comments, shipped_date, shipper_id
-- However, the actual items for this order are not in this table. They are in order_items table 
-- In order_items table we have order_id : So, we know for what order this item is for 
-- We have product_id, quantity and unit_price: So we know what product has been ordered, 
-- and what quantity, and at what price

-- So, an actual order can have one or more items
-- This is called parent - child relationship : Here, orders table is the parent, and order_items table is the child
-- So, one row in the orders table can have one or more children inside the order_items table
-- Let's see how to insert an order, and all its items 

INSERT INTO orders(
    customer_id,
    order_date,
    status)                     -- we insert our order here 
VALUES(
    1,
    '2019-01-02',
    1);                         -- we have to enter a valid customer_id and valid status id

INSERT INTO order_items              -- Now we need to insert our items 
VALUES                               -- In the order_items table, we have order_id column
    (LAST_INSERT_ID(), 1, 1, 2.95),  -- As we insert an order, an id is generated for our new order
    (LAST_INSERT_ID(), 2, 1, 3.95);     

-- Now we need to be able to access that id in order to insert the items in this table
-- MySQL has the builtin function, LAST_INSERT_ID
-- This returns the id which MySQL generates when we insert a new row 
-- we can use that id to insert the child records


-- ------------------------ Creating a Copy of a Table -----------------------

-- Let's see how to copy data from one table to another 
-- Let's create a copy of orders table, named orders_archived
-- we want to insert every row we have in orders table into orders_archived table

CREATE TABLE orders_archived AS      -- first we create the orders_archived table
SELECT * FROM orders;                -- then we insert everything from orders table into this table

-- Executing this we have a new table orders_archived, 
-- with all the rows and columns that are in orders table

-- However, there are two important differences: 
-- we have no primary key and AI is not ticked for this new table (check in design mode)

-- This SELECT statement here is referred as a subquery 
-- A subquery is a SELECT statement that is part of another SQL statement 

-- We can also use a subquery in an insert statement : this is a very powerful technique

-- Let's say we want to copy only a subset of records from orders table into orders_archived table:
-- say all the orders placed before 2019

-- Lets truncate the orders_archived table to clear the table

INSERT INTO orders_archived    -- an example of using SELECT as a subquery into an INSERT statement
SELECT *     -- select all records satisfying WHERE condition, then INSERT them into orders_archived
FROM orders  -- as we insert all columns, we dont need to mention column names in INSERT statement
WHERE order_date < '2019-01-01';

-- Let's move to sql_invoicing database for another cool subquery example
-- In the invoices table, we have client_id which is associated to client_id in clients table

-- Say we want to create a copy of records of this table and 
-- put them in a new table called invoices_archived

-- However, in the new table, instead of client_id column, we want to have client name column
-- So we need to join the invoices table with the clients table, 
-- and used that query as a subquery in CREATE TABLE statement

-- Also, to make this exercise more interesting, we only include records that do have a payment 
-- (these records have a payment data, not NULL)

CREATE TABLE invoices_archived AS
SELECT                                 -- this query is a subquery to the create table statment
    i.invoice_id,
    i.number,
    c.name as Client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
    USING (client_id)                           -- joining condition
WHERE payment_date IS NOT NULL;                 -- selecting records for whom payment has been made


-- ----------------------------- Updating a Single Row -------------------------

UPDATE invoices                                              -- update record in invoices table
SET payment_total = 10, payment_date = '2019-03-01'          -- the columns to update
WHERE invoice_id = 1;                                        -- the record to update

-- Let's say we updated the wrong record. So lets restore the previous record

UPDATE invoices            -- DEFAULT assigns the default value assigned for that particular column
SET payment_total = DEFAULT, payment_date = NULL   
WHERE invoice_id = 1;      -- NULL can be used for columns for which NN is not checked								

-- Now, let's update the record invoice_id = 3

UPDATE invoices
SET
    payment_total = invoice_total*0.5,   -- using mathematical expression on columns
    payment_date = due_date              -- client paid on the due_date
WHERE invoice_id = 3;                    -- payment_date will be update to whatever the due_date is


-- ----------------------------- Updating Multiple Rows ---------------------------

-- Syntax is exactly the same for updating multiple records, 
-- just that the where clause needs to be more general 

-- In the invoices table, we can see multiple records for client_id = 3
-- We can write a statement to update all the invoices for this client 

UPDATE invoices                         -- Executing this query with MySQL workbench will give error
SET                                     -- Because, by default MySQL workbench runs in safe mode
    payment_total = invoice_total*0.5,  -- Updating only one record is allowed: specific to MySQL
    payment_date = due_date             -- Protects from accidently deleting/updating many records
WHERE client_id = 3;     -- Change: MySQLWorkbench > Preferences > SQL_Editor > Uncheck Safe Updates

UPDATE invoices
SET
    payment_total = invoice_total*0.5,
    payment_date = due_date             -- All the operators we learnt with WHERE clause works here
WHERE client_id IN (3, 5);              -- Using IN clause to update client_id = 3 and 5

-- If we leave the WHERE clause, all the records will get updated


-- ---------------------- Using Subqueries in Updates --------------------

-- Let's see how to use subquery in an update statement
-- We updated the records of client_id = 3 in previous examples
-- What if we know the name of the client, and not client_id : How to update the table in this case 

-- Imagine that we have an application, and user enters the name of the client
-- In this case, we can use subquery to find the client_id of the client using the name, 
-- and then use the client_id to update the invoices table

UPDATE invoices
SET
    payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id = 
    (SELECT client_id              -- MySQL will first execute this subquery to get the client_id
    FROM clients                   -- And then uses this client_id to update the invoices table
    WHERE name = 'Myworks');

-- What if the subquery returns multiple clients ? 
-- As a more complex example, lets say we want to update the invoices of all clients located in NY & CA

UPDATE invoices
SET
    payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN                 -- we use IN operator as the subquery returns multiple client_id
    (SELECT client_id
    FROM clients
    WHERE state IN ('CA', 'NY'));
            
-- Best practice: run the subquery first & check the results, before running the whole update query
-- We can avoid accidently updating the records that we do not intend to update 

SELECT client_id         -- running the subquery first to check whether it gives the desired result
FROM clients             -- then only, we should plug this in the update query
WHERE state IN ('CA', 'NY');


-- --------------------------- Deleting Rows -------------------------

-- Now, lets see how to delete data from a table

DELETE FROM invoices         -- use just this one line, it will delete all the records in the table
WHERE invoice_id = 1;        -- using where clause we just delete invoice_id = 1 record

DELETE FROM invoices
WHERE client_id =                    -- using subquery to get the client_id we would like to delete
    (SELECT client_id
    FROM clients
    WHERE name = 'Myworks');