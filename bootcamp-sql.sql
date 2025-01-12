create database bootcamp_2409p; -- 不可開同名的table
-- 上面行錯 下面就不會行

Use bootcamp_2409p;

-- you can write comments here
-- case incentive
-- name convention which differ to java (e.g. First_Name)
CREATE TABLE customers  (
	-- colums  
    -- java long = bigint
    ID integer,
    -- 10000個char
    First_Name varchar(100),
    Last_Name varchar(50),
    DOB date,
    Country varchar(2)
);

select * from customers;
-- Delete from  清空table

INSERT INTO CUSTOMERS (ID, FIRST_NAME, LAST_NAME, DOB, COUNTRY) 
	VALUES (1, 'VINCENT', 'LAU', '1900-12-01', 'HK');
INSERT INTO CUSTOMERS (ID, FIRST_NAME, LAST_NAME, DOB, COUNTRY) 
	VALUES (2, 'SALLY', 'WONG', '1910-06-30', 'HK');
INSERT INTO CUSTOMERS (ID, FIRST_NAME, LAST_NAME, DOB, COUNTRY) 
	VALUES (3, 'JEFFERY', 'LAU', '1910-12-31', 'US');
    
-- '*' means all columns as result
-- where is a conditional clause for filtering rows
-- select is for filerting columns from result set
-- between and is inclusive
Select * from customers where Last_Name = 'LAU';
Select First_Name, Country From Customers where country = 'HK';
Select * from  customers where DOB between '1910-01-01' and '1910-12-31'; 
Select * from  customers where DOB = '1910-06-30'; 
Select * from customers where Last_Name = 'Lau' and country = 'HK';
-- 要用() 優先次
SELECT * FROM CUSTOMERS WHERE (LAST_NAME = 'LAU' OR COUNTRY = 'HK') AND DOB >= '1910-01-01';

-- decimal(5,2) --> 2 stands for decimal places , 5 stands for total num of digit of integer + decimcal place
create table orders(
	ID integer,
    AMOUNT decimal(5,2),
    Order_Date date,
    Customers_ID integer
);

-- for insert, we can skip the column name. 
insert into Orders values (1 , 100.52, '1940-10-20', 2);
-- insert into Orders values (2 , 1200.99, '1939-12-31', 1); -- Out of range value for 'amount'
insert into Orders values (2 , 999.99, '1939-12-31', 1); 
insert into Orders values (1 , 100.52, '1940-10-20', 2);