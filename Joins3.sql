-- Students table
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  name VARCHAR(50),
  class_id INT
);

-- Classes table
CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR(50)
);

-- Scores table
CREATE TABLE scores (
  student_id INT,
  subject VARCHAR(50),
  marks INT
);

-- test_scores
CREATE TABLE test_scores (
  student_id INT,
  subject VARCHAR(50),
  test_date DATE,
  marks INT
);


-- Insert into students
INSERT INTO students (student_id, name, class_id) VALUES
(1, 'Aditi', 101),
(2, 'Raj', 101),
(3, 'Meena', 102),
(4, 'Sohan', 102);

-- Insert into classes
INSERT INTO classes (class_id, class_name) VALUES
(101, 'Class A'),
(102, 'Class B');

-- Insert into scores
INSERT INTO scores (student_id, subject, marks) VALUES
-- Math scores
(1, 'Math', 70),
(2, 'Math', 90),
(3, 'Math', 85),
(4, 'Math', 60),
-- Physics scores
(1, 'Physics', 80),
(2, 'Physics', 90),
(3, 'Physics', 88),
(4, 'Physics', 75);


INSERT INTO test_scores (student_id, subject, test_date, marks) VALUES
(1, 'Math', '2024-01-01', 45),
(1, 'Math', '2024-03-01', 78),
(2, 'Math', '2024-01-01', 65),
(2, 'Math', '2024-03-01', 82),
(3, 'Math', '2024-01-01', 70),
(3, 'Math', '2024-03-01', 72),
(4, 'Math', '2024-01-01', 60),
(4, 'Math', '2024-03-01', 95),
(1, 'Physics', '2024-01-01', 40),
(1, 'Physics', '2024-03-01', 85),
(2, 'Physics', '2024-01-01', 75),
(2, 'Physics', '2024-03-01', 78),
(3, 'Physics', '2024-01-01', 60),
(3, 'Physics', '2024-03-01', 60),
(4, 'Physics', '2024-01-01', 70),
(4, 'Physics', '2024-03-01', 88);


-- 1.Top 2 Students per Subject
SELECT *
FROM (
  SELECT s.name, sc.subject, sc.marks,
         DENSE_RANK() OVER (PARTITION BY sc.subject ORDER BY sc.marks DESC) AS rank
  FROM scores sc
  JOIN students s ON sc.student_id = s.student_id
) ranked
WHERE rank <= 2;

-- 2.Students Scoring Below Class Average in Any Subject
WITH class_avg AS (
  SELECT c.class_id, sc.subject, AVG(sc.marks) AS avg_marks
  FROM scores sc
  JOIN students s ON sc.student_id = s.student_id
  JOIN classes c ON s.class_id = c.class_id
  GROUP BY c.class_id, sc.subject
)
SELECT s.name, sc.subject, sc.marks
FROM scores sc
JOIN students s ON sc.student_id = s.student_id
JOIN classes c ON s.class_id = c.class_id
JOIN class_avg ca ON ca.class_id = c.class_id AND ca.subject = sc.subject
WHERE sc.marks < ca.avg_marks;

-- 3.Class-wise Subject Toppers and Their Performance Tier
WITH ranked_scores AS (
  SELECT
    s.student_id,
    s.name,
    c.class_name,
    sc.subject,
    sc.marks,
    RANK() OVER (PARTITION BY c.class_id, sc.subject ORDER BY sc.marks DESC) AS rank
  FROM scores sc
  JOIN students s ON sc.student_id = s.student_id
  JOIN classes c ON s.class_id = c.class_id
),
top_toppers AS (
  SELECT *
  FROM ranked_scores
  WHERE rank = 1
)
SELECT
  name,
  class_name,
  subject,
  marks,
  CASE
    WHEN marks >= 90 THEN 'Excellent'
    WHEN marks >= 75 THEN 'Good'
    ELSE 'Average'
  END AS performance_tier
FROM top_toppers;


-- 4.Find the Most Improved Student Per Class Per Subject
WITH score_diff AS (
  SELECT 
    ts.student_id,
    s.name,
    c.class_id,
    c.class_name,
    ts.subject,
    MAX(ts.marks) - MIN(ts.marks) AS improvement
  FROM test_scores ts
  JOIN students s ON ts.student_id = s.student_id
  JOIN classes c ON s.class_id = c.class_id
  GROUP BY ts.student_id, ts.subject, s.name, c.class_id, c.class_name
),
ranked AS (
  SELECT *,
         RANK() OVER (PARTITION BY class_id, subject ORDER BY improvement DESC) AS rnk
  FROM score_diff
),
toppers AS (
  SELECT *
  FROM ranked
  WHERE rnk = 1
)
SELECT 
  name,
  class_name,
  subject,
  improvement,
  CASE
    WHEN improvement >= 30 THEN 'Drastic'
    WHEN improvement >= 15 THEN 'Moderate'
    WHEN improvement >= 1 THEN 'Slight'
    ELSE 'No Improvement'
  END AS performance_tier
FROM toppers;
