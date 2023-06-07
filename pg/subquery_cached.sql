explain (analyze, buffers, verbose)
select s.name,
    e.course
from students_cache s,
    exams_cache e
where s.id = e.sid
    and e.grade =(
        select min(e2.grade)
        from exams_cache e2
        where s.id = e2.sid
    );
