explain (analyze, buffers, verbose)
select s.name,
    e.course
from students_cache s,
    exams_cache e,
    (
        select e2.sid as id,
            min(e2.grade) as best
        from exams_cache e2
        group by e2.sid
    ) min_exam_grades
where s.id = e.sid
    and min_exam_grades.id = s.id
    and e.grade = min_exam_grades.best;
