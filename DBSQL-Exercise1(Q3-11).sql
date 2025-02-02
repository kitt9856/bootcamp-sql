-- Q3
select L.location_id, L.street_address,L.state_province ,C.country_name
from locations L inner join counties C
where L.country_id = C.country_id;

-- Q4
select first_name, last_name, department_id
from employees;

-- Q5
-- select first_name, last_name,job_id, department_id
-- from employees E where department_id = 120;
with A_table  as (
	select location_id 
    from locations L 
    where country_id = 'JP'
),
B_table as (
	select department_id
    from departments D inner join A_table A
     on A.location_id = D.location_id
)
select E.first_name, E.last_name, E.job_id, E.department_id
from employees E inner join B_table B on  B.department_id = E.department_id;

-- Q6
with C_table as(
	select last_name, manager_id
    from employees where manager_id = employee_id
)
select E.employee_id, E.last_name, E.manager_id, C.last_name
from employees E inner join C_table C where C.manager_id = E.manager_id;

-- Q7
with lex_id as(
select employee_id, hire_date
from  employees E where E.last_name = 'lex' 
and E.first_name = 'De Haan'
 )
 select E.first_name, E.last_name, E.hire_date
 from employees E inner join lex_id L on E.hire_date > L.hire_date;
 
 select count(first_name)
 from employees;

-- Q8
select D.department_name, count(E.first_name)
from employees E left join departments D on E.department_id = D.department_id
group by (D.department_id);

-- Q9 department id "30" change to "100"
select E.employee_id, JO.job_title, datediff(J.end_date, J.start_date) as num_day_work
from employees E left join jobs JO on E.job_id = JO.job_id
inner join job_history J on E.employee_id = J.employee_id 
and E.department_id = 100;

-- Q10
select D.department_name, concat(E.first_name, ' ', E.last_name) as manager_name, L.city, C.country_name
from employees E left join departments D on E.department_id = D.department_id 
left join locations L on D.location_id = L.location_id 
left join counties C on L.country_id = C.country_id;

-- Q11
select D.department_name, avg(E.salary) as avg_salary_department
from employees E left join departments D on E.department_id = D.department_id
group by D.department_id;








