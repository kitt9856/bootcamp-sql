create database ExerciseOne;

use ExerciseOne;

create table regions (
	region_id integer primary key,
    region_name varchar(25)
);

-- delete from regions;

insert into regions values (852, 'Hong Kong');
insert into regions values (861, 'Shen Zhen');
insert into regions values (44, 'London');
insert into regions values (886, 'Taipei');
insert into regions values (886, 'Taipei');
insert into regions values (81, 'Tokyo');
-- select * from regions;

-- drop table locations;


create table counties (
	country_id char(2) primary key,
    country_name varchar(40),
    region_id integer,
    foreign key (region_id) references regions(region_id)
);

insert into counties values ('CH', 'China', 861);
insert into counties values ('TW', 'TaiWan', 886);
insert into counties values ('UK', 'U.K.', 44);
insert into counties values ('JP', 'Japan', 81);
-- select * from counties;

create table locations (
	location_id integer primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    foreign key (country_id) references counties (country_id)
);
-- delete from locations;
insert into locations  values( 1001, 'Kowloon Park' , 'TST123-123', 'Tsim Sha tsui', 'KowloonTST', 'CH');
insert into locations  values( 1002, 'Kowloon Bay Mall',  'KBY123-123', 'Kowloon Bay', 'KowloonKBY', 'CH');
insert into locations  values( 1003, 'Mong Kok Street', 'MKK100-100', 'Mong Kok', 'KowloonKMKK' , 'TW');
insert into locations  values( 1004, 'Big Center', 'BCE012-100', 'London', 'U.K.LDO' , 'UK');
insert into locations  values( 1005, 'Fuij Hill', 'FUH230-900', 'Fuij', 'JP Fuij' , 'JP');
-- select * from locations;

create table departments (
	department_id integer primary key,
    department_name varchar(30),
    manager_id integer,
    location_id integer,
    foreign key (location_id) references locations (location_id)
);

insert into departments values (115, 'IT', 1, 1004);
insert into departments values (106, 'Marketing', 2, 1002);
insert into departments values (101, 'Sales', 3, 1003);
insert into departments values (100, 'Management', 8802, 1004);
insert into departments values (120, 'Purhasing', 7, 1005);
-- select * from departments;

-- drop table jods;
create table jobs (
	job_id varchar(10) primary key,
    job_title varchar(35),
    min_salary decimal(8,2),
    max_salary decimal(8,2)
);

insert into jobs (job_id, job_title, min_salary, max_salary) 
	values ('KBOF001', 'CEO assistant', 20000.00, 21000.00 );
insert into jobs (job_id, job_title, min_salary, max_salary) 
	values ('KBOF002', 'IT guy', 19000.00, 28000.00 );
insert into jobs (job_id, job_title, min_salary, max_salary) 
	values ('BCFE001', 'Store Manager', 25000.00, 28000.00 );
insert into jobs (job_id, job_title, min_salary, max_salary) 
	values ('KPSU001', 'Park Cleaner', 8000.00, 8300.00 );
insert into jobs (job_id, job_title, min_salary, max_salary) 
	values ('KBOS001', 'CEO', 10000.00, 15000.00 );
-- select * from jobs;

 drop table employees;
create table employees (
	employee_id integer primary key,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10),
    foreign key (job_id) references jobs (job_id),
    salary decimal(8,2),
    commission_pct decimal(8,2),
    manager_id integer references departments (manager_id),
    department_id integer,
    foreign key (department_id) references departments (department_id)
);
 


-- delete value employees;

insert into employees values (8801, 'Peter', 'Cheng', 'peter@gmail.com' , 
	'9999-1234', '2001-01-02', 'KBOF002', 20000.00, 10,1, 115);
insert into employees values (8802, 'PK', 'Tsang', 'pk@gmail.com' , 
	'8888-1234', '2024-10-15', 'KBOF001', 20500.00, 90,8805,  100);
insert into employees values (8803, 'Smart', 'Boy', 'smart@gmail.com' , 
	'8900-1234', '2001-01-02', 'BCFE001', 25500.00, 40,2, 106);
insert into employees values (8804, 'Chill', 'Guy', 'chill@gmail.com' , 
	'8905-1234', '2005-01-30', 'KPSU001', 20000.00, 10,7, 120);
insert into employees values (8805, 'De Haan', 'Lex', 'lex@gmail.com' , 
	'8900-3334', '2000-01-30', 'KBOS001', 12000.00, 100,8805, 100);
-- select * from employees;

 drop table job_history;
create table job_history (
	employee_id integer,
	foreign key (employee_id) references employees (employee_id),
    start_date date primary key,
    end_date date,
    job_id varchar(10),
    foreign key (job_id) references jobs (job_id),
    department_id integer,
    foreign key (department_id) references departments (department_id)
);

insert into job_history values (8801, '2001-02-01', '2002-02-02', 'KBOF002', 115);
insert into job_history values (8802, '2024-11-01', '2025-01-16', 'KBOF001', 100);
insert into job_history values (8803, '2001-01-15', '2024-01-30', 'BCFE001', 106);
insert into job_history values (8804, '2005-02-10', '2024-01-15', 'KPSU001', 120);
insert into job_history values (8805, '2000-01-30', '2024-01-15', 'KBOS001', 100);
-- select * from job_history;



