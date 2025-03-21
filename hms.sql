DROP DATABASE IF EXISTS hospital_management_system ;
create database hospital_management_system;
use hospital_management_system;
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    address TEXT,
    medical_history TEXT,
    treatment_details TEXT
);
INSERT INTO Patients (name, age, gender, contact_number, address, medical_history, treatment_details)
VALUES 
('John Doe', 35, 'Male', '1234567890', '123 Street Name, City', 'Diabetes', 'On insulin therapy'),
('Jane Smith', 29, 'Female', '9876543210', '456 Avenue Name, City', 'Hypertension', 'Lifestyle changes and medication'),
('Robert Brown', 40, 'Male', '4561237890', '789 Road Name, City', 'Asthma', 'Inhaler prescribed'),
('Emily Davis', 25, 'Female', '7894561230', '321 Lane Name, City', 'Anemia', 'Iron supplements'),
('Michael Johnson', 50, 'Male', '3217894560', '654 Boulevard Name, City', 'High Cholesterol', 'Diet modification and statins'),
('Laura Wilson', 33, 'Female', '7412589630', '963 Avenue Name, City', 'Migraine', 'Pain management and preventive measures'),
('David Lee', 60, 'Male', '8527419630', '159 Street Name, City', 'Heart Disease', 'Cardiac medications and monitoring'),
('Sophia Martinez', 45, 'Female', '9513578520', '753 Circle Name, City', 'Arthritis', 'Physical therapy and pain relief'),
('James Anderson', 27, 'Male', '7531598520', '147 Parkway Name, City', 'Seasonal Allergies', 'Antihistamines prescribed'),
('Olivia Taylor', 38, 'Female', '1597534860', '369 Plaza Name, City', 'Thyroid Disorder', 'Thyroid hormone replacement therapy');
select * from patient;

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),  -- e.g., Doctor, Nurse, Admin
    contact_number VARCHAR(15),
    email VARCHAR(100),
    schedule TEXT,     -- Example: "Mon-Fri: 9 AM - 5 PM"
    performance_rating DECIMAL(3, 2) DEFAULT NULL,  -- Out of 5.00
    attendance INT DEFAULT 0
);
INSERT INTO Staff (name, role, contact_number, email, schedule)
VALUES 
('Dr. Jane Smith', 'Doctor', '1234567890', 'jane.smith@example.com', 'Mon-Fri: 9 AM - 5 PM'),
('Dr. Robert Brown', 'Surgeon', '9876543210', 'robert.brown@example.com', 'Mon-Fri: 10 AM - 6 PM'),
('Nurse Emily Davis', 'Nurse', '5678901234', 'emily.davis@example.com', 'Mon-Sat: 8 AM - 4 PM'),
('Dr. Michael Johnson', 'Pediatrician', '8765432109', 'michael.johnson@example.com', 'Tue-Sat: 10 AM - 4 PM'),
('Sophia Lee', 'Physiotherapist', '3456789012', 'sophia.lee@example.com', 'Mon-Fri: 11 AM - 7 PM'),
('James Wilson', 'Administrative Staff', '2345678901', 'james.wilson@example.com', 'Mon-Sat: 9 AM - 5 PM'),
('Dr. Laura Taylor', 'Oncologist', '1230984567', 'laura.taylor@example.com', 'Mon-Fri: 8 AM - 4 PM'),
('David Martinez', 'Receptionist', '4567890123', 'david.martinez@example.com', 'Mon-Sun: 8 AM - 8 PM'),
('Sarah Anderson', 'Lab Technician', '7890123456', 'sarah.anderson@example.com', 'Mon-Sat: 9 AM - 3 PM'),
('Dr. Olivia Carter', 'Dermatologist', '9012345678', 'olivia.carter@example.com', 'Wed-Sun: 12 PM - 6 PM');
select * from staff;

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    staff_id INT,  -- Typically, a doctor
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20) DEFAULT 'Scheduled',  -- e.g., Scheduled, Completed, Canceled
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);
INSERT INTO Appointments (patient_id, staff_id, appointment_date, appointment_time)
VALUES 
(1, 3, '2025-01-10', '10:30:00'), -- John Doe with Doctor (Staff ID 3)
(2, 4, '2025-01-11', '11:00:00'), -- Jane Smith with Nurse (Staff ID 4)
(3, 3, '2025-01-12', '09:30:00'), -- Robert Brown with Doctor (Staff ID 3)
(4, 5, '2025-01-12', '14:00:00'), -- Emily Davis with Specialist (Staff ID 5)
(5, 3, '2025-01-13', '10:45:00'), -- Michael Johnson with Doctor (Staff ID 3)
(6, 6, '2025-01-14', '13:15:00'), -- Laura Wilson with Physiotherapist (Staff ID 6)
(7, 3, '2025-01-15', '16:00:00'), -- David Lee with Doctor (Staff ID 3)
(8, 4, '2025-01-16', '11:30:00'), -- Sophia Martinez with Nurse (Staff ID 4)
(9, 5, '2025-01-17', '15:00:00'), -- James Anderson with Specialist (Staff ID 5)
(10, 6, '2025-01-18', '08:45:00'); -- Olivia Taylor with Physiotherapist (Staff ID 6)
select * from Appointments;

-- Appointments for a Specific Patient
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    s.Name AS StaffName,
    s.Role AS StaffRole
FROM 
    Appointments a
JOIN 
    Patients p ON a. patient_id = p. patient_id
JOIN 
    Staff s ON a.staff_id = s.staff_id
WHERE 
    p.patient_id = 5; -- Replace with desired PatientID



-- APPOINTMENTS WITH PATIENT AND STAFF DETAILS
SELECT 
    p.Name AS PatientName,
    p.contact_number AS PatientContact,
    s.Name AS StaffName,
    s.Role AS StaffRole,
    a.appointment_date,
    a.appointment_time,
    a.Status
FROM 
    Appointments a
JOIN 
    Patients p ON a.patient_id = p.patient_id
JOIN 
    Staff s ON a.staff_id = s.staff_id;
    
    
    
    CREATE TABLE MedicalHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT, -- Foreign key connecting to Patients table
    Diagnosis VARCHAR(255), -- Diagnosis information
    Treatment VARCHAR(255), -- Treatment details
    Notes TEXT, -- Additional notes
    RecordedDate DATE, -- When the history was recorded
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
INSERT INTO MedicalHistory (patient_id, Diagnosis, Treatment, Notes, RecordedDate) VALUES
(1, 'Diabetes', 'Insulin therapy', 'Patient is responding well to insulin.', '2025-01-10'),
(2, 'Hypertension', 'Lifestyle modification and medication', 'Regular BP monitoring recommended.', '2025-01-15'),
(3, 'Asthma', 'Inhaler therapy', 'Avoid triggers such as pollen and dust.', '2025-01-12');




