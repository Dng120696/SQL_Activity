
CREATE TABLE students (
	id 			integer 			   	 PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	middle_name VARCHAR(255) , 
	last_name VARCHAR(255) NOT NULL, 
	age INTEGER,
	location VARCHAR(255) NOT NULL);

INSERT INTO students(id,first_name,last_name, age,location)
VALUES (1,'Juan', 'Cruz' ,18, 'Manila'),
(2,'Anne', 'Wall' ,20, 'Manila'),
(3,'Theresa', 'Joseph' ,21,'Manila'),
(4,'Issac','Gray' ,19, 'Laguna'),
(5,'Zack', 'Matthews' ,22, 'Marikina'),
(6,'Finn', 'Lam' ,25, 'Manila');

UPDATE students
SET first_name = 'Ivan',middle_name = 'Ingram', last_name = 'Howard' ,age = 25, location = 'Bulacan'
WHERE id = 1;

DELETE FROM students
WHERE id = 6;

-- ACtivity #2
SELECT COUNT(*) FROM students;

SELECT * FROM students
WHERE location = 'Manila';

SELECT ROUND(AVG(age),2) FROM students;

SELECT * from students ORDER BY age DESC;

SELECT * FROM students;

-- ACtivity #3
--  - grades can be "A", "B", "C", "D", "E", "F", or NULL
-- bonus points if you can implement something like this https://stackoverflow.com/questions/10923213/postgres-enum-data-type-or-check-constraint

CREATE TYPE research_grades AS ENUM ('A', 'B', 'C', 'D', 'E', 'F');

-- Create new table research_papers with the following columns
CREATE TABLE research_papers(
	id int PRIMARY KEY,
	student_id int NOT NULL,
	grade research_grades,
	FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Insert 10 records to the new table
-- 2 students should have more than 1 research paper
-- 2 students should have 1 ungraded (NULL) research paper
INSERT INTO research_papers (id, student_id,grade )
VALUES 
	(6, 1, 'A'),
	(7, 2, 'D'),
	(8, 3, 'B'),
	(9, 4, 'C'),
	(10, 5, 'E'),
	(11, 1, NULL),
	(12, 3, 'A'),
	(13, 2, 'C'),
	(14, 2, NULL),
	(15	, 4, 'F')
;

-- just checking the table
SELECT * FROM research_papers;

-- Query all students with multiple research papers (select first_name, last_name, and number_of_research_papers only)
SELECT
    s.first_name,
    s.last_name,
    COUNT(rp.id) AS number_of_research_papers
FROM
    students s
JOIN
    research_papers rp ON s.id = rp.student_id
GROUP BY
    s.id, s.first_name, s.last_name
HAVING
    COUNT(rp.id) > 1;

-- Query all students with ungraded research papers (select first_name, last_name, research_paper_id, and grade only)

SELECT
    s.first_name,
    s.last_name,
    rp.id AS research_paper_id,
    rp.grade AS grade
FROM
    students s
JOIN
    research_papers rp ON s.id = rp.student_id
WHERE
    rp.grade IS NULL;



