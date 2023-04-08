--Table for customers created
create table customer(
firstname varchar(20) not null,
lastname varchar(20) not null,
email varchar(50) not null,
company VARCHAR(60) NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR(2) NOT NULL DEFAULT 'PA',
Postcode TEXT NOT NULL,
contactNum VARCHAR(20) NOT NULL,
birth_date DATE NULL,
sex CHAR(1) NOT NULL,
date_entered TIMESTAMP NOT NULL,
is_disabled Varchar(10) null,
id SERIAL PRIMARY KEY
);

--Adding Data to cusmtomer table,just a random data
INSERT INTO customer (firstname, lastname, email, company, street, city, state, postcode, contactNum, birth_date, sex, date_entered, is_disabled)
VALUES 
('John', 'Doe', 'johndoe@example.com', 'ABC Inc.', '123 Main St', 'New York', 'NY', '10001', '555-1234', '1980-01-01', 'M', '2022-01-15'::date, NULL),
('Jane', 'Smith', 'janesmith@example.com', NULL, '456 Elm St', 'Los Angeles', 'CA', '90001', '555-5678', '1990-05-15', 'F', '2022-02-01'::date, 'Yes'),
('Bob', 'Johnson', 'bobjohnson@example.com', 'XYZ Corp.', '789 Maple St', 'Chicago', 'IL', '60601', '555-9876', '1975-12-31', 'M', '2022-03-15'::date, NULL),
('Alice', 'Lee', 'alicelee@example.com', NULL, '101 Oak St', 'San Francisco', 'CA', '94101', '555-2468', '1988-09-23', 'F', '2022-04-01'::date, NULL);

--creates a custom data type named gender with two possible values: 'M','F','others'
CREATE TYPE gender as enum
('M', 'F','others');

alter table customer
alter column sex type  gender USING sex::gender;

--creating table for the sales personel
CREATE TABLE sales_personel(
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(60) NOT NULL,
street VARCHAR(50) NOT NULL,
city VARCHAR(40) NOT NULL,
state CHAR(2) NOT NULL DEFAULT 'PA',
Postcode TEXT NOT NULL,
phone VARCHAR(20) NOT NULL,
birth_date DATE NULL,
sex gender NOT NULL,
date_hired TIMESTAMP NOT NULL,
is_disabled Varchar(10) null,
id SERIAL PRIMARY KEY
);

--Constructing the Watch About Tables
--	The wrist watch names will be Formal,Casual and sport
CREATE TABLE product_type(
name VARCHAR(30) NOT NULL,
id SERIAL PRIMARY KEY);

-- creating table product and using a foreign key  product_type(id)
CREATE TABLE product(
type_id INTEGER REFERENCES product_type(id),
name VARCHAR(30) NOT NULL,
supplier VARCHAR(30) NOT NULL,
description TEXT NOT NULL,
id SERIAL PRIMARY KEY);

---select * from product;
--create product item and using a foreign key product(id)
CREATE TABLE item(
product_id INTEGER REFERENCES product(id),
size INTEGER NOT NULL,
color VARCHAR(30) NOT NULL,
picture VARCHAR(256) NOT NULL,
price NUMERIC(6,2) NOT NULL,
id SERIAL PRIMARY KEY);

---select * from item;

--order information
CREATE TABLE sales_order(
cust_id INTEGER REFERENCES customer(id),
sales_person_id INTEGER REFERENCES sales_personel(id),
time_order_taken TIMESTAMP NOT NULL,
purchase_order_number INTEGER NOT NULL,
credit_card_number VARCHAR(16) NOT NULL,
credit_card_exper_month SMALLINT NOT NULL,
credit_card_exper_day SMALLINT NOT NULL,
credit_card_secret_code SMALLINT NOT NULL,
name_on_card VARCHAR(100) NOT NULL,
id SERIAL PRIMARY KEY
);

Select * from sales_order;
--table sales item
CREATE TABLE sales_item(
item_id INTEGER REFERENCES item(id),
sales_order_id INTEGER REFERENCES sales_order(id),
quantity INTEGER NOT NULL,
discount NUMERIC(3,2) NULL DEFAULT 0,
taxable BOOLEAN NOT NULL DEFAULT FALSE,
sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
id SERIAL PRIMARY KEY
);


--Inserting Data into product_type
INSERT INTO product_type (name) VALUES ('Formal');
INSERT INTO product_type (name) VALUES ('Casual');
INSERT INTO product_type (name) VALUES ('sport');
--Inserting Data into product
INSERT INTO product VALUES
(1, 'Datejust', 'Rolex', 'classic design with a date window at the 3 clock position, a stainless steel or precious metal case'),
(1, 'Day-Date', 'Rolex', 'precious metal case and bracelet,water-resistant and have a scratch-resistant sapphire crystal.'),
(1, 'Tank ', 'Cartier', 'rectangular case and a clean, including stainless steel gold and platinum.'),
(1, 'Seamaster', 'Omega', 'exceptional water resistance and durability, available in a range of materials'),
(1, 'Speedmaster', 'Omega', 'first watch to be worn on the moon,tachymeter bezel and is highly accurate and reliable'),
(2, 'GMT', 'Mezlan', 'stainless steel case and a leather strap,  second time zone display'),
(2, 'Seamaster Aqua Terra', 'Omega', 'he Aqua Terra watches are water-resistant up to 150 meters '),
(3, 'Aquaracer', 'TAG Heuer', 'unidirectional rotating bezel and luminescent markers for improved visibility in low-light conditions'),
(3, 'Carrera', 'TAG Heuer', ' chronograph watches that are designed for motorsports enthusiasts'),
(2, 'Link', 'TAG Heuer', 'designed for everyday wear, some models have diamond-set bezels for added elegance'),
(3, 'Aviator', 'Breitling', 'The watches feature a chronograph function, and some models have a slide rule bezel that can be used for flight calculations'),
(3, 'Superocean', 'Breitling', 'water-resistant up to 1,000 meters and feature a unidirectional rotating'),
(3, 'Colt', 'Breitling', 'ynamic lifestyles and features a sleek and modern design');

select * from product;

--change state data type from char 2 to char varying
ALTER TABLE customer
ALTER COLUMN state TYPE varchar(10);
-- insert into customer table
INSERT INTO customer (firstname, lastname, email, company, street, city, state, postcode, contactNum, birth_date, sex, date_entered, is_disabled)
VALUES 
('William', 'Smith', 'william.smith@example.com', NULL, '23 Abbey Road', 'London', 'ENG', 'NW8 9AY', '+44 20 7123 1234', '1985-03-14', 'M', '2022-04-07 12:34:56', NULL),
('Sophie', 'Taylor', 'sophie.taylor@example.com', NULL, '12 Oxford Street', 'Cambridge', 'ENG', 'CB2 1TN', '+44 1223 123456', '1991-06-02', 'F', '2022-04-07 13:12:34', NULL),
('Oliver', 'Johnson', 'oliver.johnson@example.com', 'ACME Ltd.', '45 High Street', 'Manchester', 'ENG', 'M1 1AA', '+44 161 123 4567', '1978-11-19', 'M', '2022-04-07 14:56:23', 'Yes'),
('Emma', 'Wilson', 'emma.wilson@example.com', NULL, '67 Park Lane', 'Birmingham', 'ENG', 'B1 1AA', '+44 121 123 4567', '1989-08-05', 'F', '2022-04-07 15:43:21', NULL),
('Alexander', 'Brown', 'alexander.brown@example.com', 'XYZ Corp.', '89 Regent Street', 'Edinburgh', 'SCT', 'EH1 3AA', '+44 131 123 4567', '1972-05-31', 'M', '2022-04-07 16:32:10', NULL),
('Charlotte', 'Jones', 'charlotte.jones@example.com', NULL, '34 Market Street', 'Belfast', 'NIR', 'BT1 1AA', '+44 28 1234 5678', '1983-09-22', 'F', '2022-04-07 17:21:09', 'No'),
('James', 'Wilson', 'james.wilson@example.com', 'ABC Inc.', '56 Baker Street', 'London', 'ENG', 'W1U 7EU', '+44 20 7123 4567', '1975-12-31', 'M', '2022-04-07 18:09:58', NULL),
('Emily', 'Taylor', 'emily.taylor@example.com', NULL, '78 George Street', 'Edinburgh', 'SCT', 'EH2 3BU', '+44 131 123 4567', '1996-02-28', 'F', '2022-04-07 19:54:47', NULL),
('David', 'Anderson', 'david.anderson@example.com', 'LMN Corp.', '90 High Street', 'Glasgow', 'SCT', 'G1 1AA', '+44 141 123 4567', '1981-07-15', 'M', '2022-04-07 20:42:36', NULL),
('Isabella', 'Wilson', 'isabella.wilson@example.com', NULL, '12 Victoria Street', 'Belfast', 'NIR', 'BT1 4QG','+44 141 103 4567', '1941-07-15', 'F', '2022-03-03 20:22:36', 'Yes');

-- insert into sales person
ALTER TABLE sales_personel
ALTER COLUMN state TYPE varchar(10);
INSERT INTO sales_personel (first_name, last_name, email, street, city, state, postcode, phone, birth_date, sex, date_hired,is_disabled)  
VALUES 
('Alice', 'Smith', 'alice.smith@example.com', '123 Main St', 'London', 'ENG', 'EC2A 1NT', '+44 20 123 4567', '1990-05-15', 'F', '2022-01-01', NULL),
('Bob', 'Jones', 'bob.jones@example.com', '456 Elm St', 'Manchester', 'ENG', 'M1 4HT', '+44 161 123 4567', '1975-12-31', 'others', '2022-01-01', NULL),
('Charlie', 'Brown', 'charlie.brown@example.com', '789 Maple St', 'Birmingham', 'ENG', 'B1 1BB', '+44 121 123 4567', '1988-09-23', 'M', '2022-01-01', NULL),
('Daisy', 'Taylor', 'daisy.taylor@example.com', '101 Oak St', 'Glasgow', 'ENG', 'G1 1AA', '+44 141 123 4567', '1985-06-10', 'others', '2022-01-01', NULL);

--Insert into table Items
INSERT INTO item (product_id, size, color, picture, price)
VALUES 
(1, 40, 'Silver', 'https://example.com/silver-watch.jpg', 99.99),
(1, 42, 'Gold', 'https://example.com/gold-watch.jpg', 149.99),
(2, 38, 'Black', 'https://example.com/black-watch.jpg', 79.99),
(2, 40, 'Silver', 'https://example.com/silver-watch-2.jpg', 89.99),
(3, 42, 'Rose Gold', 'https://example.com/rose-gold-watch.jpg', 199.99),
(3, 38, 'Black', 'https://example.com/black-watch-2.jpg', 99.99),
(4, 40, 'Silver', 'https://example.com/silver-watch-3.jpg', 69.99),
(4, 42, 'Gold', 'https://example.com/gold-watch-2.jpg', 129.99),
(5, 38, 'Rose Gold', 'https://example.com/rose-gold-watch-2.jpg', 149.99),
(5, 40, 'Black', 'https://example.com/black-watch-3.jpg', 79.99),
(1, 38, 'Black', 'https://example.com/images/watch_black_38.jpg', 79.99),
(1, 40, 'White', 'https://example.com/images/watch_white_40.jpg', 89.99),
(2, 42, 'Gold', 'https://example.com/images/watch_gold_42.jpg', 99.99),
(2, 38, 'Silver', 'https://example.com/images/watch_silver_38.jpg', 89.99),
(3, 40, 'Red', 'https://example.com/images/watch_red_40.jpg', 69.99),
(3, 42, 'Blue', 'https://example.com/images/watch_blue_42.jpg', 79.99),
(4, 38, 'Rose Gold', 'https://example.com/images/watch_rose_gold_38.jpg', 119.99),
(4, 40, 'Brown', 'https://example.com/images/watch_brown_40.jpg', 89.99),
(5, 42, 'Green', 'https://example.com/images/watch_green_42.jpg', 99.99),
(5, 38, 'Purple', 'https://example.com/images/watch_purple_38.jpg', 79.99),
(1, 38, 'Black', 'https://example.com/images/watch_black_38.jpg', 79.99),
(1, 42, 'Silver', 'https://example.com/images/watch_silver_42.jpg', 99.99),
(2, 38, 'Gold', 'https://example.com/images/watch_gold_38.jpg', 89.99),
(2, 40, 'Blue', 'https://example.com/images/watch_blue_40.jpg', 79.99),
(3, 42, 'Rose Gold', 'https://example.com/images/watch_rose_gold_42.jpg', 119.99),
(3, 38, 'Green', 'https://example.com/images/watch_green_38.jpg', 69.99),
(4, 40, 'White', 'https://example.com/images/watch_white_40.jpg', 89.99),
(4, 42, 'Brown', 'https://example.com/images/watch_brown_42.jpg', 99.99),
(5, 38, 'Purple', 'https://example.com/images/watch_purple_38.jpg', 79.99),
(5, 40, 'Red', 'https://example.com/images/watch_red_40.jpg', 69.99);

-- lets see items
select * from item;
--Insert into Sales Order

INSERT INTO sales_order
VALUES 
(1, 2, '2023-04-07 10:30:00', 12345, '1234567890123456', 12, 24, 123, 'John Doe'),
(3, 1, '2023-04-07 11:30:00', 67890, '2345678901234567', 11, 25, 456, 'Jane Smith'),
(2, 3, '2023-04-07 12:30:00', 24680, '3456789012345678', 10, 26, 789, 'Bob Johnson'),
(4, 2, '2023-04-07 13:30:00', 13579, '4567890123456789', 9, 27, 234, 'Sarah Lee'),
(5, 1, '2023-04-07 14:30:00', 86420, '5678901234567890', 8, 28, 567, 'David Chen'),
(6, 3, '2023-04-07 15:30:00', 97531, '6789012345678901', 7, 29, 890, 'Lisa Kim'),
(7, 2, '2023-04-07 16:30:00', 11111, '7890123456789012', 6, 30, 123, 'Mike Davis'),
(8, 1, '2023-04-07 17:30:00', 22222, '8901234567890123', 5, 31, 456, 'Emily Wang'),
(9, 3, '2023-04-07 18:30:00', 33333, '9012345678901234', 4, 1, 789, 'Tom Brown'),
(10, 2, '2023-04-07 19:30:00', 44444, '0123456789012345', 3, 2, 234, 'Mary Lee'),
(1, 3, '2023-04-07 10:00:00', 1001, '1234567890123456', 12, 25, 123, 'John Doe'),
    (2, 1, '2023-04-07 11:00:00', 1002, '2345678901234567', 10, 24, 456, 'Jane Smith'),
    (3, 2, '2023-04-07 12:00:00', 1003, '3456789012345678', 11, 23, 789, 'Bob Johnson'),
    (4, 3, '2023-04-07 13:00:00', 1004, '4567890123456789', 9, 22, 234, 'Mary Williams'),
    (5, 1, '2023-04-07 14:00:00', 1005, '5678901234567890', 8, 21, 567, 'David Lee'),
    (1, 2, '2023-04-07 15:00:00', 1006, '6789012345678901', 7, 20, 890, 'Emily Chen'),
    (2, 3, '2023-04-07 16:00:00', 1007, '7890123456789012', 6, 19, 123, 'Tom Brown'),
    (3, 1, '2023-04-07 17:00:00', 1008, '8901234567890123', 5, 18, 456, 'Amy Green'),
    (4, 2, '2023-04-07 18:00:00', 1009, '9012345678901234', 4, 17, 789, 'Mike Taylor'),
    (5, 3, '2023-04-07 19:00:00', 1010, '0123456789012345', 3, 16, 234, 'Sara Kim'),
	(1, 3, '2023-04-01 10:00:00', 1001, '1234567890123456', 12, 24, 123, 'John Doe'),
  (2, 4, '2023-04-02 11:00:00', 1002, '2345678901234567', 8, 25, 456, 'Jane Smith'),
  (3, 3, '2023-04-03 12:00:00', 1003, '3456789012345678', 3, 26, 789, 'Bob Johnson'),
  (4, 4, '2023-04-04 13:00:00', 1004, '4567890123456789', 6, 27, 234, 'Emily Davis'),
  (5, 4, '2023-04-05 14:00:00', 1005, '5678901234567890', 10, 28, 567, 'Chris Brown'),
  (6, 3, '2023-04-06 15:00:00', 1006, '6789012345678901', 11, 29, 890, 'Anna Lee'),
  (7, 4, '2023-04-07 16:00:00', 1007, '7890123456789012', 7, 30, 123, 'David Kim'),
  (8, 4, '2023-04-08 17:00:00', 1008, '8901234567890123', 9, 31, 456, 'Michelle Lee'),
  (9, 3, '2023-04-09 18:00:00', 1009, '9012345678901234', 2, 22, 789, 'Mike Brown'),
  (10, 4, '2023-04-10 19:00:00', 1010, '0123456789012345', 5, 23, 234, 'Sara Davis');


--Insert Sales Item
INSERT INTO sales_item
VALUES 
(24, 121, 2, 0.11, false, 0.0), 
(8, 122, 2, 0.16, false, 0.0), 
(24, 123, 2, 0.06, false, 0.0), 
(4, 124, 2, 0.13, false, 0.0), 
(26, 125, 2, 0.13, false, 0.0), 
(19, 126, 1, 0.19, false, 0.0), 
(23, 127, 1, 0.13, false, 0.0), 
(18, 128, 2, 0.15, false, 0.0), 
(30, 129, 2, 0.06, false, 0.0), 
(1, 130, 2, 0.18, false, 0.0), 
(28, 131, 2, 0.12, false, 0.0), 
(5, 132, 2, 0.07, false, 0.0), 
(29, 133, 1, 0.15, false, 0.0), 
(15, 134, 2, 0.13, false, 0.0), 
(27, 135, 2, 0.07, false, 0.0), 
(30, 136, 1, 0.05, false, 0.0), 
(5, 137, 1, 0.09, false, 0.0), 
(1, 138, 1, 0.18, false, 0.0), 
(2, 139, 1, 0.13, false, 0.0), 
(7, 140, 1, 0.09, false, 0.0), 
(23, 141, 2, 0.16, false, 0.0), 
(4, 142, 2, 0.18, false, 0.0), 
(5, 143, 2, 0.12, false, 0.0), 
(24, 144, 1, 0.08, false, 0.0), 
(11, 145, 1, 0.14, false, 0.0), 
(21, 146, 2, 0.14, false, 0.0), 
(21, 147, 2, 0.06, false, 0.0),
(24, 146, 2, 0.11, false, 0.0),
(8, 147, 2, 0.16, false, 0.0),
(24, 150, 2, 0.06, false, 0.0),
(14, 129, 2, 0.13, false, 0.0),
(26, 137, 2, 0.13, false, 0.0),
(19, 122, 1, 0.19, false, 0.0),
(23, 128, 1, 0.13, false, 0.0),
(8, 121, 2, 0.15, false, 0.0),
(30, 148, 2, 0.06, false, 0.0),
(1, 130, 2, 0.18, false, 0.0),
(18, 124, 2, 0.12, false, 0.0),
(25, 133, 2, 0.07, false, 0.0),
(29, 149, 1, 0.15, false, 0.0),
(15, 142, 2, 0.13, false, 0.0),
(27, 125, 2, 0.07, false, 0.0),
(30, 131, 1, 0.05, false, 0.0),
(25, 138, 1, 0.09, false, 0.0),
(21, 126, 1, 0.18, false, 0.0),
(12, 135, 1, 0.13, false, 0.0),
(27, 143, 1, 0.09, false, 0.0),
(23, 145, 2, 0.16, false, 0.0),
(14, 123, 2, 0.18, false, 0.0),
(25, 127, 2, 0.12, false, 0.0),
(24, 144, 1, 0.08, false, 0.0),
(11, 136, 1, 0.14, false, 0.0),
(21, 141, 2, 0.14, false, 0.0),
(21, 132, 2, 0.06, false, 0.0),
(8, 149, 145, 0.16, false, 0.0),
(24, 140, 126, 0.06, false, 0.0),
(14, 141, 126, 0.13, false, 0.0),
(26, 139, 125, 0.13, false, 0.0),
(19, 139, 146, 0.19, false, 0.0),
(23, 141, 149, 0.13, false, 0.0),
(18, 145, 145, 0.15, false, 0.0),
(30, 150, 131, 0.06, false, 0.0),
(1, 146, 142, 0.18, false, 0.0),
(28, 136, 127, 0.12, false, 0.0),
(25, 145, 128, 0.07, false, 0.0),
(29, 139, 129, 0.15, false, 0.0),
(15, 139, 124, 0.13, false, 0.0),
(27, 141, 128, 0.07, false, 0.0),
(30, 137, 136, 0.05, false, 0.0),
(15, 149, 139, 0.09, false, 0.0),
(11, 138, 145, 0.18, false, 0.0),
(30, 137, 145, 0.13, false, 0.0),
(17, 150, 130, 0.09, false, 0.0),
(23, 140, 123, 0.16, false, 0.0),
(24, 142, 140, 0.18, false, 0.0),
(25, 149, 125, 0.12, false, 0.0),
(24, 143, 133, 0.08, false, 0.0),
(11, 138, 145, 0.14, false, 0.0),
(21, 144, 130, 0.14, false, 0.0),
(21, 146, 127, 0.06, false, 0.0);


SELECT * FROM sales_item;
--checking for sales item(wrist watch) where the discount is greater than 0.12
SELECT * FROM sales_item WHERE discount > 0.12;
--order-by
SELECT * FROM sales_item WHERE discount > .12 ORDER BY discount DESC;
--order by limit
SELECT * FROM sales_item WHERE discount > .12 ORDER BY discount DESC LIMIT 5;


-- using logical operators
-- find 
SELECT * FROM sales_order;
SELECT time_order_taken
FROM sales_order
WHERE time_order_taken > '2023-04-07' AND time_order_taken < '2023-04-10';
 
 
--using CONCAT 
SELECT * FROM customer;
SELECT CONCAT(firstname,  ' ', lastname) AS Name, contactnum, state FROM customer WHERE city = 'Belfast';

--Get the total value of all sport writwatch in inventory.

-- GROUP BY
SELECT * FROM item;
SELECT product_id, SUM(price) AS Total FROM item WHERE product_id=1  GROUP BY product_id;
-- using distint
--get a list of state in customer
SELECT DISTINCT state
FROM customer
ORDER BY state;


--Identify all states where we have customers, except for the state of 'SCT'.
SELECT DISTINCT state
FROM customer
WHERE state != 'SCT'
ORDER BY state;
--The "IN" keyword can be utilized to check if a value is present in a given list. Please retrieve the states of customers that are included in my list. Alternatively, you can also use "NOT IN".
SELECT DISTINCT state
FROM customer
WHERE state IN ('ENG', 'SCT')
ORDER BY state;


--Retrieving data from multiple tables.
--with either inner joins, outer joins, or unions

SELECT item_id, price
FROM item INNER JOIN sales_item
ON item.id = sales_item.item_id
ORDER BY item_id;

SELECT item_id, price
FROM item INNER JOIN sales_item
ON item.id = sales_item.item_id
AND price > 100.00
ORDER BY item_id;
--To retrieve the orders, quantity, and the total sale, let's perform a join on three tables.
SELECT sales_order.id, sales_item.quantity, item.price, 
(sales_item.quantity * item.price) AS Total
FROM sales_order
JOIN sales_item
ON sales_item.sales_order_id = sales_order.id
JOIN item
ON item.id = sales_item.item_id
ORDER BY sales_order.id;
--Join with Where
SELECT item_id, price
FROM item, sales_item
WHERE item.id = sales_item.item_id
AND price > 120.00
ORDER BY item_id;
--LEFT JOIN
SELECT name, supplier, price
FROM product LEFT JOIN item
ON item.product_id = product.id
ORDER BY name;

--uppose we intend to send birthday cards to all customers,salespersons who have their birthdays in April. Here's how we can achieve that. Please note that the "Order By" statement should always come at the end, and the column names are derived from the first select statement. To extract only the month from the birth date, we can use the "Extract" function.
error

SELECT firstname, lastname, street, city, postcode, birth_date
FROM customer
WHERE EXTRACT(MONTH FROM birth_date) = 2
ORDER BY birth_date;


SELECT first_name, last_name, street, city, postcode, birth_date
FROM sales_personel
WHERE EXTRACT(MONTH FROM birth_date) = 12
ORDER BY birth_date;

select * from CUSTOMER;

Null is used when a value is not known. IS NULL can be used to search for potential problems.
Search for items with NULL prices
--NULL
SELECT product_id, price
FROM item
WHERE price = NULL;

--We will utilize the GROUP BY clause to obtain a singular row for every distinct value. This will allow us to determine the number of customers who have their birthdays in specific day.
SELECT EXTRACT(DAY FROM birth_date) AS Day, COUNT(*) AS Amount
FROM customer
GROUP BY Day
ORDER BY Day;

--Get count, sum, min, max and average value of our items
SELECT COUNT(*) AS Items, 
SUM(price) AS Value, 
ROUND(AVG(price), 2) AS Avg,
MIN(price) AS Min,
MAX(price) AS Max
FROM item;

--views
--Views are essentially the outcome of select statements that have been saved and stored within your database.
CREATE VIEW purchase_order_overview AS
SELECT sales_order.purchase_order_number, customer.company, 
sales_item.quantity, product.supplier, product.name, item.price, 
--Can’t use total if you want this to be updated Fix Below
(sales_item.quantity * item.price) AS Total,
--Remove concat if you want this to be updatable 
CONCAT(sales_personel.first_name, ' ', sales_personel.last_name) AS Salesperson
FROM sales_order     -- Join some tables
JOIN sales_item
ON sales_item.sales_order_id = sales_order.id    -- Tables go together by joining on sales order id
-- Any time you join tables you need to find foreign and primary keys that match up
JOIN item
ON item.id = sales_item.item_id    -- Join item as well using matching item id
JOIN customer
ON sales_order.cust_id = customer.id    -- Join customer using customer ids
JOIN product
ON product.id = item.product_id
JOIN sales_personel
ON sales_personel.id = sales_order.sales_person_id
ORDER BY purchase_order_number;
--When data in the database is updated so is the view. You can use the view in all the same ways you can a regular table. If you want it to be updatable though it can’t include DISTINCT, UNION, Aggregate Functions, GROUP BY or HAVING.
 
SELECT * FROM purchase_order_overview;


INSERT INTO sales_personel (first_name, last_name, email, street, city, state, postcode, phone, birth_date, sex, date_hired,is_disabled)  
VALUES 
('rrlice', 'cat', 'rrlice.smith@example.com', '123 Main St', 'London', 'null', 'EC2A 1NT', '+44 20 123 4567', '1990-05-15', 'F', '2022-01-01', NULL),
('rob', 'dish', 'rob.jones@example.com', '456 Elm St', 'Manchester', 'null', 'M1 4HT', '+44 161 123 4567', '1975-12-31', 'others', '2022-01-01', NULL);



--set sales_personel  to not null
ALTER TABLE sales_personel ALTER COLUMN state DROP NOT NULL;
--update id(6) of sales personel to NULL
UPDATE sales_personel
SET state = NULL
WHERE id IN (5,6);

SELECT * FROM sales_personel;

--FUNCTIONS
-- I USED function to change null to liv

CREATE OR REPLACE FUNCTION fn_update_employee_state() 
RETURNS void as
$body$
	UPDATE sales_personel
	SET state = 'LIV'
	WHERE state is null
$body$
LANGUAGE SQL



SELECT fn_update_employee_state();

SELECT * FROM sales_personel;


--Get Maximum Product Price
CREATE OR REPLACE FUNCTION fn_max_product_price() 
RETURNS numeric as
$body$
	SELECT MAX(price)
	FROM item
$body$
LANGUAGE SQL

SELECT fn_max_product_price();


--Get Total Value of Inventory
CREATE OR REPLACE FUNCTION fn_get_value_inventory() 
RETURNS numeric as
$body$
	SELECT SUM(price)
	FROM item;	
$body$
LANGUAGE SQL

SELECT fn_get_value_inventory();

--Get Number of Customers

CREATE OR REPLACE FUNCTION fn_number_customers() 
RETURNS numeric as
$body$
	SELECT count(*)
	FROM customer;	
$body$
LANGUAGE SQL

SELECT fn_number_customers();

--Get Number of Customers with No contactnum
CREATE OR REPLACE FUNCTION fn_number_customers_no_phone() 
RETURNS numeric as
$body$
	SELECT count(*)
	FROM customer
	WHERE contactnum is NULL;	
$body$
LANGUAGE SQL

SELECT fn_number_customers_no_phone();



--Check if sales_person has a state assigned and if not change it to ‘PA’
CREATE OR REPLACE FUNCTION fn_update_employee_state() 
RETURNS void as
$body$
	UPDATE sales_personel
	SET state = 'ENG'
	WHERE state is null
$body$
LANGUAGE SQL

select * from sales_personel;