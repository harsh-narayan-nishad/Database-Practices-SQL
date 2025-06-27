CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name TEXT,
    age INT
);

INSERT INTO students VALUES
(1, 'Alice', 20),
(2, 'Bob', 21),
(3, 'Charlie', 22),
(4, 'David', 23);

SELECT *FROM students;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    student_id INT,
    course_name TEXT
);

INSERT INTO courses VALUES
(101, 1, 'Math'),
(102, 1, 'Science'),
(103, 2, 'History'),
(104, 5, 'Geography');


SELECT s.name, c.course_name
FROM students s
INNER JOIN courses c ON s.student_id = c.student_id;

-- DROP TABLE IF EXISTS courses;

-- DROP TABLE IF EXISTS students;


