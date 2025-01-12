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

-- for insert, we can skip the column name, but you have to assign all columns value at once 
insert into Orders values (1 , 100.52, '1940-10-20', 2);
-- insert into Orders values (2 , 1200.99, '1939-12-31', 1); -- Out of range value for 'amount'
insert into Orders values (2 , 999.99, '1939-12-31', 1); 
insert into Orders values (3 , 0.99, '1910-12-31', 3);
alter table Orders change Customers_ID Customer_ID integer; -- ALTER TABLE (tableName) CHANGE (oldcolname) (newcolname) datatype(length);
INSERT INTO Orders (ID, Order_Date, Customer_ID) values (4, '1940-10-21', 1);
-- insert into Orders values (4 ,  '1940-10-21', 4);
-- update statement also support where, and or >= <= > <
-- set more than one column at once.
update orders set amount = 999.99 where ID = 4;


select * from orders;

-- join (two tables)
-- why do we need join?
-- question: 3 x 4 =12

-- * means all columns in 2 tables
select * from customers inner join orders;

-- 1.Final data set (Join 2 data sources)
-- 2.Find country = HK and order_date range
-- 3. show which columns
select C.ID, C.First_Name, C.Last_Name, O.AMOUNT, O.Order_Date, C.Country
from Customers C inner join Orders O on C.ID = O.customer_ID -- C , O 網名 
where C.Country = 'HK'
and o.order_date between '1940-10-01' and '1940-12-31';
-- 在C表的XX... O表的XX.. find XX = 'HK' & date=.. ,finally show C.id....


-- concat
select concat(Q.First_Name, ' ', Q.Last_Name) as Full_Name, Q.* from Customers Q;
select concat(Q.First_Name, '__', Q.Last_Name) as New_Full_Name, Q.ID from Customers Q; 
select concat(AAA.First_Name, '__', AAA.Last_Name) as New_Full_Name, AAA.ID from Customers AAA; 
-- substring (From positiion to position)
select Substring(C.Last_Name, 1, 1) as Initial, C.* from Customers C;
-- length, upper,lower,trim
select length(Q.First_Name), Lower(Last_Name), Upper('testing'), trim(' HE LLO') from Customer C;
-- Left,right
select left(C.First_Name, 1), right(C.First_Name, 1), replace(C.Last_Name, 'Lau', 'Chan') From Customer C;
-- Chinese 香港alter
select length('香港'), char_length('香港'), length('AB'), char_length('HK') from Customers; -- DB用3個字去識一個中文字
-- instr ,if target string is not found, instr() return 0.
select instr(C.First_Name, 'V') From Customers C;

-- case insensitive 
-- oracle, postgreSQL, SQL server - case-sensitive
select * from customers where first_name = 'vincent';
select * from customers where first_name = 'Vincent';

-- widcard %
select * from customers where first_name like '%SA%';
select * from customers where first_name like 'V%';  -- V字開頭
select * from customers where first_name like '%LY';
select * from customers where first_name like 'V%T';

-- widcard _
select * from orders where order_date like '1940-10-__';
select * from orders where order_date like '1940-10-%';

-- Maths Operation
select round(Amount, 1) as rounded_amount from orders; -- 小數位後X個 4捨5入

-- similar to java Round.half_up
-- ceil() similar to java round_up
-- floor() similar to java round_down
select round(10.44,1) ,round(10.45,1),ceil(4.1),floor(4.9), abs(-4.4), power(2,3) from dual; -- ceil-小數後X >0就入 floor-ceil相反
-- abs 絕對值=此值為正數
-- power(2,3) =2的3次方 2x2x2 
-- dual =開虛擬表
select round(10.44+0.9,1) ,round(10.45,1),ceil(4.1),floor(4.9), abs(-500+1) from dual;

-- datediff, the date difference between two dates.
select date_add(order_date, interval 3 month) ,
date_add(order_date, interval 10 day),
date_sub(order_date, interval 1 year),
date_sub(order_date, interval 3 month),
datediff(order_date, '1940-01-01')  from orders;

select date_add(order_date, interval 3 month) as date_add_3month,
date_add(order_date, interval 10 day) as date_add_10day ,
date_sub(order_date, interval 1 year),
date_sub(order_date, interval 3 month),
datediff(order_date, '1940-01-01')  from orders;


select now() from dual;

select now() as '現在的時間' from dual;

-- sql ver. if
select
	case
		when C.DOB >= '1910-01-01' then 'P'
        when C.DOB >= '1900-01-01' then 'F'
        else 'N/A'
	end as label, -- label = P F 's row
    C.*
from customers C
where C.country = 'HK';

-- Hard code value for all rows
select C.*, 1 as one, 'hello' from customers C;

-- count() is used to count number of rows
Select count(*), count(1), count(first_name)  -- count reuslt的行數(不為null的行數) ,customers表中的HK有2 so count(*) =2
 From customers
 where country = 'HK';
 -- count(1) 在表中開多一個row是 1 然後下面的row都是1 即select C.*, 1 as one, 'hello' from customers C;
 
 select count(null), count(*) from customers where country = 'HK'; -- output:count(null) = 0

-- aggregation functions
-- find total amount of all orders
select sum(amount) from orders;

select avg(amount) from orders;
select min(amount) from orders;
select max(amount) from orders;

select count(1), sum(AMOUNT), AVG(AMOUNT), MIN(AMOUNT), MAX(AMOUNT) from Orders; -- 不可在from前加ID...