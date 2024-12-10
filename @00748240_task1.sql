--- Create Database 

CREATE DATABASE HospitalDB;
USE HospitalDB;

---Part 1) Design And Normalized Database

-- Create the Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,                   ----Primary Key- PatientID, Datatype INT
    FullName NVARCHAR(100) NOT NULL,    ----Datatype NVARCHAR
    Address NVARCHAR(255) NOT NULL,         ----Datatype NVARCHAR
    DateOfBirth DATE NOT NULL,                        ----Datatype DATE
    Insurance NVARCHAR(100) NOT NULL,           ----Datatype NVARCHAR
    Email NVARCHAR(100),                                         ----DatatypeNVARCHAR
    Telephone NVARCHAR(20),                                       ----Datatype NVARCHAR
    Username NVARCHAR(50) NOT NULL,                     ----Datatype NVARCHAR
    Password NVARCHAR(50) NOT NULL  ,                      ----Datatype NVARCHAR
	DateLeft DATE                                                                    ----Datatype DATE
	  );

-- Create the Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,                           ----Primary Key- DepartmentID , Datatype INT
    DepartmentName NVARCHAR(100) NOT NULL         ----Datatype NVARCHAR
);

-- Create the Doctors table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,                          ---Primary Key- DoctorID , Datatype INT
    FullName NVARCHAR(100) NOT NULL,           ----Datatype NVARCHAR
    Specialty NVARCHAR(100) NOT NULL,              ----Datatype NVARCHAR
    DepartmentID INT NOT NULL,                               ---Datatype INT
    DateJoined DATE NOT NULL,                                  ---Datatype DATE
	CONSTRAINT FK_DepartmentID_Doctors FOREIGN KEY ( DepartmentID) REFERENCES Departments(DepartmentID)  --FK-DeptID
);


-- Create the MedicalRecords table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,                        ---Primary Key-RecordID , Datatype INT
    PatientID INT NOT NULL,                                   ---Datatype INT
    DoctorID INT NOT NULL,                                       ---Datatype INT
    AppointmentDate DATE NOT NULL,                         ---Datatype DATE
    Diagnosis NVARCHAR(255) NOT NULL,                    ----Datatype NVARCHAR
    Medicine NVARCHAR(100) NOT NULL,                       ----Datatype NVARCHAR
    MedicinePrescribedDate DATE NOT NULL,                      ---Datatype DATE
    Allergies NVARCHAR(255) NOT NULL,                               ----Datatype NVARCHAR
    CONSTRAINT FK_PatientID FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),                  ---Foreign Key- PatientID
    CONSTRAINT FK_DoctorID FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)                   ----Foreign Key- DoctorID
);

-- Create the Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,                 ---Primary Key-AppointmentID , Datatype INT
    PatientID INT NOT NULL,                                      ---Datatype INT
    DoctorID INT NOT NULL,                                          ---Datatype INT
    AppointmentDate DATE NOT NULL,                            ---Datatype DATE        
    AppointmentTime TIME NOT NULL,                                 ---Datatype TIME
    DepartmentID INT NOT NULL,                                             ---Datatype INT
    Status NVARCHAR(20) NOT NULL,                                       ---Datatype NVARCHAR
    Review NVARCHAR(MAX),                                                         ---Datatype NVARCHAR

	---Adding Foreign Key
 CONSTRAINT FK_PatientID_Appointments FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),       ---Foreign Key- PatientID
CONSTRAINT FK_DoctorID_Appointments FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),        ----Foreign Key- DoctorID
);


-- Create the PastAppointments table
CREATE TABLE PastAppointments (
 PastAppointmentID INT PRIMARY KEY,                ---Primary Key-AppointmentID , Datatype INT
  PatientID INT NOT NULL,                                          --Datatype INT
  DoctorID INT NOT NULL,                                                --Datatype INT
 AppointmentDate DATE NOT NULL,                              ---Datatype DATE
  AppointmentTime TIME NOT NULL,                                 ---Datatype TIME
  DepartmentID INT NOT NULL,                                                        --Datatype INT 
  Status NVARCHAR(20) NOT NULL,          ---Datatype NVARCHAR
  Review NVARCHAR(MAX)                                                                          ---Datatype NVARCHAR

---Adding Foreign Key
 CONSTRAINT FK_PatientID_PastAppointments FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),       ---Foreign Key- PatientID
CONSTRAINT FK_DoctorID_PastAppointments FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),        ----Foreign Key- DoctorID
);


----Insert into Patients table
INSERT INTO Patients (PatientID, FullName, Address, DateOfBirth, Insurance, Email, Telephone, Username, Password,DateLeft)
VALUES
(1, 'Adam Johnson', '123 Oak St, Anytown', '1983-09-21', 'ABC Insurance', 'adam.j@example.com', '123-456-7890', 'adamj', 'password123','2024-06-19'),
(2, 'Ella Williams', '456 Elm St, Othertown', '1975-11-30', 'XYZ Insurance', 'ella.w@example.com', '456-789-0123', 'ellaw', 'password456', '2024-05-20'),
(3, 'Nathan Clark', '789 Pine St, Anothertown', '1991-11-05', '123 Insurance', 'nathan.c@example.com', '789-012-3456', 'nathanc', 'password789', '2024-06-22'),
(4, 'Olivia Martinez', '456 Maple St, Newtown', '1969-06-28', 'XYZ Insurance', 'olivia.m@example.com', '234-567-8901', 'oliviam', 'passwordabc', '2024-06-23'),
(5, 'Lucas Taylor', '789 Cedar St, Cityville', '1974-12-12', 'ABC Insurance', 'lucas.t@example.com', '345-678-9012', 'lucast', 'passworddef','2024-06-24'),
(6, 'Ava Hernandez', '123 Elm St, Suburbia', '1987-02-19', '123 Insurance', 'ava.h@example.com', '456-789-0123', 'avah', 'passwordghi','2024-05-25'),
(7, 'Jackson Lopez', '789 Oak St, Villageville', '1996-07-03', 'XYZ Insurance', 'jackson.l@example.com', '567-890-1234', 'jacksonl', 'passwordjkl', '2024-06-26');

-- Populate the Departments table with sample data
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(01, 'Cardiology'),
(02, 'Neurology'),
(03, 'Orthopedics'),
(04, 'Oncology'),
(05, 'Gastroenterology'),
(06, 'Pediatrics'),
(07, 'Dermatology');

----Insert into Doctors Table
INSERT INTO Doctors (DoctorID, FullName, Specialty,DepartmentID, DateJoined)
VALUES
(1, 'Dr. Kerry John','Cardiologist',01, '2015-10-01'),
(2, 'Dr. Lee','Neurologist',02, '2018-03-15'),
(3, 'Dr. Michael Clark','Orthopedist',03, '2019-07-20'),
(4, 'Dr. Jerry Martin','Oncologist',04, '2020-01-10'),
(5, 'Dr. Ross Taylor','Gastroenterologist',05, '2022-06-05'),
(6, 'Dr. Kim','Pediatrictist',06, '2016-05-20'),
(7, 'Dr. Nikky Lopez', 'Dermatologist',07, '2017-09-10');


-- Populate the MedicalRecords table with sample data
INSERT INTO MedicalRecords (RecordID, PatientID, DoctorID, AppointmentDate, Diagnosis, Medicine, MedicinePrescribedDate, Allergies)
VALUES
(1, 1, 1, '2024-06-19', 'Heart Surgery', 'Lisinopril', '2027-03-16', 'Peanuts, Penicillin'),
(2, 2, 2, '2024-05-20', 'Migraine', 'Sumatriptan', '2027-03-17', 'None'),
(3, 3, 3, '2024-06-22', 'Fractured leg', 'Ibuprofen', '2027-03-18', 'Aspirin, Latex'),
(4, 4, 4, '2024-06-23', 'Breast Cancer', 'Tamoxifen', '2027-03-19', 'None'),
(5, 5, 5, '2024-06-24', 'Gastritis', 'Omeprazole', '2027-03-20', 'Shellfish, Sulfa'),
(6, 6, 6, '2024-05-25', 'Physical Disability', 'Amlodipine', '2027-03-21', 'None'),
(7, 7, 7, '2024-06-26', 'Skin Therorapy', 'Propranolol', '2027-03-22', 'Dust, Pollen');


-- Populate the Appointments table with sample data
INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, Status, Review)
VALUES
(1, 1, 1, '2024-06-19', '10:00',01, 'pending', NULL),
(2, 2, 2, '2024-05-20', '11:00',02, 'completed', 'Satisfy With Treatment'),
(3, 3, 3, '2024-06-22', '12:00',03, 'pending', NULL),
(4, 4, 4, '2024-06-23', '13:00',04, 'cancelled', NULL),
(5, 5, 5, '2024-06-24', '14:00', 05, 'pending', NULL),
(6, 6, 6, '2024-05-25', '15:00',06, 'completed', 'Dr. Kim provided excellent care'),
(7, 7, 7, '2024-06-26', '16:00',07, 'pending', NULL);


-- Populate the PastAppointments table with sample data
INSERT INTO PastAppointments (PastAppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID,Status, Review)
VALUES
(2, 2, 2, '2024-05-20', '11:00',02,   'completed', 'Satisfy With Treatment'),
(6, 6, 6, '2024-05-25', '15:00',06 , 'completed', 'Dr. Kim provided excellent care');

   
SELECT * FROM Patients
SELECT * FROM Departments
SELECT * FROM Appointments
SELECT * FROM Doctors
SELECT * FROM MedicalRecords
SELECT * FROM PastAppointments


-----PART 2

---Q2. Add the constraint to check that the appointment date is not in the past.

ALTER TABLE Appointments
ADD CONSTRAINT CHK_AppointmentDateNotInPast CHECK (AppointmentDate >= GETDATE());

----Q3. List all the patients with older than 40 and have Cancer in diagnosis.

SELECT p.*
FROM Patients p
JOIN MedicalRecords mr ON p.PatientID = mr.PatientID
WHERE DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) > 40
AND mr.Diagnosis LIKE '%Breast Cancer%';

---Q4.  a) Search the database by name of medicine AND SORT result with most recent medicine prescribed date first. 
   
CREATE PROCEDURE SearchMedicine
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SELECT *
    FROM MedicalRecords
    WHERE Medicine LIKE '%' + @MedicineName + '%'
    ORDER BY MedicinePrescribedDate DESC;
END;

EXEC SearchMedicine @MedicineName = 'Sumatriptan';

---b) Full list of diagnosis and allergies for a  patient who has an appointment today.(system date)

CREATE PROCEDURE GetDiagnosisAndAllergiesForToday
    @PatientID INT
AS
BEGIN
    SELECT Diagnosis, Allergies
    FROM MedicalRecords
    WHERE PatientID = @PatientID
    AND AppointmentDate = CONVERT(DATE, GETDATE());
END;

EXEC GetDiagnosisAndAllergiesForToday @PatientID = 1;

----c) Update the details for an existing doctor

CREATE PROCEDURE UpdateDoctorDetails
    @DoctorID INT,
    @NewFullName NVARCHAR(100),
    @NewSpecialty NVARCHAR(100)
AS
BEGIN
    UPDATE Doctors
    SET FullName = @NewFullName,
        Specialty = @NewSpecialty
    WHERE DoctorID = @DoctorID;
END;

EXEC UpdateDoctorDetails
    @DoctorID = 1,                                   -- Example DoctorID
    @NewFullName = 'Dr.Harshal Rana',    -- New full name
    @NewSpecialty = 'Cardiologist';                -- New specialty

SELECT * FROM Doctors WHERE DoctorID = 1;


---d) Delete the appointment who status is already completed


CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    DELETE FROM Appointments
    WHERE Status = 'completed';
END;

EXEC DeleteCompletedAppointments;

SELECT * FROM  Appointments;


---Q 5) All Appointment View 
CREATE VIEW AllAppointmentsView AS
SELECT DISTINCT a.AppointmentID, a.AppointmentDate, a.AppointmentTime, a.Status,
       d.DepartmentID, doc.FullName AS DoctorName, doc.Specialty,
       a.Review, pa.PastAppointmentID
FROM Appointments a
JOIN Doctors doc ON a.DoctorID = doc.DoctorID
JOIN Departments d ON doc.DepartmentID = d.DepartmentID
LEFT JOIN PastAppointments pa ON pa.DoctorID = a.DoctorID
UNION
SELECT DISTINCT pa.PastAppointmentID, pa.AppointmentDate, pa.AppointmentTime, pa.Status,
       d.DepartmentID, doc.FullName AS DoctorName, doc.Specialty,
       pa.Review, PastAppointmentID AS PastAppointmentID
FROM PastAppointments pa
JOIN Doctors doc ON pa.DoctorID = doc.DoctorID
JOIN Departments d ON doc.DepartmentID = d.DepartmentID;

SELECT  *
FROM AllAppointmentsView;


---6). Create a trigger so that the current state of an appointment can be changed to available when it is cancelled.

CREATE TRIGGER UpdateAppointmentStateOnCancellation
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status)
    BEGIN
        UPDATE Appointments
        SET Status = 'available'
        WHERE Status = 'cancelled';
    END
END;

UPDATE Appointments
SET Status = 'available'
WHERE Status = 'cancelled';

SELECT * FROM Appointments;


---7)Write a select query which allows the hospital to identify the number of completed appointments with the specialty of doctors as ‘Gastroenterologists’.

SELECT COUNT(*) AS CompletedGastroenterologyAppointments
FROM Appointments AS a
JOIN Doctors AS d ON a.DoctorID = d.DoctorID
WHERE a.Status = 'completed'
AND d.Specialty = 'Gastroenterologist';