CREATE TABLE Student (
    Name VARCHAR(50),
    Subject VARCHAR(50),
    Marks INT
);

INSERT INTO Student (Name, Subject, Marks) VALUES 
('ABC', 'DBMS', 80),
('ABC', 'OS', 70),
('PQR', 'OS', 80),
('PQR', 'DBMS', 70),
('XYZ', 'DBMS', 80),
('BCD', 'OS', 100),
('BCD', 'DBMS', 90),
('XYZ', 'OS', 80),
('ABC', 'DBMS', 80), ('ABC', 'OS', 70),
('PQR', 'OS', 80), ('PQR', 'DBMS', 70),
('XYZ', 'DBMS', 80), ('BCD', 'OS', 100),
('BCD', 'DBMS', 90), ('XYZ', 'OS', 80),
('AAA', 'DBMS', 91), ('AAA', 'OS', 88),
('BBB', 'DBMS', 76), ('BBB', 'OS', 85),
('CCC', 'DBMS', 65), ('CCC', 'OS', 75),
('DDD', 'DBMS', 89), ('DDD', 'OS', 79),
('EEE', 'DBMS', 95), ('EEE', 'OS', 92),
('FFF', 'DBMS', 60), ('FFF', 'OS', 70),
('GGG', 'DBMS', 85), ('GGG', 'OS', 86),
('HHH', 'DBMS', 78), ('HHH', 'OS', 83),
('III', 'DBMS', 88), ('III', 'OS', 91),
('JJJ', 'DBMS', 93), ('JJJ', 'OS', 96),
('KLM', 'DBMS', 72), ('KLM', 'OS', 81),
('NOP', 'DBMS', 87), ('NOP', 'OS', 84),
('QRS', 'DBMS', 94), ('QRS', 'OS', 90),
('TUV', 'DBMS', 77), ('TUV', 'OS', 65),
('WXY', 'DBMS', 69), ('WXY', 'OS', 67),
('ZAB', 'DBMS', 64), ('ZAB', 'OS', 63),
('MNO', 'DBMS', 74), ('MNO', 'OS', 71),
('PST', 'DBMS', 92), ('PST', 'OS', 87),
('LMN', 'DBMS', 83), ('LMN', 'OS', 82),
('JKL', 'DBMS', 66), ('JKL', 'OS', 68),
('DEF', 'DBMS', 79), ('DEF', 'OS', 76),
('UVW', 'DBMS', 97), ('UVW', 'OS', 94),
('RST', 'DBMS', 82), ('RST', 'OS', 89);


-- Total Marks by Student

SELECT Name, SUM(Marks) AS Total_Marks
FROM Student
GROUP BY Name;

-- Average Marks by Subject

SELECT Subject, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Subject;

 -- Highest Marks in Each Subject
 SELECT Subject, MAX(Marks) AS Highest_Marks
FROM Student
GROUP BY Subject;

-- Lowest Marks in Each Subject
SELECT Subject, MIN(Marks) AS Lowest_Marks
FROM Student
GROUP BY Subject;

-- Number of Students per Subject
SELECT Subject, COUNT(Name) AS Student_Count
FROM Student
GROUP BY Subject;

-- Average Marks per Student
SELECT Name, AVG(Marks) AS Average_Marks
FROM Student
GROUP BY Name;

-- Total Marks by Subject
SELECT Subject, SUM(Marks) AS Total_Marks
FROM Student
GROUP BY Subject;

-- Student and Their Subjects Count
SELECT Name, COUNT(Subject) AS Subject_Count
FROM Student
GROUP BY Name;


-- Get 2nd Highest Marks in Each Subject

SELECT Subject, MAX(Marks) AS Second_Highest
FROM Student
WHERE Marks < (
    SELECT MAX(Marks)
    FROM Student AS S2
    WHERE S2.Subject = Student.Subject
)
GROUP BY Subject;

-- Rank Students (by Marks per Subject)
SELECT Name, Subject, Marks,
       RANK() OVER (PARTITION BY Subject ORDER BY Marks DESC) AS Rank
FROM Student;

-- Get Student with a Specific Rank (e.g. 2nd Rank in OS)
WITH Ranked AS (
    SELECT Name, Subject, Marks,
           RANK() OVER (PARTITION BY Subject ORDER BY Marks DESC) AS Rank
    FROM Student
)

SELECT *
FROM Ranked
WHERE Subject = 'OS' AND Rank = 2;

