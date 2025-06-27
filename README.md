
# QUE 1: ###################
orders
order_id	customer_id	product_id	quantity
1	101	1001	2
2	102	1003	1
3	101	1002	4

customers
customer_id	name
101	Alice
102	Bob

products
product_id	name	price
1001	Laptop	1000
1002	Mouse	50
1003	Keyboard	80





# Que 2 ###################
SQL JOINS2.sql

Tables:
students(student_id, name, class_id)

classes(class_id, class_name, teacher_id)

teachers(teacher_id, teacher_name)

scores(student_id, subject, marks)


Question:
1. List students with their class and teacher name
(JOIN students → classes → teachers)

2. Find students not assigned to any class
(LEFT JOIN students → classes, filter NULL)

3. Subjects with average marks < 60 and student count
(GROUP BY + HAVING)

4. Top scorer in each subject
(Use RANK() or MAX() with JOIN)

5. Total marks of each student with class and teacher
(JOIN + GROUP BY student)

6. Teachers with no students in their classes
(LEFT JOIN teachers → classes → students, filter NULL)

7. List all students and their scores
(LEFT JOIN students → scores)

8. Average marks per subject for each class
(JOIN + GROUP BY class + subject)

9. Students who appeared in more than one subject
(GROUP BY student, HAVING COUNT(subject) > 1)

10. Student with highest total marks
(GROUP BY + ORDER BY DESC LIMIT 1)


# QUE 3 ###################

Problem: Student Performance Analysis
You are given four tables:

students
Column	Type
student_id	INT (PK)
name	VARCHAR
class_id	INT

classes
Column	Type
class_id	INT (PK)
class_name	VARCHAR

scores
Column	Type
student_id	INT
subject	VARCHAR
marks	INT

test_scores
Column	Type
student_id	INT
subject	VARCHAR
test_date	DATE
marks	INT

Tasks
1. Top 2 Students per Subject
Return students with top 2 marks per subject from scores. Use DENSE_RANK().

Output: name, subject, marks

2. Below Class Average
Find students whose marks in scores are below their class+subject average.

Output: name, subject, marks

3. Class Toppers with Tier
Return top scorer per class and subject from scores, with:

Excellent if ≥ 90

Good if ≥ 75

Average otherwise

Output: name, class_name, subject, marks, performance_tier

4. Most Improved Student
From test_scores, find per class+subject the student with highest (MAX - MIN) marks. Add tier:

Drastic if ≥ 30

Moderate if ≥ 15

Slight if ≥ 1

No Improvement otherwise

Output: name, class_name, subject, improvement, performance_tier

