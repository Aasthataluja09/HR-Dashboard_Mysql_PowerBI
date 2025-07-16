create database project;
use project;
select * from hr;
alter table hr
change column ï»¿id emp_id varchar(20) null;       -- query to change column name

describe hr;
select birthdate from hr ;
set sql_safe_updates=0;
# DATA CLEANING
update hr 
set birthdate= CASE
  when birthdate like'%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
  when birthdate like'%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
  else null
end;
  
alter  table hr 
modify column birthdate date;
select birthdate from hr;
describe hr;

update hr 
set hire_date= CASE
  when  hire_date like'%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
  when hire_date like'%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
  else null
end;

select hire_date from hr;
alter table hr
modify column hire_date date;

describe hr;
select termdate from hr;

update hr 
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate!='';

select termdate from hr;
alter table hr
modify column termdate date;
describe hr;
UPDATE HR
SET termdate = CASE
    WHEN termdate IS NULL OR termdate = '' THEN '0000-00-00'
    ELSE termdate
END ; 

ALTER  TABLE HR 
MODIFY COLUMN TERMDATE DATE;

SELECT @@SESSION.sql_mode;
SET SESSION sql_mode = REPLACE(@@SESSION.sql_mode, 'STRICT_TRANS_TABLES', '');
SELECT @@SESSION.sql_mode;
SET SESSION sql_mode = REPLACE(@@SESSION.sql_mode, 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION', '');
ALTER  TABLE HR 
MODIFY COLUMN TERMDATE DATE;

ALTER TABLE HR ADD COLUMN AGE INT ;

UPDATE HR 
SET AGE=timestampdiff(YEAR,birthdate,curdate());

select birthdate, age from hr ;

select min(Age) as youngest , max(Age) as eldest from hr;
select  count(*) from hr  where age<18;












