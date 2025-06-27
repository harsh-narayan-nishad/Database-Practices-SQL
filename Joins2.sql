CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class_id INT
);

INSERT INTO students VALUES
(1, 'Aman', 101),
(2, 'Priya', 101),
(3, 'Ravi', 102),
(4, 'Anjali', 103),
(5, 'Rohan', NULL);


CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50),
  teacher_id INT
);

INSERT INTO classes VALUES
(101, 'Physics', 1),
(102, 'Chemistry', 2),
(103, 'Maths', 3);

CREATE TABLE teachers (
  teacher_id INT PRIMARY KEY,
  teacher_name VARCHAR(50)
);


INSERT INTO teachers VALUES
(1, 'Mr. Sharma'),
(2, 'Ms. Verma'),
(3, 'Dr. Kapoor');


CREATE TABLE scores (
  student_id INT,
  subject VARCHAR(50),
  marks INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO scores VALUES
(1, 'Physics', 78),
(1, 'Chemistry', 69),
(2, 'Physics', 92),
(2, 'Maths', 88),
(3, 'Chemistry', 34),
(4, 'Maths', 96),
(4, 'Physics', 44),
(5, 'Physics', 55);

-- List students with their class name and teacher's name (multi-join)
SELECT s.name AS student_name, c.class_name, t.teacher_name
FROM students s
JOIN classes c ON s.class_id = c.class_id
JOIN teachers t ON c.teacher_id = t.teacher_id;

-- List students who are NOT in any class
SELECT s.name
FROM students s
LEFT JOIN classes c ON s.class_id = c.class_id
WHERE c.class_id IS NULL;

-- Subjects where average score < 60, with number of students

SELECT subject, AVG(marks) AS avg_score, COUNT(*) AS student_count
FROM scores
GROUP BY subject
HAVING AVG(marks) < 60;

-- Top scorers in each subject (using window functions)
WITH ranked_scores AS (
  SELECT s.name, sc.subject, sc.marks,
         RANK() OVER (PARTITION BY sc.subject ORDER BY sc.marks DESC) AS rnk
  FROM scores sc
  JOIN students s ON sc.student_id = s.student_id
)
SELECT name, subject, marks
FROM ranked_scores
WHERE rnk = 1;

-- Total marks of each student with class and teacher info
SELECT s.name AS student_name, c.class_name, t.teacher_name, SUM(sc.marks) AS total_marks
FROM students s
LEFT JOIN scores sc ON s.student_id = sc.student_id
LEFT JOIN classes c ON s.class_id = c.class_id
LEFT JOIN teachers t ON c.teacher_id = t.teacher_id
GROUP BY s.name, c.class_name, t.teacher_name;

-- Teachers with no students assigned to their classes
SELECT t.teacher_name
FROM teachers t
LEFT JOIN classes c ON t.teacher_id = c.teacher_id
LEFT JOIN students s ON s.class_id = c.class_id
WHERE s.student_id IS NULL;

-- List of all students and their scores (even if no scores available)
SELECT s.name, sc.subject, sc.marks
FROM students s
LEFT JOIN scores sc ON s.student_id = sc.student_id;





