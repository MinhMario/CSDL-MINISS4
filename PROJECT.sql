CREATE DATABASE STUDENT;
USE STUDENT;

-- Bảng Sinh viên
CREATE TABLE Student (
    student_id   INT          PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    birth_date   DATE,
    email        VARCHAR(100) UNIQUE
);

-- Bảng Giảng viên
CREATE TABLE Teacher (
    teacher_id   INT          PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(100) UNIQUE
);

-- Bảng Khóa học
CREATE TABLE Course (
    course_id          INT          PRIMARY KEY,
    course_name        VARCHAR(100) NOT NULL,
    course_description VARCHAR(255),
    course_length      INT,
    teacher_id         INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- Bảng Đăng ký học
CREATE TABLE Enrollment (
    student_id       INT  NOT NULL,
    course_id        INT  NOT NULL,
    enrollment_date  DATE,
    PRIMARY KEY (student_id, course_id),          -- chống đăng ký trùng
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
);

-- Bảng Kết quả học tập
CREATE TABLE Score (
    student_id  INT            NOT NULL,
    course_id   INT            NOT NULL,
    mid_score   DECIMAL(4,2)   CHECK (mid_score  >= 0 AND mid_score  <= 10), 
    final       DECIMAL(4,2)   CHECK (final      >= 0 AND final      <= 10),
    PRIMARY KEY (student_id, course_id),          --  mỗi SV chỉ có 1 kết quả/khóa học
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
);


-- Thêm 5 giảng viên
INSERT INTO Teacher (teacher_id, full_name, email) VALUES
(1, 'Nguyễn Văn An',   'an.nguyen@edu.vn'),
(2, 'Trần Thị Bình',   'binh.tran@edu.vn'),
(3, 'Lê Minh Châu',    'chau.le@edu.vn'),
(4, 'Phạm Quốc Dũng',  'dung.pham@edu.vn'),
(5, 'Hoàng Thị Em',    'em.hoang@edu.vn');

-- Thêm 5 sinh viên
INSERT INTO Student (student_id, full_name, birth_date, email) VALUES
(1, 'Nguyễn Thị Hoa',  '2002-03-15', 'hoa.nguyen@gmail.com'),
(2, 'Trần Văn Khoa',   '2001-07-22', 'khoa.tran@gmail.com'),
(3, 'Lê Thị Lan',      '2003-01-10', 'lan.le@gmail.com'),
(4, 'Phạm Minh Long',  '2002-11-05', 'long.pham@gmail.com'),
(5, 'Đỗ Thị Mai',      '2001-09-30', 'mai.do@gmail.com');

-- Thêm 5 khóa học
INSERT INTO Course (course_id, course_name, course_description, course_length, teacher_id) VALUES
(1, 'Lập trình Python',      'Khóa học Python cơ bản đến nâng cao',  30, 1),
(2, 'Cơ sở dữ liệu',         'MySQL và thiết kế CSDL quan hệ',       24, 2),
(3, 'Lập trình Web',         'HTML, CSS, JavaScript cơ bản',         36, 3),
(4, 'Trí tuệ nhân tạo',      'Nhập môn Machine Learning',            40, 4),
(5, 'Mạng máy tính',         'Giao thức TCP/IP và bảo mật mạng',     28, 5);

-- Thêm dữ liệu đăng ký học
INSERT INTO Enrollment (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-10'),
(1, 2, '2024-01-10'),
(2, 1, '2024-01-11'),
(2, 3, '2024-01-11'),
(3, 2, '2024-01-12'),
(3, 4, '2024-01-12'),
(4, 3, '2024-01-13'),
(4, 5, '2024-01-13'),
(5, 4, '2024-01-14'),
(5, 5, '2024-01-14');

-- Thêm kết quả học tập
INSERT INTO Score (student_id, course_id, mid_score, final) VALUES
(1, 1, 7.50, 8.00),
(1, 2, 6.00, 7.50),
(2, 1, 8.50, 9.00),
(2, 3, 7.00, 7.50),
(3, 2, 5.50, 6.00),
(3, 4, 8.00, 8.50),
(4, 3, 6.50, 7.00),
(4, 5, 9.00, 9.50),
(5, 4, 7.50, 8.00),
(5, 5, 6.00, 6.50);



-- Cập nhật email cho sinh viên có student_id = 1
UPDATE Student
SET    email = 'hoa.nguyen.new@gmail.com'
WHERE  student_id = 1;

-- Cập nhật mô tả cho khóa học có course_id = 3
UPDATE Course
SET    course_description = 'HTML5, CSS3, JavaScript ES6 và React cơ bản'
WHERE  course_id = 3;

-- Cập nhật điểm cuối kỳ cho sinh viên 2, khóa học 1
UPDATE Score
SET    final = 9.50
WHERE  student_id = 2
  AND  course_id  = 1;
  
DELETE FROM Score
WHERE student_id=5 and course_id=5;

DELETE FROM Enrollment
WHERE student_id=5 AND course_id=5;

-- Danh sách tất cả sinh viên
SELECT * FROM Student;

-- Danh sách giảng viên
SELECT * FROM Teacher;

-- Danh sách các khóa học
SELECT * FROM Course;

SELECT * FROM Score;

SELECT * FROM Enrollment;

