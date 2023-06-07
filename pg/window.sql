explain (analyze, buffers, verbose)
select name, course
from (  
  select s.name,
    e.course,
    e.grade,
    min(e.grade) over(partition by s.id) student_min_grade
  from students s,
    exams e
where s.id = e.sid
) as student_grade
where grade=student_min_grade;
