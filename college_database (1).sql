-- ============================================================
-- Greenwood Institute of Technology - College Database
-- Generated SQL Script
-- ============================================================

-- Drop database if exists and recreate
DROP DATABASE IF EXISTS college_db;
CREATE DATABASE college_db;
USE college_db;

-- ============================================================
-- TABLE: college
-- ============================================================
CREATE TABLE college (
    college_id   INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100)  NOT NULL,
    established  YEAR          NOT NULL,
    location     VARCHAR(150)  NOT NULL,
    total_students INT         NOT NULL
);

-- College data
INSERT INTO college (name, established, location, total_students) VALUES ('Greenwood Institute of Technology', 1998, 'Pune, Maharashtra, India', 100);

-- ============================================================
-- TABLE: departments
-- ============================================================
CREATE TABLE departments (
    department_id   INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Department data
INSERT INTO departments (department_name) VALUES ('Biomedical Engineering');
INSERT INTO departments (department_name) VALUES ('Civil Engineering');
INSERT INTO departments (department_name) VALUES ('Computer Science Engineering');
INSERT INTO departments (department_name) VALUES ('Electrical Engineering');
INSERT INTO departments (department_name) VALUES ('Electronics and Communication');
INSERT INTO departments (department_name) VALUES ('Information Technology');
INSERT INTO departments (department_name) VALUES ('Mechanical Engineering');

-- ============================================================
-- TABLE: students
-- ============================================================
CREATE TABLE students (
    student_id           VARCHAR(20)   PRIMARY KEY,
    full_name            VARCHAR(100)  NOT NULL,
    age                  TINYINT       NOT NULL,
    gender               ENUM('Male','Female','Other') NOT NULL,
    date_of_birth        DATE          NOT NULL,
    email                VARCHAR(100)  NOT NULL UNIQUE,
    phone                VARCHAR(20)   NOT NULL,
    department_id        INT           NOT NULL,
    year                 TINYINT       NOT NULL CHECK (year BETWEEN 1 AND 4),
    semester             TINYINT       NOT NULL CHECK (semester BETWEEN 1 AND 8),
    enrollment_year      YEAR          NOT NULL,
    gpa                  DECIMAL(3,1)  NOT NULL CHECK (gpa BETWEEN 0.0 AND 10.0),
    attendance_percentage DECIMAL(5,2) NOT NULL CHECK (attendance_percentage BETWEEN 0 AND 100),
    status               ENUM('Active','Inactive','Graduated','Suspended') NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_student_dept FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ============================================================
-- TABLE: addresses
-- ============================================================
CREATE TABLE addresses (
    address_id  INT AUTO_INCREMENT PRIMARY KEY,
    student_id  VARCHAR(20)  NOT NULL UNIQUE,
    street      VARCHAR(150) NOT NULL,
    city        VARCHAR(80)  NOT NULL,
    state       VARCHAR(80)  NOT NULL,
    pincode     VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_address_student FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ============================================================
-- TABLE: guardians
-- ============================================================
CREATE TABLE guardians (
    guardian_id  INT AUTO_INCREMENT PRIMARY KEY,
    student_id   VARCHAR(20) NOT NULL UNIQUE,
    guardian_name VARCHAR(100) NOT NULL,
    relation     VARCHAR(30)  NOT NULL,
    phone        VARCHAR(20)  NOT NULL,
    CONSTRAINT fk_guardian_student FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- ============================================================
-- TABLE: courses
-- ============================================================
CREATE TABLE courses (
    course_id   INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE
);

-- Course data
INSERT INTO courses (course_name) VALUES ('AI Ethics');
INSERT INTO courses (course_name) VALUES ('API Development');
INSERT INTO courses (course_name) VALUES ('Additive Manufacturing');
INSERT INTO courses (course_name) VALUES ('Advanced Algorithms');
INSERT INTO courses (course_name) VALUES ('Advanced CAD/CAM');
INSERT INTO courses (course_name) VALUES ('Advanced Communication Systems');
INSERT INTO courses (course_name) VALUES ('Advanced Data Mining');
INSERT INTO courses (course_name) VALUES ('Advanced Database Systems');
INSERT INTO courses (course_name) VALUES ('Advanced Hydraulics');
INSERT INTO courses (course_name) VALUES ('Advanced Manufacturing');
INSERT INTO courses (course_name) VALUES ('Advanced Microprocessors');
INSERT INTO courses (course_name) VALUES ('Advanced Physiology');
INSERT INTO courses (course_name) VALUES ('Advanced Power Electronics');
INSERT INTO courses (course_name) VALUES ('Advanced Structural Analysis');
INSERT INTO courses (course_name) VALUES ('Advanced Surveying');
INSERT INTO courses (course_name) VALUES ('Aerospace Engineering');
INSERT INTO courses (course_name) VALUES ('Agile Methodologies');
INSERT INTO courses (course_name) VALUES ('Algorithms');
INSERT INTO courses (course_name) VALUES ('Analog Circuits');
INSERT INTO courses (course_name) VALUES ('Analog Electronics');
INSERT INTO courses (course_name) VALUES ('Anatomy and Physiology');
INSERT INTO courses (course_name) VALUES ('Antenna Design');
INSERT INTO courses (course_name) VALUES ('Applied Mechanics');
INSERT INTO courses (course_name) VALUES ('Artificial Intelligence');
INSERT INTO courses (course_name) VALUES ('Augmented Reality');
INSERT INTO courses (course_name) VALUES ('Automobile Engineering');
INSERT INTO courses (course_name) VALUES ('Basic Civil Engineering');
INSERT INTO courses (course_name) VALUES ('Basic Electrical Engineering');
INSERT INTO courses (course_name) VALUES ('Basic Electronics');
INSERT INTO courses (course_name) VALUES ('Basic Hydraulics');
INSERT INTO courses (course_name) VALUES ('Basic Mechanics');
INSERT INTO courses (course_name) VALUES ('Big Data Analytics');
INSERT INTO courses (course_name) VALUES ('Biochemistry');
INSERT INTO courses (course_name) VALUES ('Bioelectronics');
INSERT INTO courses (course_name) VALUES ('Bioinformatics');
INSERT INTO courses (course_name) VALUES ('Biology for Engineers');
INSERT INTO courses (course_name) VALUES ('Biomaterials');
INSERT INTO courses (course_name) VALUES ('Biomaterials Lab');
INSERT INTO courses (course_name) VALUES ('Biomechanics');
INSERT INTO courses (course_name) VALUES ('Biomechanics Lab');
INSERT INTO courses (course_name) VALUES ('Biomedical Ethics');
INSERT INTO courses (course_name) VALUES ('Biomedical Optics');
INSERT INTO courses (course_name) VALUES ('Biomedical Signal Analysis');
INSERT INTO courses (course_name) VALUES ('Biomedical Signals');
INSERT INTO courses (course_name) VALUES ('Biosensors');
INSERT INTO courses (course_name) VALUES ('Blockchain Technology');
INSERT INTO courses (course_name) VALUES ('Bridge Design');
INSERT INTO courses (course_name) VALUES ('Building Materials');
INSERT INTO courses (course_name) VALUES ('Business Intelligence');
INSERT INTO courses (course_name) VALUES ('C Programming');
INSERT INTO courses (course_name) VALUES ('C++ Programming');
INSERT INTO courses (course_name) VALUES ('Cell Biology');
INSERT INTO courses (course_name) VALUES ('Chemistry');
INSERT INTO courses (course_name) VALUES ('Circuit Design');
INSERT INTO courses (course_name) VALUES ('Circuit Simulation');
INSERT INTO courses (course_name) VALUES ('Circuit Theory');
INSERT INTO courses (course_name) VALUES ('Clinical Data Management');
INSERT INTO courses (course_name) VALUES ('Clinical Engineering');
INSERT INTO courses (course_name) VALUES ('Clinical Pharmacology');
INSERT INTO courses (course_name) VALUES ('Clinical Trials');
INSERT INTO courses (course_name) VALUES ('Cloud Computing');
INSERT INTO courses (course_name) VALUES ('Cloud Security');
INSERT INTO courses (course_name) VALUES ('Coastal Engineering');
INSERT INTO courses (course_name) VALUES ('Communication Lab');
INSERT INTO courses (course_name) VALUES ('Communication Networks');
INSERT INTO courses (course_name) VALUES ('Communication Skills');
INSERT INTO courses (course_name) VALUES ('Communication Theory');
INSERT INTO courses (course_name) VALUES ('Compiler Design');
INSERT INTO courses (course_name) VALUES ('Computational Intelligence');
INSERT INTO courses (course_name) VALUES ('Computer Aided Design');
INSERT INTO courses (course_name) VALUES ('Computer Architecture');
INSERT INTO courses (course_name) VALUES ('Computer Graphics');
INSERT INTO courses (course_name) VALUES ('Computer Networks');
INSERT INTO courses (course_name) VALUES ('Computer Organization');
INSERT INTO courses (course_name) VALUES ('Computer Vision');
INSERT INTO courses (course_name) VALUES ('Concrete Structures');
INSERT INTO courses (course_name) VALUES ('Concrete Technology');
INSERT INTO courses (course_name) VALUES ('Construction Equipment');
INSERT INTO courses (course_name) VALUES ('Construction Law');
INSERT INTO courses (course_name) VALUES ('Construction Management');
INSERT INTO courses (course_name) VALUES ('Control Engineering');
INSERT INTO courses (course_name) VALUES ('Control Systems');
INSERT INTO courses (course_name) VALUES ('Cryptography Basics');
INSERT INTO courses (course_name) VALUES ('Cyber Security');
INSERT INTO courses (course_name) VALUES ('Cybersecurity');
INSERT INTO courses (course_name) VALUES ('Cybersecurity Fundamentals');
INSERT INTO courses (course_name) VALUES ('DBMS Lab');
INSERT INTO courses (course_name) VALUES ('DSP');
INSERT INTO courses (course_name) VALUES ('DSP Lab');
INSERT INTO courses (course_name) VALUES ('Data Mining');
INSERT INTO courses (course_name) VALUES ('Data Structures');
INSERT INTO courses (course_name) VALUES ('Data Structures Lab');
INSERT INTO courses (course_name) VALUES ('Data Warehousing');
INSERT INTO courses (course_name) VALUES ('Database Lab');
INSERT INTO courses (course_name) VALUES ('Database Management');
INSERT INTO courses (course_name) VALUES ('Database Optimization');
INSERT INTO courses (course_name) VALUES ('Database Systems');
INSERT INTO courses (course_name) VALUES ('Deep Learning');
INSERT INTO courses (course_name) VALUES ('Deep Neural Networks');
INSERT INTO courses (course_name) VALUES ('Design and Analysis of Algorithms');
INSERT INTO courses (course_name) VALUES ('DevOps');
INSERT INTO courses (course_name) VALUES ('Diagnostic Equipment');
INSERT INTO courses (course_name) VALUES ('Diagnostic Imaging');
INSERT INTO courses (course_name) VALUES ('Digital Communication');
INSERT INTO courses (course_name) VALUES ('Digital Design');
INSERT INTO courses (course_name) VALUES ('Digital Electronics');
INSERT INTO courses (course_name) VALUES ('Digital Logic');
INSERT INTO courses (course_name) VALUES ('Digital Marketing Tech');
INSERT INTO courses (course_name) VALUES ('Digital Signal Processing');
INSERT INTO courses (course_name) VALUES ('Digital System Design');
INSERT INTO courses (course_name) VALUES ('Disaster Management');
INSERT INTO courses (course_name) VALUES ('Discrete Mathematics');
INSERT INTO courses (course_name) VALUES ('Discrete Maths');
INSERT INTO courses (course_name) VALUES ('Distributed Databases');
INSERT INTO courses (course_name) VALUES ('Distributed Systems');
INSERT INTO courses (course_name) VALUES ('Drug Delivery Systems');
INSERT INTO courses (course_name) VALUES ('Dynamics');
INSERT INTO courses (course_name) VALUES ('Dynamics of Machinery');
INSERT INTO courses (course_name) VALUES ('E-Commerce');
INSERT INTO courses (course_name) VALUES ('Earthquake Engineering');
INSERT INTO courses (course_name) VALUES ('Edge Computing');
INSERT INTO courses (course_name) VALUES ('Electric Drives');
INSERT INTO courses (course_name) VALUES ('Electric Traction');
INSERT INTO courses (course_name) VALUES ('Electrical Energy Systems');
INSERT INTO courses (course_name) VALUES ('Electrical Machines');
INSERT INTO courses (course_name) VALUES ('Electrical Measurements');
INSERT INTO courses (course_name) VALUES ('Electrical Technology');
INSERT INTO courses (course_name) VALUES ('Electrical Workshop');
INSERT INTO courses (course_name) VALUES ('Electromagnetic Theory');
INSERT INTO courses (course_name) VALUES ('Electromagnetic Waves');
INSERT INTO courses (course_name) VALUES ('Electronic Circuits');
INSERT INTO courses (course_name) VALUES ('Electronic Devices');
INSERT INTO courses (course_name) VALUES ('Electronics Lab');
INSERT INTO courses (course_name) VALUES ('Embedded Systems');
INSERT INTO courses (course_name) VALUES ('Energy Audit');
INSERT INTO courses (course_name) VALUES ('Energy Management');
INSERT INTO courses (course_name) VALUES ('Energy Storage');
INSERT INTO courses (course_name) VALUES ('Engineering Chemistry');
INSERT INTO courses (course_name) VALUES ('Engineering Drawing');
INSERT INTO courses (course_name) VALUES ('Engineering Fundamentals');
INSERT INTO courses (course_name) VALUES ('Engineering Geology');
INSERT INTO courses (course_name) VALUES ('Engineering Materials');
INSERT INTO courses (course_name) VALUES ('Engineering Mathematics');
INSERT INTO courses (course_name) VALUES ('Engineering Mathematics I');
INSERT INTO courses (course_name) VALUES ('Engineering Mathematics II');
INSERT INTO courses (course_name) VALUES ('Engineering Maths III');
INSERT INTO courses (course_name) VALUES ('Engineering Physics');
INSERT INTO courses (course_name) VALUES ('English');
INSERT INTO courses (course_name) VALUES ('English Communication');
INSERT INTO courses (course_name) VALUES ('Enterprise Resource Planning');
INSERT INTO courses (course_name) VALUES ('Environmental Engineering');
INSERT INTO courses (course_name) VALUES ('Environmental Geotechnics');
INSERT INTO courses (course_name) VALUES ('Environmental Impact Assessment');
INSERT INTO courses (course_name) VALUES ('Environmental Studies');
INSERT INTO courses (course_name) VALUES ('FDA Regulations');
INSERT INTO courses (course_name) VALUES ('FPGA Design');
INSERT INTO courses (course_name) VALUES ('Final Year Project');
INSERT INTO courses (course_name) VALUES ('Finite Element Methods');
INSERT INTO courses (course_name) VALUES ('Fire Safety');
INSERT INTO courses (course_name) VALUES ('First Aid and CPR');
INSERT INTO courses (course_name) VALUES ('Fluid Mechanics');
INSERT INTO courses (course_name) VALUES ('Fluid Power Engineering');
INSERT INTO courses (course_name) VALUES ('Formal Methods');
INSERT INTO courses (course_name) VALUES ('Foundation Design');
INSERT INTO courses (course_name) VALUES ('Full Stack Development');
INSERT INTO courses (course_name) VALUES ('Functional Programming');
INSERT INTO courses (course_name) VALUES ('GIS Mapping');
INSERT INTO courses (course_name) VALUES ('Game Development');
INSERT INTO courses (course_name) VALUES ('Genetic Engineering');
INSERT INTO courses (course_name) VALUES ('Geotechnical Engineering');
INSERT INTO courses (course_name) VALUES ('Graph Algorithms');
INSERT INTO courses (course_name) VALUES ('Green Buildings');
INSERT INTO courses (course_name) VALUES ('HVDC Transmission');
INSERT INTO courses (course_name) VALUES ('Hardware Security');
INSERT INTO courses (course_name) VALUES ('Healthcare Ethics');
INSERT INTO courses (course_name) VALUES ('Healthcare Informatics');
INSERT INTO courses (course_name) VALUES ('Healthcare Policy');
INSERT INTO courses (course_name) VALUES ('Healthcare Systems');
INSERT INTO courses (course_name) VALUES ('Heat Transfer');
INSERT INTO courses (course_name) VALUES ('High Voltage Engineering');
INSERT INTO courses (course_name) VALUES ('Hospital Administration');
INSERT INTO courses (course_name) VALUES ('Hospital Equipment Management');
INSERT INTO courses (course_name) VALUES ('Human Anatomy');
INSERT INTO courses (course_name) VALUES ('Human Computer Interaction');
INSERT INTO courses (course_name) VALUES ('Hydraulics');
INSERT INTO courses (course_name) VALUES ('Image Processing');
INSERT INTO courses (course_name) VALUES ('Indian Constitution');
INSERT INTO courses (course_name) VALUES ('Industrial Electronics');
INSERT INTO courses (course_name) VALUES ('Industrial Management');
INSERT INTO courses (course_name) VALUES ('Industrial Metallurgy');
INSERT INTO courses (course_name) VALUES ('Industrial Robotics');
INSERT INTO courses (course_name) VALUES ('Information Retrieval');
INSERT INTO courses (course_name) VALUES ('Information Security');
INSERT INTO courses (course_name) VALUES ('Infrastructure Planning');
INSERT INTO courses (course_name) VALUES ('Instrumentation');
INSERT INTO courses (course_name) VALUES ('Internet of Things');
INSERT INTO courses (course_name) VALUES ('Introduction to Engineering');
INSERT INTO courses (course_name) VALUES ('Introduction to Programming');
INSERT INTO courses (course_name) VALUES ('IoT Systems');
INSERT INTO courses (course_name) VALUES ('Irrigation Engineering');
INSERT INTO courses (course_name) VALUES ('Java Lab');
INSERT INTO courses (course_name) VALUES ('Java Programming');
INSERT INTO courses (course_name) VALUES ('Knowledge Engineering');
INSERT INTO courses (course_name) VALUES ('Lean Manufacturing');
INSERT INTO courses (course_name) VALUES ('Linux Administration');
INSERT INTO courses (course_name) VALUES ('Linux Systems');
INSERT INTO courses (course_name) VALUES ('MATLAB Lab');
INSERT INTO courses (course_name) VALUES ('MEMS Technology');
INSERT INTO courses (course_name) VALUES ('Machine Design');
INSERT INTO courses (course_name) VALUES ('Machine Elements');
INSERT INTO courses (course_name) VALUES ('Machine Learning');
INSERT INTO courses (course_name) VALUES ('Machine Learning Algorithms');
INSERT INTO courses (course_name) VALUES ('Manufacturing Processes');
INSERT INTO courses (course_name) VALUES ('Manufacturing Technology');
INSERT INTO courses (course_name) VALUES ('Material Science');
INSERT INTO courses (course_name) VALUES ('Mathematics');
INSERT INTO courses (course_name) VALUES ('Mathematics I');
INSERT INTO courses (course_name) VALUES ('Mathematics II');
INSERT INTO courses (course_name) VALUES ('Mathematics III');
INSERT INTO courses (course_name) VALUES ('Maths');
INSERT INTO courses (course_name) VALUES ('Maths IV');
INSERT INTO courses (course_name) VALUES ('Measurement and Instrumentation');
INSERT INTO courses (course_name) VALUES ('Mechanics');
INSERT INTO courses (course_name) VALUES ('Medical Device Design');
INSERT INTO courses (course_name) VALUES ('Medical Electronics');
INSERT INTO courses (course_name) VALUES ('Medical Imaging');
INSERT INTO courses (course_name) VALUES ('Medical Instrumentation');
INSERT INTO courses (course_name) VALUES ('Medical Law');
INSERT INTO courses (course_name) VALUES ('Medical Robotics');
INSERT INTO courses (course_name) VALUES ('Micro Grid Design');
INSERT INTO courses (course_name) VALUES ('Microcontrollers');
INSERT INTO courses (course_name) VALUES ('Microprocessors');
INSERT INTO courses (course_name) VALUES ('Microprocessors and Interfacing');
INSERT INTO courses (course_name) VALUES ('Microservices');
INSERT INTO courses (course_name) VALUES ('Microwave Engineering');
INSERT INTO courses (course_name) VALUES ('Middleware Technologies');
INSERT INTO courses (course_name) VALUES ('Mobile App Development');
INSERT INTO courses (course_name) VALUES ('Mobile Computing');
INSERT INTO courses (course_name) VALUES ('Molecular Biology');
INSERT INTO courses (course_name) VALUES ('NSS Activities');
INSERT INTO courses (course_name) VALUES ('Nanomedicine');
INSERT INTO courses (course_name) VALUES ('Natural Language Processing');
INSERT INTO courses (course_name) VALUES ('Network Analysis');
INSERT INTO courses (course_name) VALUES ('Network Security');
INSERT INTO courses (course_name) VALUES ('Network Theory');
INSERT INTO courses (course_name) VALUES ('Neural Engineering');
INSERT INTO courses (course_name) VALUES ('Neuroprosthetics');
INSERT INTO courses (course_name) VALUES ('Non Destructive Testing');
INSERT INTO courses (course_name) VALUES ('Numerical Methods');
INSERT INTO courses (course_name) VALUES ('Object Oriented Programming');
INSERT INTO courses (course_name) VALUES ('Operating Systems');
INSERT INTO courses (course_name) VALUES ('Operations Research');
INSERT INTO courses (course_name) VALUES ('Optical Communication');
INSERT INTO courses (course_name) VALUES ('PCB Design');
INSERT INTO courses (course_name) VALUES ('PLC and Automation');
INSERT INTO courses (course_name) VALUES ('Parallel Computing');
INSERT INTO courses (course_name) VALUES ('Patient Monitoring Systems');
INSERT INTO courses (course_name) VALUES ('Photonics');
INSERT INTO courses (course_name) VALUES ('Physics');
INSERT INTO courses (course_name) VALUES ('Physics Lab');
INSERT INTO courses (course_name) VALUES ('Physiotherapy Technology');
INSERT INTO courses (course_name) VALUES ('Power Amplifiers');
INSERT INTO courses (course_name) VALUES ('Power Electronics');
INSERT INTO courses (course_name) VALUES ('Power Plant Engineering');
INSERT INTO courses (course_name) VALUES ('Power System Protection');
INSERT INTO courses (course_name) VALUES ('Power Systems');
INSERT INTO courses (course_name) VALUES ('Predictive Analytics');
INSERT INTO courses (course_name) VALUES ('Probability Theory');
INSERT INTO courses (course_name) VALUES ('Probability and Statistics');
INSERT INTO courses (course_name) VALUES ('Product Design');
INSERT INTO courses (course_name) VALUES ('Production Engineering');
INSERT INTO courses (course_name) VALUES ('Professional Communication');
INSERT INTO courses (course_name) VALUES ('Programming Fundamentals');
INSERT INTO courses (course_name) VALUES ('Programming in C');
INSERT INTO courses (course_name) VALUES ('Project Capstone');
INSERT INTO courses (course_name) VALUES ('Project Engineering');
INSERT INTO courses (course_name) VALUES ('Project Management');
INSERT INTO courses (course_name) VALUES ('Project Planning');
INSERT INTO courses (course_name) VALUES ('Project Work');
INSERT INTO courses (course_name) VALUES ('Prosthetics and Orthotics');
INSERT INTO courses (course_name) VALUES ('Python Advanced');
INSERT INTO courses (course_name) VALUES ('Python Programming');
INSERT INTO courses (course_name) VALUES ('Quality Control');
INSERT INTO courses (course_name) VALUES ('Quantity Surveying');
INSERT INTO courses (course_name) VALUES ('Quantum Computing');
INSERT INTO courses (course_name) VALUES ('RCC Design');
INSERT INTO courses (course_name) VALUES ('RF Engineering');
INSERT INTO courses (course_name) VALUES ('Radar Systems');
INSERT INTO courses (course_name) VALUES ('Real Time Systems');
INSERT INTO courses (course_name) VALUES ('Recommender Systems');
INSERT INTO courses (course_name) VALUES ('Refrigeration and AC');
INSERT INTO courses (course_name) VALUES ('Rehabilitation Engineering');
INSERT INTO courses (course_name) VALUES ('Remote Sensing');
INSERT INTO courses (course_name) VALUES ('Renewable Energy Systems');
INSERT INTO courses (course_name) VALUES ('Research Methodology');
INSERT INTO courses (course_name) VALUES ('Retrofitting Techniques');
INSERT INTO courses (course_name) VALUES ('Robotics');
INSERT INTO courses (course_name) VALUES ('Robotics Fundamentals');
INSERT INTO courses (course_name) VALUES ('Robotics and Automation');
INSERT INTO courses (course_name) VALUES ('Sanitary Engineering');
INSERT INTO courses (course_name) VALUES ('Satellite Communication');
INSERT INTO courses (course_name) VALUES ('Satellite Navigation');
INSERT INTO courses (course_name) VALUES ('Serverless Computing');
INSERT INTO courses (course_name) VALUES ('Service Oriented Architecture');
INSERT INTO courses (course_name) VALUES ('Signal Processing');
INSERT INTO courses (course_name) VALUES ('Signal Theory');
INSERT INTO courses (course_name) VALUES ('Signal and Systems');
INSERT INTO courses (course_name) VALUES ('Simulation Tools');
INSERT INTO courses (course_name) VALUES ('Smart Grid Technology');
INSERT INTO courses (course_name) VALUES ('Smart Sensors');
INSERT INTO courses (course_name) VALUES ('Social Network Analysis');
INSERT INTO courses (course_name) VALUES ('Soft Skills');
INSERT INTO courses (course_name) VALUES ('Software Architecture');
INSERT INTO courses (course_name) VALUES ('Software Capstone');
INSERT INTO courses (course_name) VALUES ('Software Engineering');
INSERT INTO courses (course_name) VALUES ('Software Metrics');
INSERT INTO courses (course_name) VALUES ('Software Project Management');
INSERT INTO courses (course_name) VALUES ('Software Reliability');
INSERT INTO courses (course_name) VALUES ('Software Testing');
INSERT INTO courses (course_name) VALUES ('Soil Investigation');
INSERT INTO courses (course_name) VALUES ('Soil Mechanics');
INSERT INTO courses (course_name) VALUES ('Special Electrical Machines');
INSERT INTO courses (course_name) VALUES ('Startup Ecosystem');
INSERT INTO courses (course_name) VALUES ('Steel Structures');
INSERT INTO courses (course_name) VALUES ('Strength of Materials');
INSERT INTO courses (course_name) VALUES ('Structural Analysis');
INSERT INTO courses (course_name) VALUES ('Structural Design');
INSERT INTO courses (course_name) VALUES ('Structural Drawing');
INSERT INTO courses (course_name) VALUES ('Supply Chain Management');
INSERT INTO courses (course_name) VALUES ('Surveying');
INSERT INTO courses (course_name) VALUES ('Sustainable Buildings');
INSERT INTO courses (course_name) VALUES ('Switchgear and Protection');
INSERT INTO courses (course_name) VALUES ('System Design');
INSERT INTO courses (course_name) VALUES ('Technical Communication');
INSERT INTO courses (course_name) VALUES ('Technical Entrepreneurship');
INSERT INTO courses (course_name) VALUES ('Technical Writing');
INSERT INTO courses (course_name) VALUES ('Testing and QA');
INSERT INTO courses (course_name) VALUES ('Theory of Computation');
INSERT INTO courses (course_name) VALUES ('Theory of Machines');
INSERT INTO courses (course_name) VALUES ('Thermodynamics');
INSERT INTO courses (course_name) VALUES ('Tissue Engineering');
INSERT INTO courses (course_name) VALUES ('Town Planning');
INSERT INTO courses (course_name) VALUES ('Traffic Engineering');
INSERT INTO courses (course_name) VALUES ('Transportation Engineering');
INSERT INTO courses (course_name) VALUES ('Tribology');
INSERT INTO courses (course_name) VALUES ('Underground Structures');
INSERT INTO courses (course_name) VALUES ('Urban Planning');
INSERT INTO courses (course_name) VALUES ('VLSI Design');
INSERT INTO courses (course_name) VALUES ('VLSI Testing');
INSERT INTO courses (course_name) VALUES ('Vibrations and Noise');
INSERT INTO courses (course_name) VALUES ('Waste Water Management');
INSERT INTO courses (course_name) VALUES ('Water Resources');
INSERT INTO courses (course_name) VALUES ('Water Supply Engineering');
INSERT INTO courses (course_name) VALUES ('Web Development');
INSERT INTO courses (course_name) VALUES ('Web Technologies');
INSERT INTO courses (course_name) VALUES ('Welding Technology');
INSERT INTO courses (course_name) VALUES ('Wireless Networks');
INSERT INTO courses (course_name) VALUES ('Workshop');
INSERT INTO courses (course_name) VALUES ('Workshop Practice');

-- ============================================================
-- TABLE: student_courses  (many-to-many)
-- ============================================================
CREATE TABLE student_courses (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  VARCHAR(20) NOT NULL,
    course_id   INT         NOT NULL,
    CONSTRAINT fk_sc_student FOREIGN KEY (student_id) REFERENCES students(student_id),
    CONSTRAINT fk_sc_course  FOREIGN KEY (course_id)  REFERENCES courses(course_id),
    UNIQUE KEY uq_student_course (student_id, course_id)
);

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX idx_students_dept     ON students (department_id);
CREATE INDEX idx_students_year     ON students (year);
CREATE INDEX idx_students_status   ON students (status);
CREATE INDEX idx_students_gpa      ON students (gpa);
CREATE INDEX idx_addresses_city    ON addresses (city);
CREATE INDEX idx_addresses_state   ON addresses (state);

-- ============================================================
-- INSERT: students
-- ============================================================
INSERT INTO students VALUES ('GIT-2024-001', 'Aarav Sharma', 20, 'Male', '2004-03-15', 'aarav.sharma@git.edu.in', '+91-9876543201', 3, 2, 3, 2023, 8.7, 91.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-002', 'Priya Nair', 21, 'Female', '2003-07-22', 'priya.nair@git.edu.in', '+91-9876543202', 5, 3, 5, 2022, 9.1, 95.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-003', 'Rohan Mehta', 19, 'Male', '2005-01-10', 'rohan.mehta@git.edu.in', '+91-9876543203', 7, 1, 2, 2024, 7.4, 83.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-004', 'Sneha Iyer', 22, 'Female', '2002-11-05', 'sneha.iyer@git.edu.in', '+91-9876543204', 6, 4, 7, 2021, 9.4, 97.2, 'Active');
INSERT INTO students VALUES ('GIT-2024-005', 'Karan Singh', 20, 'Male', '2004-05-19', 'karan.singh@git.edu.in', '+91-9876543205', 2, 2, 4, 2023, 7.8, 88.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-006', 'Ananya Reddy', 21, 'Female', '2003-09-30', 'ananya.reddy@git.edu.in', '+91-9876543206', 3, 3, 5, 2022, 8.9, 92.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-007', 'Dev Patel', 20, 'Male', '2004-02-28', 'dev.patel@git.edu.in', '+91-9876543207', 4, 2, 3, 2023, 8.2, 89.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-008', 'Meera Joshi', 22, 'Female', '2002-06-14', 'meera.joshi@git.edu.in', '+91-9876543208', 6, 4, 8, 2021, 8.6, 90.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-009', 'Arjun Kumar', 19, 'Male', '2005-04-03', 'arjun.kumar@git.edu.in', '+91-9876543209', 3, 1, 1, 2024, 7.9, 85.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-010', 'Kavya Menon', 21, 'Female', '2003-12-20', 'kavya.menon@git.edu.in', '+91-9876543210', 1, 3, 6, 2022, 9.0, 96.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-011', 'Rahul Desai', 20, 'Male', '2004-08-11', 'rahul.desai@git.edu.in', '+91-9876543211', 7, 2, 4, 2023, 7.6, 84.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-012', 'Ishita Bose', 22, 'Female', '2002-03-27', 'ishita.bose@git.edu.in', '+91-9876543212', 5, 4, 7, 2021, 8.8, 93.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-013', 'Vikram Rao', 21, 'Male', '2003-10-08', 'vikram.rao@git.edu.in', '+91-9876543213', 2, 3, 5, 2022, 8.0, 87.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-014', 'Pooja Gupta', 19, 'Female', '2005-06-17', 'pooja.gupta@git.edu.in', '+91-9876543214', 3, 1, 2, 2024, 8.3, 90.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-015', 'Nikhil Verma', 20, 'Male', '2004-12-02', 'nikhil.verma@git.edu.in', '+91-9876543215', 4, 2, 3, 2023, 7.5, 82.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-016', 'Tanya Khanna', 21, 'Female', '2003-04-25', 'tanya.khanna@git.edu.in', '+91-9876543216', 6, 3, 6, 2022, 8.5, 91.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-017', 'Siddharth Pillai', 22, 'Male', '2002-09-13', 'siddharth.pillai@git.edu.in', '+91-9876543217', 1, 4, 8, 2021, 8.4, 88.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-018', 'Divya Shukla', 20, 'Female', '2004-07-07', 'divya.shukla@git.edu.in', '+91-9876543218', 3, 2, 4, 2023, 8.1, 89.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-019', 'Harsh Agarwal', 19, 'Male', '2005-02-14', 'harsh.agarwal@git.edu.in', '+91-9876543219', 7, 1, 1, 2024, 6.9, 78.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-020', 'Riya Chatterjee', 21, 'Female', '2003-11-29', 'riya.chatterjee@git.edu.in', '+91-9876543220', 5, 3, 5, 2022, 8.7, 93.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-021', 'Aditya Bhatt', 20, 'Male', '2004-01-23', 'aditya.bhatt@git.edu.in', '+91-9876543221', 2, 2, 3, 2023, 7.3, 81.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-022', 'Simran Kaur', 22, 'Female', '2002-08-16', 'simran.kaur@git.edu.in', '+91-9876543222', 3, 4, 7, 2021, 9.2, 96.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-023', 'Manish Tiwari', 20, 'Male', '2004-10-05', 'manish.tiwari@git.edu.in', '+91-9876543223', 4, 2, 4, 2023, 7.7, 86.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-024', 'Shruti Pandey', 21, 'Female', '2003-05-11', 'shruti.pandey@git.edu.in', '+91-9876543224', 6, 3, 5, 2022, 8.0, 88.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-025', 'Yash Malhotra', 19, 'Male', '2005-03-21', 'yash.malhotra@git.edu.in', '+91-9876543225', 7, 1, 2, 2024, 7.2, 80.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-026', 'Nandini Kulkarni', 20, 'Female', '2004-09-09', 'nandini.kulkarni@git.edu.in', '+91-9876543226', 1, 2, 3, 2023, 8.6, 93.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-027', 'Dhruv Saxena', 22, 'Male', '2002-07-04', 'dhruv.saxena@git.edu.in', '+91-9876543227', 3, 4, 8, 2021, 8.3, 90.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-028', 'Anjali Srivastava', 21, 'Female', '2003-01-18', 'anjali.srivastava@git.edu.in', '+91-9876543228', 5, 3, 6, 2022, 8.5, 92.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-029', 'Sumit Das', 20, 'Male', '2004-04-30', 'sumit.das@git.edu.in', '+91-9876543229', 2, 2, 4, 2023, 7.1, 79.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-030', 'Asha Thomas', 22, 'Female', '2002-02-07', 'asha.thomas@git.edu.in', '+91-9876543230', 6, 4, 8, 2021, 9.3, 97.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-031', 'Rajat Mishra', 19, 'Male', '2005-05-26', 'rajat.mishra@git.edu.in', '+91-9876543231', 4, 1, 1, 2024, 7.0, 77.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-032', 'Varsha Naik', 21, 'Female', '2003-08-19', 'varsha.naik@git.edu.in', '+91-9876543232', 3, 3, 5, 2022, 8.2, 87.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-033', 'Kiran Hegde', 20, 'Male', '2004-11-12', 'kiran.hegde@git.edu.in', '+91-9876543233', 7, 2, 3, 2023, 7.8, 85.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-034', 'Preethi Subramanian', 21, 'Female', '2003-06-01', 'preethi.subramanian@git.edu.in', '+91-9876543234', 1, 3, 5, 2022, 9.1, 95.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-035', 'Abhinav Tripathi', 22, 'Male', '2002-04-14', 'abhinav.tripathi@git.edu.in', '+91-9876543235', 2, 4, 7, 2021, 8.0, 86.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-036', 'Deepika Choudhary', 20, 'Female', '2004-03-08', 'deepika.choudhary@git.edu.in', '+91-9876543236', 5, 2, 4, 2023, 8.4, 91.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-037', 'Gaurav Jain', 19, 'Male', '2005-01-31', 'gaurav.jain@git.edu.in', '+91-9876543237', 3, 1, 2, 2024, 7.6, 83.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-038', 'Lakshmi Gopalan', 22, 'Female', '2002-12-23', 'lakshmi.gopalan@git.edu.in', '+91-9876543238', 6, 4, 7, 2021, 8.9, 94.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-039', 'Nitin Pawar', 21, 'Male', '2003-07-11', 'nitin.pawar@git.edu.in', '+91-9876543239', 4, 3, 6, 2022, 7.9, 85.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-040', 'Ritika Bansal', 20, 'Female', '2004-10-17', 'ritika.bansal@git.edu.in', '+91-9876543240', 7, 2, 4, 2023, 7.4, 82.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-041', 'Aakash Nambiar', 21, 'Male', '2003-02-24', 'aakash.nambiar@git.edu.in', '+91-9876543241', 3, 3, 6, 2022, 8.8, 92.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-042', 'Sonali Wagh', 20, 'Female', '2004-06-06', 'sonali.wagh@git.edu.in', '+91-9876543242', 2, 2, 3, 2023, 7.5, 83.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-043', 'Pranav Kelkar', 22, 'Male', '2002-09-28', 'pranav.kelkar@git.edu.in', '+91-9876543243', 1, 4, 8, 2021, 8.7, 91.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-044', 'Harini Venkatesh', 19, 'Female', '2005-07-15', 'harini.venkatesh@git.edu.in', '+91-9876543244', 5, 1, 1, 2024, 8.0, 88.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-045', 'Ankit Rawat', 20, 'Male', '2004-02-03', 'ankit.rawat@git.edu.in', '+91-9876543245', 7, 2, 3, 2023, 7.3, 80.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-046', 'Amrita Deshpande', 21, 'Female', '2003-11-11', 'amrita.deshpande@git.edu.in', '+91-9876543246', 3, 3, 5, 2022, 8.6, 90.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-047', 'Tejas Ghosh', 22, 'Male', '2002-08-07', 'tejas.ghosh@git.edu.in', '+91-9876543247', 4, 4, 8, 2021, 8.1, 87.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-048', 'Sunaina Pillai', 20, 'Female', '2004-04-14', 'sunaina.pillai@git.edu.in', '+91-9876543248', 6, 2, 3, 2023, 8.3, 90.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-049', 'Vivek Chandra', 19, 'Male', '2005-09-26', 'vivek.chandra@git.edu.in', '+91-9876543249', 2, 1, 2, 2024, 6.8, 75.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-050', 'Rekha Patil', 21, 'Female', '2003-10-20', 'rekha.patil@git.edu.in', '+91-9876543250', 1, 3, 5, 2022, 8.9, 94.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-051', 'Saurabh Kapoor', 20, 'Male', '2004-12-29', 'saurabh.kapoor@git.edu.in', '+91-9876543251', 3, 2, 3, 2023, 7.9, 86.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-052', 'Pallavi Shetty', 22, 'Female', '2002-06-09', 'pallavi.shetty@git.edu.in', '+91-9876543252', 5, 4, 7, 2021, 9.0, 96.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-053', 'Tanmay Bendre', 21, 'Male', '2003-03-16', 'tanmay.bendre@git.edu.in', '+91-9876543253', 7, 3, 5, 2022, 8.0, 87.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-054', 'Swati Nene', 20, 'Female', '2004-08-03', 'swati.nene@git.edu.in', '+91-9876543254', 2, 2, 4, 2023, 7.7, 84.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-055', 'Rohit Dandavate', 19, 'Male', '2005-11-22', 'rohit.dandavate@git.edu.in', '+91-9876543255', 4, 1, 2, 2024, 7.1, 79.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-056', 'Mrunali Gaikwad', 21, 'Female', '2003-09-05', 'mrunali.gaikwad@git.edu.in', '+91-9876543256', 6, 3, 6, 2022, 8.4, 91.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-057', 'Sagar More', 22, 'Male', '2002-04-27', 'sagar.more@git.edu.in', '+91-9876543257', 3, 4, 7, 2021, 8.5, 89.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-058', 'Archana Kale', 20, 'Female', '2004-07-21', 'archana.kale@git.edu.in', '+91-9876543258', 1, 2, 4, 2023, 8.7, 93.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-059', 'Pratik Joshi', 21, 'Male', '2003-12-04', 'pratik.joshi@git.edu.in', '+91-9876543259', 5, 3, 5, 2022, 8.2, 88.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-060', 'Shalini Kadam', 22, 'Female', '2002-02-18', 'shalini.kadam@git.edu.in', '+91-9876543260', 7, 4, 8, 2021, 8.3, 90.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-061', 'Avinash Borkar', 20, 'Male', '2004-01-08', 'avinash.borkar@git.edu.in', '+91-9876543261', 2, 2, 3, 2023, 7.6, 83.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-062', 'Komal Sawant', 19, 'Female', '2005-05-14', 'komal.sawant@git.edu.in', '+91-9876543262', 3, 1, 1, 2024, 7.8, 86.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-063', 'Milind Bhosale', 21, 'Male', '2003-08-31', 'milind.bhosale@git.edu.in', '+91-9876543263', 4, 3, 5, 2022, 7.8, 85.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-064', 'Neha Jadhav', 20, 'Female', '2004-11-28', 'neha.jadhav@git.edu.in', '+91-9876543264', 6, 2, 4, 2023, 8.0, 87.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-065', 'Sachin Londhe', 22, 'Male', '2002-06-23', 'sachin.londhe@git.edu.in', '+91-9876543265', 1, 4, 8, 2021, 8.6, 92.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-066', 'Ruchita Shirke', 21, 'Female', '2003-10-14', 'ruchita.shirke@git.edu.in', '+91-9876543266', 5, 3, 6, 2022, 8.6, 92.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-067', 'Akshay Khandagale', 20, 'Male', '2004-03-26', 'akshay.khandagale@git.edu.in', '+91-9876543267', 3, 2, 4, 2023, 7.7, 84.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-068', 'Supriya Mane', 19, 'Female', '2005-04-19', 'supriya.mane@git.edu.in', '+91-9876543268', 7, 1, 1, 2024, 7.4, 81.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-069', 'Amol Takle', 21, 'Male', '2003-07-07', 'amol.takle@git.edu.in', '+91-9876543269', 2, 3, 5, 2022, 7.9, 86.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-070', 'Tejashri Kulkarni', 22, 'Female', '2002-12-30', 'tejashri.kulkarni@git.edu.in', '+91-9876543270', 6, 4, 8, 2021, 9.1, 95.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-071', 'Omkar Parab', 20, 'Male', '2004-02-16', 'omkar.parab@git.edu.in', '+91-9876543271', 4, 2, 3, 2023, 7.5, 81.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-072', 'Yogita Bhave', 21, 'Female', '2003-05-28', 'yogita.bhave@git.edu.in', '+91-9876543272', 3, 3, 5, 2022, 8.4, 90.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-073', 'Sumit Khandare', 22, 'Male', '2002-10-10', 'sumit.khandare@git.edu.in', '+91-9876543273', 1, 4, 7, 2021, 8.8, 93.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-074', 'Ashwini Zore', 19, 'Female', '2005-06-25', 'ashwini.zore@git.edu.in', '+91-9876543274', 5, 1, 2, 2024, 7.9, 87.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-075', 'Prasad Divekar', 20, 'Male', '2004-09-18', 'prasad.divekar@git.edu.in', '+91-9876543275', 7, 2, 4, 2023, 7.6, 83.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-076', 'Manasi Lad', 21, 'Female', '2003-01-27', 'manasi.lad@git.edu.in', '+91-9876543276', 2, 3, 5, 2022, 7.8, 85.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-077', 'Siddesh Naik', 22, 'Male', '2002-07-19', 'siddesh.naik@git.edu.in', '+91-9876543277', 3, 4, 8, 2021, 8.1, 88.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-078', 'Sujata Chougule', 20, 'Female', '2004-04-11', 'sujata.chougule@git.edu.in', '+91-9876543278', 1, 2, 3, 2023, 8.3, 91.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-079', 'Prathamesh Salvi', 19, 'Male', '2005-12-08', 'prathamesh.salvi@git.edu.in', '+91-9876543279', 6, 1, 1, 2024, 7.5, 82.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-080', 'Dipali Bagal', 21, 'Female', '2003-02-13', 'dipali.bagal@git.edu.in', '+91-9876543280', 4, 3, 6, 2022, 7.7, 84.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-081', 'Onkar Mhatre', 20, 'Male', '2004-10-01', 'onkar.mhatre@git.edu.in', '+91-9876543281', 5, 2, 4, 2023, 7.9, 86.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-082', 'Renuka Pisal', 22, 'Female', '2002-05-30', 'renuka.pisal@git.edu.in', '+91-9876543282', 7, 4, 7, 2021, 8.2, 89.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-083', 'Harsh Shinde', 21, 'Male', '2003-09-22', 'harsh.shinde@git.edu.in', '+91-9876543283', 2, 3, 6, 2022, 7.4, 80.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-084', 'Gayatri Jagtap', 20, 'Female', '2004-08-09', 'gayatri.jagtap@git.edu.in', '+91-9876543284', 3, 2, 3, 2023, 8.0, 88.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-085', 'Nilesh Sutar', 19, 'Male', '2005-03-05', 'nilesh.sutar@git.edu.in', '+91-9876543285', 1, 1, 2, 2024, 7.2, 79.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-086', 'Smita Gore', 21, 'Female', '2003-11-17', 'smita.gore@git.edu.in', '+91-9876543286', 6, 3, 5, 2022, 8.2, 89.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-087', 'Abhijit Padale', 22, 'Male', '2002-03-12', 'abhijit.padale@git.edu.in', '+91-9876543287', 4, 4, 8, 2021, 7.9, 86.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-088', 'Vrushali Kumbhar', 20, 'Female', '2004-06-20', 'vrushali.kumbhar@git.edu.in', '+91-9876543288', 5, 2, 4, 2023, 8.1, 89.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-089', 'Vikas Bandal', 21, 'Male', '2003-04-09', 'vikas.bandal@git.edu.in', '+91-9876543289', 7, 3, 5, 2022, 7.6, 83.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-090', 'Pooja Raut', 22, 'Female', '2002-01-15', 'pooja.raut@git.edu.in', '+91-9876543290', 2, 4, 8, 2021, 8.1, 87.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-091', 'Gauresh Marathe', 20, 'Male', '2004-12-08', 'gauresh.marathe@git.edu.in', '+91-9876543291', 3, 2, 4, 2023, 7.8, 85.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-092', 'Snehal Pawar', 21, 'Female', '2003-06-16', 'snehal.pawar@git.edu.in', '+91-9876543292', 1, 3, 5, 2022, 8.5, 93.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-093', 'Swaroop Kulthe', 19, 'Male', '2005-08-27', 'swaroop.kulthe@git.edu.in', '+91-9876543293', 5, 1, 1, 2024, 7.3, 80.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-094', 'Madhura Bhide', 22, 'Female', '2002-11-02', 'madhura.bhide@git.edu.in', '+91-9876543294', 6, 4, 7, 2021, 8.8, 93.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-095', 'Dhananjay Shinde', 20, 'Male', '2004-05-07', 'dhananjay.shinde@git.edu.in', '+91-9876543295', 4, 2, 4, 2023, 7.4, 81.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-096', 'Priyanka Thakur', 21, 'Female', '2003-03-23', 'priyanka.thakur@git.edu.in', '+91-9876543296', 7, 3, 5, 2022, 8.1, 88.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-097', 'Bhushan Chavan', 22, 'Male', '2002-09-01', 'bhushan.chavan@git.edu.in', '+91-9876543297', 2, 4, 8, 2021, 7.9, 85.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-098', 'Aishwarya Bapat', 20, 'Female', '2004-07-26', 'aishwarya.bapat@git.edu.in', '+91-9876543298', 3, 2, 3, 2023, 8.4, 91.5, 'Active');
INSERT INTO students VALUES ('GIT-2024-099', 'Krunal Yadav', 19, 'Male', '2005-10-14', 'krunal.yadav@git.edu.in', '+91-9876543299', 6, 1, 2, 2024, 7.6, 83.0, 'Active');
INSERT INTO students VALUES ('GIT-2024-100', 'Rutuja Karale', 21, 'Female', '2003-08-04', 'rutuja.karale@git.edu.in', '+91-9876543300', 1, 3, 6, 2022, 9.0, 95.0, 'Active');

-- ============================================================
-- INSERT: addresses
-- ============================================================
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-001', '12, Shivaji Nagar', 'Pune', 'Maharashtra', '411005');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-002', '45, MG Road', 'Kochi', 'Kerala', '682001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-003', '8, Satellite Road', 'Ahmedabad', 'Gujarat', '380015');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-004', '23, Anna Nagar', 'Chennai', 'Tamil Nadu', '600040');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-005', '67, Sector 15', 'Chandigarh', 'Punjab', '160015');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-006', '34, Banjara Hills', 'Hyderabad', 'Telangana', '500034');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-007', '5, Navrangpura', 'Ahmedabad', 'Gujarat', '380009');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-008', '18, Deccan Gymkhana', 'Pune', 'Maharashtra', '411004');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-009', '29, Rajajinagar', 'Bengaluru', 'Karnataka', '560010');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-010', '11, Kozhikode Beach Road', 'Kozhikode', 'Kerala', '673001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-011', '56, Law College Road', 'Pune', 'Maharashtra', '411008');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-012', '72, Salt Lake City', 'Kolkata', 'West Bengal', '700091');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-013', '3, Malleshwaram', 'Bengaluru', 'Karnataka', '560003');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-014', '14, Lajpat Nagar', 'New Delhi', 'Delhi', '110024');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-015', '88, Civil Lines', 'Jaipur', 'Rajasthan', '302006');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-016', '22, Vasant Kunj', 'New Delhi', 'Delhi', '110070');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-017', '9, Thiruvananthapuram Road', 'Thiruvananthapuram', 'Kerala', '695001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-018', '61, Hazratganj', 'Lucknow', 'Uttar Pradesh', '226001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-019', '38, Sadar Bazar', 'Agra', 'Uttar Pradesh', '282003');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-020', '47, Ballygunge', 'Kolkata', 'West Bengal', '700019');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-021', '16, Navyug Market', 'Dehradun', 'Uttarakhand', '248001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-022', '99, Model Town', 'Amritsar', 'Punjab', '143001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-023', '25, Napier Town', 'Jabalpur', 'Madhya Pradesh', '482001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-024', '43, Allahabad Road', 'Varanasi', 'Uttar Pradesh', '221005');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-025', '77, Green Park', 'New Delhi', 'Delhi', '110016');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-026', '6, Tilak Road', 'Nagpur', 'Maharashtra', '440010');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-027', '52, Sarojini Nagar', 'Lucknow', 'Uttar Pradesh', '226008');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-028', '19, Kapoorthala', 'Lucknow', 'Uttar Pradesh', '226024');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-029', '84, Alipore', 'Kolkata', 'West Bengal', '700027');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-030', '31, Palarivattom', 'Ernakulam', 'Kerala', '682025');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-031', '40, Prem Nagar', 'Kanpur', 'Uttar Pradesh', '208001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-032', '53, Panaji', 'Goa', 'Goa', '403001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-033', '7, Mangalore Port', 'Mangalore', 'Karnataka', '575001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-034', '27, T Nagar', 'Chennai', 'Tamil Nadu', '600017');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-035', '65, Civil Lines', 'Prayagraj', 'Uttar Pradesh', '211001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-036', '91, MI Road', 'Jaipur', 'Rajasthan', '302001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-037', '17, Palasia', 'Indore', 'Madhya Pradesh', '452001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-038', '35, Adyar', 'Chennai', 'Tamil Nadu', '600020');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-039', '48, Camp Area', 'Pune', 'Maharashtra', '411001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-040', '73, Rajouri Garden', 'New Delhi', 'Delhi', '110027');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-041', '58, Koregaon Park', 'Pune', 'Maharashtra', '411001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-042', '21, Nashik Road', 'Nashik', 'Maharashtra', '422101');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-043', '33, Karve Road', 'Pune', 'Maharashtra', '411038');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-044', '80, Mylapore', 'Chennai', 'Tamil Nadu', '600004');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-045', '12, Rajpur Road', 'Dehradun', 'Uttarakhand', '248009');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-046', '64, Laxmi Road', 'Pune', 'Maharashtra', '411030');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-047', '11, Bhowanipore', 'Kolkata', 'West Bengal', '700025');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-048', '36, Pettah', 'Thiruvananthapuram', 'Kerala', '695024');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-049', '90, Bhopal Lake Road', 'Bhopal', 'Madhya Pradesh', '462001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-050', '4, Station Road', 'Solapur', 'Maharashtra', '413001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-051', '70, Preet Vihar', 'New Delhi', 'Delhi', '110092');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-052', '26, Udupi Main Road', 'Udupi', 'Karnataka', '576101');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-053', '55, FC Road', 'Pune', 'Maharashtra', '411004');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-054', '42, Kolhapur Main', 'Kolhapur', 'Maharashtra', '416001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-055', '15, Wakad', 'Pune', 'Maharashtra', '411057');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-056', '39, Aurangabad Road', 'Aurangabad', 'Maharashtra', '431001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-057', '28, Sangli Main', 'Sangli', 'Maharashtra', '416416');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-058', '67, Satara Road', 'Satara', 'Maharashtra', '415001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-059', '82, Kothrud', 'Pune', 'Maharashtra', '411029');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-060', '10, Pimpri', 'Pune', 'Maharashtra', '411017');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-061', '50, Ratnagiri Main', 'Ratnagiri', 'Maharashtra', '415612');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-062', '24, Thane West', 'Thane', 'Maharashtra', '400601');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-063', '37, Ahmednagar Road', 'Ahmednagar', 'Maharashtra', '414001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-064', '59, Hadapsar', 'Pune', 'Maharashtra', '411028');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-065', '71, Chembur', 'Mumbai', 'Maharashtra', '400071');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-066', '13, Rajarampuri', 'Kolhapur', 'Maharashtra', '416008');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-067', '85, Dhule Road', 'Dhule', 'Maharashtra', '424001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-068', '44, Baramati', 'Baramati', 'Maharashtra', '413102');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-069', '2, Malegaon Road', 'Nashik', 'Maharashtra', '422001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-070', '76, Prabhat Road', 'Pune', 'Maharashtra', '411004');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-071', '30, Malad West', 'Mumbai', 'Maharashtra', '400064');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-072', '46, Viman Nagar', 'Pune', 'Maharashtra', '411014');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-073', '63, Bibvewadi', 'Pune', 'Maharashtra', '411037');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-074', '8, Chinchwad', 'Pune', 'Maharashtra', '411033');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-075', '20, Yerwada', 'Pune', 'Maharashtra', '411006');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-076', '69, Wanowrie', 'Pune', 'Maharashtra', '411040');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-077', '95, Mapusa', 'Goa', 'Goa', '403507');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-078', '57, Ichalkaranji', 'Kolhapur', 'Maharashtra', '416115');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-079', '1, Bandra West', 'Mumbai', 'Maharashtra', '400050');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-080', '45, Kondhwa', 'Pune', 'Maharashtra', '411048');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-081', '32, Ulwe', 'Navi Mumbai', 'Maharashtra', '410206');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-082', '78, Alibag', 'Raigad', 'Maharashtra', '402201');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-083', '60, Akurdi', 'Pune', 'Maharashtra', '411035');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-084', '96, Manjri', 'Pune', 'Maharashtra', '412307');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-085', '23, Akluj', 'Solapur', 'Maharashtra', '413101');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-086', '14, Dapodi', 'Pune', 'Maharashtra', '411012');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-087', '49, Chiplun', 'Ratnagiri', 'Maharashtra', '415605');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-088', '5, Aundh', 'Pune', 'Maharashtra', '411007');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-089', '87, Shirur', 'Pune', 'Maharashtra', '412210');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-090', '66, Hingna Road', 'Nagpur', 'Maharashtra', '440016');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-091', '41, Bavdhan', 'Pune', 'Maharashtra', '411021');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-092', '68, Akola', 'Akola', 'Maharashtra', '444001');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-093', '53, Latur Road', 'Latur', 'Maharashtra', '413512');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-094', '18, Warje', 'Pune', 'Maharashtra', '411058');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-095', '74, Solapur Road', 'Pandharpur', 'Maharashtra', '413304');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-096', '92, Kandivali East', 'Mumbai', 'Maharashtra', '400101');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-097', '27, Beed Bypass', 'Aurangabad', 'Maharashtra', '431005');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-098', '36, Erandwane', 'Pune', 'Maharashtra', '411004');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-099', '16, Mahabaleshwar Road', 'Satara', 'Maharashtra', '415002');
INSERT INTO addresses (student_id, street, city, state, pincode) VALUES ('GIT-2024-100', '88, Khamgaon', 'Buldhana', 'Maharashtra', '444303');

-- ============================================================
-- INSERT: guardians
-- ============================================================
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-001', 'Ramesh Sharma', 'Father', '+91-9876500001');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-002', 'Sunita Nair', 'Mother', '+91-9876500002');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-003', 'Vijay Mehta', 'Father', '+91-9876500003');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-004', 'Lakshmi Iyer', 'Mother', '+91-9876500004');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-005', 'Gurpreet Singh', 'Father', '+91-9876500005');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-006', 'Suresh Reddy', 'Father', '+91-9876500006');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-007', 'Haresh Patel', 'Father', '+91-9876500007');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-008', 'Prakash Joshi', 'Father', '+91-9876500008');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-009', 'Rajesh Kumar', 'Father', '+91-9876500009');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-010', 'Krishnan Menon', 'Father', '+91-9876500010');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-011', 'Sunil Desai', 'Father', '+91-9876500011');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-012', 'Amitabh Bose', 'Father', '+91-9876500012');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-013', 'Narayan Rao', 'Father', '+91-9876500013');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-014', 'Anil Gupta', 'Father', '+91-9876500014');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-015', 'Ramkishan Verma', 'Father', '+91-9876500015');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-016', 'Sanjeev Khanna', 'Father', '+91-9876500016');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-017', 'Gopinath Pillai', 'Father', '+91-9876500017');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-018', 'Manoj Shukla', 'Father', '+91-9876500018');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-019', 'Deepak Agarwal', 'Father', '+91-9876500019');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-020', 'Subhash Chatterjee', 'Father', '+91-9876500020');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-021', 'Mahesh Bhatt', 'Father', '+91-9876500021');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-022', 'Harjinder Kaur', 'Mother', '+91-9876500022');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-023', 'Ramesh Tiwari', 'Father', '+91-9876500023');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-024', 'Vivek Pandey', 'Father', '+91-9876500024');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-025', 'Rohit Malhotra', 'Father', '+91-9876500025');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-026', 'Sanjay Kulkarni', 'Father', '+91-9876500026');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-027', 'Arun Saxena', 'Father', '+91-9876500027');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-028', 'Ramakant Srivastava', 'Father', '+91-9876500028');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-029', 'Tapan Das', 'Father', '+91-9876500029');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-030', 'George Thomas', 'Father', '+91-9876500030');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-031', 'Dinesh Mishra', 'Father', '+91-9876500031');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-032', 'Babu Naik', 'Father', '+91-9876500032');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-033', 'Pradeep Hegde', 'Father', '+91-9876500033');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-034', 'Ganesan Subramanian', 'Father', '+91-9876500034');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-035', 'Shyam Tripathi', 'Father', '+91-9876500035');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-036', 'Devendra Choudhary', 'Father', '+91-9876500036');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-037', 'Rajesh Jain', 'Father', '+91-9876500037');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-038', 'Balakrishnan Gopalan', 'Father', '+91-9876500038');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-039', 'Dattatray Pawar', 'Father', '+91-9876500039');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-040', 'Suresh Bansal', 'Father', '+91-9876500040');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-041', 'Suresh Nambiar', 'Father', '+91-9876500041');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-042', 'Bhaskar Wagh', 'Father', '+91-9876500042');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-043', 'Dilip Kelkar', 'Father', '+91-9876500043');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-044', 'Ramkumar Venkatesh', 'Father', '+91-9876500044');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-045', 'Mohan Rawat', 'Father', '+91-9876500045');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-046', 'Hemant Deshpande', 'Father', '+91-9876500046');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-047', 'Santanu Ghosh', 'Father', '+91-9876500047');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-048', 'Mohan Pillai', 'Father', '+91-9876500048');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-049', 'Suresh Chandra', 'Father', '+91-9876500049');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-050', 'Siddharam Patil', 'Father', '+91-9876500050');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-051', 'Rakesh Kapoor', 'Father', '+91-9876500051');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-052', 'Ganesh Shetty', 'Father', '+91-9876500052');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-053', 'Pramod Bendre', 'Father', '+91-9876500053');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-054', 'Sanjay Nene', 'Father', '+91-9876500054');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-055', 'Ganesh Dandavate', 'Father', '+91-9876500055');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-056', 'Baburao Gaikwad', 'Father', '+91-9876500056');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-057', 'Dattatray More', 'Father', '+91-9876500057');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-058', 'Suresh Kale', 'Father', '+91-9876500058');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-059', 'Vijay Joshi', 'Father', '+91-9876500059');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-060', 'Dilip Kadam', 'Father', '+91-9876500060');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-061', 'Ganesh Borkar', 'Father', '+91-9876500061');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-062', 'Suresh Sawant', 'Father', '+91-9876500062');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-063', 'Vitthal Bhosale', 'Father', '+91-9876500063');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-064', 'Prakash Jadhav', 'Father', '+91-9876500064');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-065', 'Shivraj Londhe', 'Father', '+91-9876500065');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-066', 'Balasaheb Shirke', 'Father', '+91-9876500066');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-067', 'Chandrakant Khandagale', 'Father', '+91-9876500067');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-068', 'Vishwas Mane', 'Father', '+91-9876500068');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-069', 'Balaji Takle', 'Father', '+91-9876500069');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-070', 'Raghunath Kulkarni', 'Father', '+91-9876500070');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-071', 'Anil Parab', 'Father', '+91-9876500071');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-072', 'Sanjay Bhave', 'Father', '+91-9876500072');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-073', 'Ashok Khandare', 'Father', '+91-9876500073');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-074', 'Popat Zore', 'Father', '+91-9876500074');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-075', 'Pandurang Divekar', 'Father', '+91-9876500075');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-076', 'Anil Lad', 'Father', '+91-9876500076');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-077', 'Babul Naik', 'Father', '+91-9876500077');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-078', 'Rajaram Chougule', 'Father', '+91-9876500078');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-079', 'Manoj Salvi', 'Father', '+91-9876500079');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-080', 'Ramesh Bagal', 'Father', '+91-9876500080');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-081', 'Dashrath Mhatre', 'Father', '+91-9876500081');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-082', 'Govind Pisal', 'Father', '+91-9876500082');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-083', 'Shashikant Shinde', 'Father', '+91-9876500083');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-084', 'Hemant Jagtap', 'Father', '+91-9876500084');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-085', 'Tukaram Sutar', 'Father', '+91-9876500085');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-086', 'Shripad Gore', 'Father', '+91-9876500086');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-087', 'Narendra Padale', 'Father', '+91-9876500087');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-088', 'Shankar Kumbhar', 'Father', '+91-9876500088');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-089', 'Dnyandev Bandal', 'Father', '+91-9876500089');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-090', 'Sudhir Raut', 'Father', '+91-9876500090');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-091', 'Vijay Marathe', 'Father', '+91-9876500091');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-092', 'Ravindra Pawar', 'Father', '+91-9876500092');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-093', 'Ashok Kulthe', 'Father', '+91-9876500093');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-094', 'Shriram Bhide', 'Father', '+91-9876500094');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-095', 'Maruti Shinde', 'Father', '+91-9876500095');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-096', 'Subhash Thakur', 'Father', '+91-9876500096');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-097', 'Dnyaneshwar Chavan', 'Father', '+91-9876500097');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-098', 'Ramakant Bapat', 'Father', '+91-9876500098');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-099', 'Sanjay Yadav', 'Father', '+91-9876500099');
INSERT INTO guardians (student_id, guardian_name, relation, phone) VALUES ('GIT-2024-100', 'Kishor Karale', 'Father', '+91-9876500100');

-- ============================================================
-- INSERT: student_courses
-- ============================================================
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-001', 91);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-001', 18);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-001', 95);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-001', 251);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-002', 305);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-002', 134);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-002', 348);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-002', 65);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-003', 143);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-003', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-003', 359);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-003', 31);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-004', 211);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-004', 61);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-004', 84);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-004', 315);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-005', 326);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-005', 161);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-005', 330);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-005', 151);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-006', 24);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-006', 354);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-006', 73);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-006', 319);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-007', 56);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-007', 125);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-007', 266);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-007', 82);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-008', 46);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-008', 90);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-008', 238);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-008', 32);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-009', 50);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-009', 144);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-009', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-009', 66);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-010', 227);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-010', 39);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-010', 178);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-010', 305);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-011', 340);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-011', 213);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-011', 215);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-011', 209);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-012', 104);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-012', 22);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-012', 235);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-012', 199);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-013', 170);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-013', 344);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-013', 185);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-013', 76);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-014', 51);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-014', 144);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-014', 138);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-014', 66);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-015', 20);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-015', 106);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-015', 129);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-015', 232);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-016', 242);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-016', 75);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-016', 115);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-016', 101);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-017', 35);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-017', 58);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-017', 226);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-017', 292);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-018', 250);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-018', 71);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-018', 112);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-018', 338);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-019', 139);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-019', 144);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-019', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-019', 197);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-020', 287);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-020', 109);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-020', 253);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-020', 357);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-021', 48);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-021', 325);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-021', 321);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-021', 141);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-022', 98);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-022', 285);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-022', 68);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-022', 4);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-023', 245);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-023', 126);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-023', 263);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-023', 188);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-024', 184);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-024', 193);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-024', 150);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-024', 93);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-025', 139);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-025', 28);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-025', 138);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-025', 359);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-026', 183);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-026', 33);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-026', 37);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-026', 225);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-027', 192);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-027', 256);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-027', 333);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-027', 295);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-028', 301);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-028', 186);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-028', 297);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-028', 208);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-029', 200);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-029', 47);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-029', 80);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-029', 342);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-030', 8);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-030', 244);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-030', 313);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-030', 277);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-031', 144);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-031', 29);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-031', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-031', 149);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-032', 196);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-032', 25);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-032', 168);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-032', 85);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-033', 161);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-033', 190);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-033', 118);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-033', 222);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-034', 246);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-034', 116);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-034', 239);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-034', 181);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-035', 14);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-035', 352);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-035', 347);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-035', 120);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-036', 131);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-036', 231);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-036', 105);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-036', 67);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-037', 282);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-037', 145);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-037', 107);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-037', 154);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-038', 311);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-038', 62);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-038', 2);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-038', 17);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-039', 180);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-039', 122);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-039', 294);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-039', 309);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-040', 214);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-040', 26);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-040', 291);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-040', 252);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-041', 299);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-041', 72);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-041', 166);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-041', 234);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-042', 23);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-042', 77);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-042', 353);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-042', 328);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-043', 341);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-043', 241);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-043', 176);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-043', 155);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-044', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-044', 217);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-044', 29);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-044', 148);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-045', 339);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-045', 271);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-045', 179);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-045', 70);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-046', 317);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-046', 337);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-046', 236);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-046', 171);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-047', 124);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-047', 265);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-047', 135);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-047', 173);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-048', 355);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-048', 97);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-048', 91);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-048', 251);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-049', 139);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-049', 27);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-049', 216);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-049', 259);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-050', 229);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-050', 45);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-050', 57);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-050', 261);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-051', 91);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-051', 206);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-051', 249);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-051', 269);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-052', 6);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-052', 99);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-052', 174);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-052', 156);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-053', 158);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-053', 191);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-053', 350);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-053', 345);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-054', 327);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-054', 300);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-054', 343);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-054', 79);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-055', 218);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-055', 28);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-055', 260);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-055', 187);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-056', 267);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-056', 237);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-056', 316);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-056', 304);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-057', 318);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-057', 163);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-057', 289);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-057', 121);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-058', 21);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-058', 44);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-058', 224);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-058', 175);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-059', 81);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-059', 310);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-059', 262);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-059', 288);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-060', 3);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-060', 270);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-060', 136);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-060', 279);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-061', 286);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-061', 320);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-061', 278);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-061', 153);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-062', 198);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-062', 217);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-062', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-062', 64);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-063', 322);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-063', 195);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-063', 88);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-063', 255);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-064', 73);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-064', 315);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-064', 202);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-064', 219);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-065', 43);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-065', 280);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-065', 60);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-065', 228);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-066', 11);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-066', 349);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-066', 258);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-066', 302);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-067', 18);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-067', 74);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-067', 201);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-067', 268);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-068', 139);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-068', 53);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-068', 217);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-068', 223);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-069', 9);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-069', 78);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-069', 324);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-069', 293);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-070', 1);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-070', 303);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-070', 7);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-070', 335);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-071', 54);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-071', 128);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-071', 243);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-071', 146);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-072', 205);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-072', 165);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-072', 86);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-072', 69);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-073', 103);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-073', 41);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-073', 247);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-073', 182);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-074', 140);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-074', 218);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-074', 133);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-074', 272);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-075', 117);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-075', 210);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-075', 142);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-075', 30);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-076', 284);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-076', 63);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-076', 111);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-076', 167);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-077', 114);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-077', 75);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-077', 290);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-077', 314);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-078', 52);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-078', 40);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-078', 102);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-078', 160);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-079', 273);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-079', 113);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-079', 259);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-079', 66);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-080', 123);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-080', 332);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-080', 307);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-080', 298);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-081', 19);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-081', 306);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-081', 254);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-081', 308);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-082', 204);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-082', 283);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-082', 329);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-082', 276);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-083', 164);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-083', 152);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-083', 194);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-083', 159);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-084', 92);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-084', 72);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-084', 221);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-084', 312);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-085', 36);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-085', 220);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-085', 259);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-085', 358);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-086', 119);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-086', 212);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-086', 108);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-086', 96);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-087', 13);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-087', 137);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-087', 230);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-087', 157);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-088', 89);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-088', 130);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-088', 64);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-088', 110);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-089', 264);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-089', 16);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-089', 356);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-089', 5);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-090', 296);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-090', 331);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-090', 346);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-090', 275);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-091', 100);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-091', 87);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-091', 233);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-091', 221);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-092', 38);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-092', 59);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-092', 34);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-092', 257);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-093', 217);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-093', 147);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-093', 29);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-093', 359);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-094', 49);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-094', 203);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-094', 334);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-094', 323);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-095', 127);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-095', 55);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-095', 132);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-095', 207);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-096', 248);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-096', 162);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-096', 189);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-096', 10);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-097', 172);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-097', 351);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-097', 15);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-097', 157);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-098', 281);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-098', 94);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-098', 83);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-098', 336);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-099', 274);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-099', 216);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-099', 53);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-099', 240);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-100', 12);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-100', 42);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-100', 169);
INSERT INTO student_courses (student_id, course_id) VALUES ('GIT-2024-100', 177);

-- ============================================================
-- SAMPLE / USEFUL QUERIES
-- ============================================================

-- 1. All students with department name
SELECT s.student_id, s.full_name, d.department_name, s.year, s.semester, s.gpa, s.status
FROM students s
JOIN departments d ON s.department_id = d.department_id
ORDER BY s.student_id;

-- 2. Student full profile (with address and guardian)
SELECT s.student_id, s.full_name, s.email, s.phone,
       d.department_name, s.year, s.semester, s.gpa, s.attendance_percentage,
       a.street, a.city, a.state, a.pincode,
       g.guardian_name, g.relation, g.phone AS guardian_phone
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN addresses  a ON s.student_id = a.student_id
JOIN guardians  g ON s.student_id = g.student_id
ORDER BY s.student_id;

-- 3. Top 10 students by GPA
SELECT s.student_id, s.full_name, d.department_name, s.gpa
FROM students s
JOIN departments d ON s.department_id = d.department_id
ORDER BY s.gpa DESC
LIMIT 10;

-- 4. Student count per department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
GROUP BY d.department_name
ORDER BY total_students DESC;

-- 5. Average GPA per department
SELECT d.department_name,
       ROUND(AVG(s.gpa), 2) AS avg_gpa,
       ROUND(AVG(s.attendance_percentage), 2) AS avg_attendance
FROM students s
JOIN departments d ON s.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_gpa DESC;

-- 6. Students with attendance below 80%
SELECT s.student_id, s.full_name, d.department_name, s.attendance_percentage
FROM students s
JOIN departments d ON s.department_id = d.department_id
WHERE s.attendance_percentage < 80
ORDER BY s.attendance_percentage ASC;

-- 7. Courses enrolled per student
SELECT s.student_id, s.full_name, GROUP_CONCAT(c.course_name ORDER BY c.course_name SEPARATOR ', ') AS courses
FROM students s
JOIN student_courses sc ON s.student_id = sc.student_id
JOIN courses c ON sc.course_id = c.course_id
GROUP BY s.student_id, s.full_name
ORDER BY s.student_id;

-- 8. Students from a specific city (example: Pune)
SELECT s.student_id, s.full_name, d.department_name, a.city
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN addresses  a ON s.student_id = a.student_id
WHERE a.city = 'Pune'
ORDER BY s.full_name;

-- 9. Year-wise student distribution
SELECT s.year, COUNT(*) AS total_students,
       ROUND(AVG(s.gpa), 2) AS avg_gpa
FROM students s
GROUP BY s.year
ORDER BY s.year;

-- 10. Most popular courses (enrolled by most students)
SELECT c.course_name, COUNT(sc.student_id) AS enrolled_students
FROM courses c
JOIN student_courses sc ON c.course_id = sc.course_id
GROUP BY c.course_name
ORDER BY enrolled_students DESC
LIMIT 15;
