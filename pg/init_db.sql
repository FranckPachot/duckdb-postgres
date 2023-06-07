-- cleanup if necessary
drop table if exists exams;
drop table if exists students;
-- generate tables
create table students (
    id bigserial, 
    name text
);
create table exams (
    id bigserial,
    sid bigint,
    grade int,
    course text
);
-- add primary keys
alter table students add primary key (id);
alter table exams add primary key (id);
-- generate 100000 students
insert into students (name)
select md5(random()::text)
from generate_series(1, 100000);
-- generate 10 exams per student
insert into exams (sid, grade, course)
select students.id,
    floor(random() * (101))::int,
    md5(random()::text)
from generate_series(1, 10),
    students;
-- secondary indexes
create index exams_sid on exams (sid asc, grade asc);
-- vacuum and gather stats
vacuum analyze;
-- demo data
select count(s.name)
from students s
    join exams e on s.id = e.sid
    and s.id = 999;
