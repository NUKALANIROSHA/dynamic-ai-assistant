-- =============================
--   CREATE TABLES
-- =============================

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT,
    department TEXT,
    sub_marks INT,
    phone_number TEXT  -- phone number stored as text (important)
);

CREATE TABLE marks (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id),
    subject TEXT,
    score INT
);

CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_name TEXT,
    date DATE,
    location TEXT
);

-- =============================
--   INSERT 10 STUDENT ROWS
-- =============================

INSERT INTO students (name, department, sub_marks, phone_number) VALUES
('Rahul Kumar', 'Computer Science', 20, '9876543210'),
('Aisha Verma', 'Electronics', 30, '9123456780'),
('Vikram Singh', 'Mechanical', 10, '9988776655'),
('Sneha Reddy', 'Computer Science', 40, '9871234560'),
('Arjun Patel', 'Civil', 20, '9090909090'),
('Meera Sharma', 'Electronics', 30, '9812345678'),
('Rohan Das', 'Mechanical', 20, '9900112233'),
('Priya Nair', 'Computer Science', 10, '9123987654'),
('Sanjay Gupta', 'Civil', 40, '9988001122'),
('Neha Joshi', 'Electronics', 10, '9877765432');

-- =============================
--   INSERT 10 MARK ROWS
-- =============================

INSERT INTO marks (student_id, subject, score) VALUES
(1, 'Maths', 88),
(2, 'Physics', 92),
(3, 'Mechanics', 75),
(4, 'Programming', 95),
(5, 'Structures', 81),
(6, 'Circuits', 89),
(7, 'Thermodynamics', 78),
(8, 'Algorithms', 91),
(9, 'Surveying', 84),
(10, 'Electronics', 87);

-- =============================
--   INSERT 10 EVENT ROWS
-- =============================

INSERT INTO events (event_name, date, location) VALUES
('Tech Fest', '2025-01-20', 'Auditorium'),
('Coding Marathon', '2025-02-02', 'Lab 5'),
('Sports Day', '2025-03-10', 'Ground'),
('Robotics Expo', '2025-03-25', 'Block B'),
('Cultural Night', '2025-04-01', 'Main Hall'),
('Hackathon', '2025-04-15', 'Lab 2'),
('Art Exhibition', '2025-04-30', 'Studio Room'),
('Science Fair', '2025-05-18', 'Block C'),
('Music Fest', '2025-06-04', 'Amphitheater'),
('Convocation Day', '2025-07-12', 'Conference Hall');