create database bootcamp_2409p; -- 不可開同名的table
-- 上面行錯 下面就不會行

Use bootcamp_2409p;

drop table customers;
-- you can write comments here
-- case incentive
-- name convention which differ to java (e.g. First_Name)
CREATE TABLE customers  (
	-- colums  
    -- java long = bigint
    ID integer primary key, -- not null unique
    -- 10000個char
    First_Name varchar(100) not null,
    Last_Name varchar(50) not null,
    DOB date not null,
    Country varchar(2) not null
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

drop table orders;

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
-- insert into Orders values (4 ,  '1940-10-21', 4); (customer_id must unique) so error
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
Select count(*), count(1), count(first_name) 
 -- count reuslt的行數(不為null的行數) ,customers表中的HK有2 so count(*) =2
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

-- group by
select last_name,first_name, count(*)
from customers
Group by last_name, first_name; -- 按姓先排再排first_name

select last_name,first_name, count(*)
from customers
Group by last_name;  -- can do ,只是按XX分類,出什麼結果,但上面少下面多error

select last_name, count(*)
from customers
where first_name <> 'Vincent' -- excute before group by -- <> 淘汰
Group by last_name; 

-- group by + where
select last_name, count(*) as total
from customers
where first_name <> 'Vincent' 
Group by last_name  -- exxcute before order by
order by total;

-- count(), sum(), min(), max(), avg() -> represent a group state

-- group by + agg functions
select customer_id, count(1), sum(amount), max(amount),min(amount), avg(amount)
from orders
group by customer_id;

-- find the last login timestamp for all users
-- wait to check vincent code
select user_id, max(login_time)
from user_id
group by user_login;

-- find customer the earliest sign up every year
Create table users(
	user_id integer,
    sign_up_datetime datetime
);
insert into users values (1, '2023-01-10 19:23:59');
insert into users values (2, '2023-01-10 19:21:50');
insert into users values (3, '2023-02-11 02:23:50');
insert into users values (4, '2024-10-11 04:50:50');

-- ..
with R_table as (
select year(U.sign_up_datetime), min(U.sign_up_datetime) as earliest_sign_up_time -- 每年最小的sign_up_time
from users U
group by year(U.sign_up_datetime)
)
select U2.*   -- expected result = 成功成為的會員表
from R_table R inner join users U2 on R.earliest_sign_up_time = U2.sign_up_datetime;

-- group by + having
select last_name, count(1)
from customers
where first_name <> 'VINCENT' -- filter the records before group by
group by last_name
having length(last_name) < 4; -- filter the groups after group by -- 選擇留下的紅 
-- having -連group也不要

-- id: not null, unique
-- first_name & last_name: not null
-- DOB: not null
-- country: not null
select * from customers;

create table orders(
	ID integer primary key,
    AMOUNT decimal(5,2) not null,
    Order_Date date not null,
    customer_id integer,
    foreign key (customer_id) references customers(ID)
);

-- for insert, we can skip the column name, but you have to assign all columns value at once 
insert into Orders values (1 , 100.52, '1940-10-20', 2);
-- insert into Orders values (2 , 1200.99, '1939-12-31', 1); -- Out of range value for 'amount'
insert into Orders values (2 , 999.99, '1939-12-31', 1); 
insert into Orders values (3 , 0.99, '1910-12-31', 3);
insert into Orders values (4, 999.99, '1940-10-21', 1);

select * from orders;

-- insert into orders values(5, 123.31, '1941-10-21' , 4);
-- error , as there is no customer id 4 in customers

select * from customers where last_naem in ('Lau', 'Wong');

-- find customer with orders after 1940-10-21
select *
from customers c
where exists (select 1 from orders o where o.customer_id = c.id and o.order_date >= '1940-10-21'); 
-- 有就show XX

-- not exists
-- find customer without orders
INSERT INTO CUSTOMERS (ID, FIRST_NAME, LAST_NAME, DOB, COUNTRY) 
	VALUES (4, 'cherry', 'chan', '1900-12-01', 'US');
    
select *
from customers c
where not exists (select 1 from orders o where o.customer_id = c.id);  -- output: cherry chan


CREATE TABLE Adopters (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    age INT
);
CREATE TABLE Cats (
    id INT PRIMARY KEY,
    breed VARCHAR(20),
    adopter_id INT, -- by default, FK allows null value
    FOREIGN KEY (adopter_id) REFERENCES Adopters (id)
);

create table donations (
	id int primary key,
	Amount decimal(10,2) not null,
    adopter_id int,
    FOREIGN KEY (adopter_id) REFERENCES Adopters (id)  -- foregin key一定要出現在refernec table, but can null
);


    

INSERT INTO Adopters (id, name, age)
VALUES
    (1, 'Cherry', 30),
    (2, 'Steve', 22),
    (3, 'Cindy', 18);
INSERT INTO Cats (id, breed, adopter_id)
VALUES
    (1, 'persion', 2),
    (2, 'rogdoll', 1),
    (3, 'persion', null),
    (4, 'sphynx', 1);

INSERT INTO donations
VALUES
    (1, 100.9, 2),
    (2, 2500, 3), -- int 可入decmial ,but decmial 不可寫入int
    (3, 999.99, 3);
    


-- inner join
select *
from adopters a inner join cats c on a.id = c.adopter_id -- data source
where a.age >= 30;

-- find adopters who had adopted cats and with donation record
select a.name, c.breed, d.amount
from adopters a inner join cats c on a.id = c.adopter_id -- data source
inner join donations d on a.id = d.adopter_id;


-- left join with interect
select * 
from adopters a  left join cats c on a.id = c.adopter_id ;  -- if no give on XX 即X x Y  but -> no meaning

select * 
from adopters a  left join cats c on a.id = c.adopter_id
left join donations d on a.id = d.adopter_id ;

-- 一定有損錢,但可以無領養cat
select * 
from adopters a  left join cats c on a.id = c.adopter_id
inner join donations d on a.id = d.adopter_id ; 

-- left join without interect e.g.入左學但未reg科
select * 
from adopters a  left join cats c on a.id = c.adopter_id 
where c.adopter_id is null;

-- right join with interect
select * 
from adopters a right join cats c on a.id = c.adopter_id;    

-- right join without interect
select * 
from adopters a right join cats c on a.id = c.adopter_id
where a.id is null;

-- right to left
select *
from cats c left join adopters a on a.id = c.adopter_id;
select *
from cats c left join adopters a on a.id = c.adopter_id
where a.id is null;


-- uniion
select a.id, a.name
from adopters a
where a.age >= 30
union  -- 合併數據(上下合併), 但上下select數要一致
select c.id, c.breed
from cats c
where c.adopter_id is not null; 

-- union all 
select a.id
from adopters a
where a.age >= 30
union  all  -- 重複的話也照show
select c.id
from cats c
where c.adopter_id is not null; 
