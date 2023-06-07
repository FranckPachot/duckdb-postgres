explain (analyze, buffers, verbose)
select s.name,
    e.course
from students s,
    exams e
where s.id = e.sid
    and e.grade =(
        select min(e2.grade)
        from exams e2
        where s.id = e2.sid
);
