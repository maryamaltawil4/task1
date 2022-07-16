create database MY_DATABASE;
use MY_DATABASE;
select @@SPID

create table students(s_id int not null primary key, name varchar(20));
insert into students(s_id, name) values (1, 'may'),(2, 'Ali'),(3, 'Aya'),(4, 'omar'), (5, 'Mariam'), (6, 'Israa');

create table subject1 (id_subject1 int  ,name_subject1 varchar(20),  PRIMARY KEY (id_subject1));
create table mark (s_id int  ,id_subject1 int, marks int , PRIMARY KEY (s_id,id_subject1  ),FOREIGN KEY (s_id)
      REFERENCES students (s_id),FOREIGN KEY (id_subject1)
      REFERENCES subject1 (id_subject1)
);

insert into subject1 values (1, 'Math'), (2, 'Arabic'), (3, 'English'), (4, 'Science'), (5, 'Biology'), (6, 'Physics'), (7, 'Chemistry'), (8, 'IT'), (9, 'History'), (10, 'Geography');


insert into mark values (4,1,70), (4,2,25), (4,3,26),(4,4,80), (4,5,80),(4,6,80),(4,7,80),(4,8,80),(4,9,80),(4,10,80),
						(1,1,50), (1,2,70), (1,3,80),(1,4,80), (1,5,80),(1,6,80),(1,7,80),(1,8,80),(1,9,80),(1,10,80),
						(2,1,30), (2,2,70), (2,3,80),(2,4,20), (2,5,40),(2,6,80),(2,7,75),(2,8,54),(2,9,60),(2,10,80),
						(5,1,70), (5,2,80), (5,3,80),(5,4,80), (5,5,80),(5,6,80),(5,7,80),(5,8,80),(5,9,80),(5,10,80),
						(6,1,70), (6,2,70), (6,3,75),(6,4,80), (6,5,95),(6,6,65),(6,7,80),(6,8,80),(6,9,80),(6,10,80),
						(3,1,100), (3,2,49), (3,3,49),(3,4,49), (3,5,100),(3,6,49),(3,7,100),(3,8,100),(3,9,100),(3,10,100);
			
			---------------------------------------------------------------------------------------------------
----TABLE 1-------
select students.name ,avg( mark.marks) as avg_marks  , 
STATUS =CASE
WHEN (select count( mark.id_subject1) from mark where students.s_id= mark.s_id  and  mark.marks>= 50 ) =10 THEN 'pass'
WHEN (select count( mark.id_subject1) from mark where students.s_id= mark.s_id  and  mark.marks>= 50 ) >=7 THEN 'incomplite '
Else 'failed '
END 
from students inner join mark 
on students.s_id= mark.s_id 
group by students.s_id ,students.name;
-----------------------------------------------------------------
----TABLE 2-------
select top 3 avg( mark.marks) as avg_marks,students.name
from students inner join mark 
on students.s_id= mark.s_id 
and(select count( mark.id_subject1) from mark where students.s_id= mark.s_id  and  mark.marks >= 50 ) = 10
group by mark.s_id ,students.name order by avg_marks desc ;