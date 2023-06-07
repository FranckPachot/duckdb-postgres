explain (analyze, buffers, verbose)
select students.name,
    exams.course
from students,
    exams,
    (
        select e2.sid as id,
            min(e2.grade) as best
        from exams e2
        group by e2.sid
    ) min_exam_grades
where students.id = exams.sid
    and min_exam_grades.id = students.id
    and exams.grade = min_exam_grades.best;
