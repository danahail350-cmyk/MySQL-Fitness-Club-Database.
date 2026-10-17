CREATE TABLE Members (
    Member_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone_Number VARCHAR(15),
    Date_of_Birth DATE,
    Gender VARCHAR(10)
);

CREATE TABLE Trainers (
    Trainer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Years_of_Experience INT,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Membership_Types (
    Type_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Price DECIMAL(10, 2),
    Benefits VARCHAR(255)
);

CREATE TABLE Rooms (
    Room_ID INT PRIMARY KEY,
    Max_Capacity INT,
    Floor_Type VARCHAR(50)
);

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Job_Title VARCHAR(100),
    Shift VARCHAR(50)
);

CREATE TABLE Subscriptions (
    Subscription_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20),
    Member_ID INT,
    Type_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Type_ID) REFERENCES Membership_Types(Type_ID)
);

CREATE TABLE Classes (
    Class_ID INT PRIMARY KEY,
    Class_Name VARCHAR(100),
    Start_Time TIME,
    End_Time TIME,
    Room_ID INT,
    Trainer_ID INT,
    FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID),
    FOREIGN KEY (Trainer_ID) REFERENCES Trainers(Trainer_ID)
);

CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Member_ID INT,
    Class_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Class_ID) REFERENCES Classes(Class_ID)
);

CREATE TABLE Equipment (
    Equipment_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Purchase_Date DATE,
    Maintenance_Status VARCHAR(50),
    Room_ID INT,
    FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Amount DECIMAL(10, 2),
    Payment_Date DATE,
    Payment_Method VARCHAR(50),
    Subscription_ID INT,
    FOREIGN KEY (Subscription_ID) REFERENCES Subscriptions(Subscription_ID)
);

INSERT INTO Members VALUES (1, 'Ahmed Ali', '0501234567', '1995-05-15', 'Male');
INSERT INTO Members VALUES (2, 'Sara Hassan', '0507654321', '1998-11-20', 'Female');
INSERT INTO Members VALUES (3, 'Omar Khaled', '0501112223', '1990-02-10', 'Male');
INSERT INTO Members VALUES (4, 'Nour Youssef', '0504445556', '2001-08-05', 'Female');
INSERT INTO Members VALUES (5, 'Ziad Tariq', '0509998887', '1993-12-25', 'Male');

INSERT INTO Trainers VALUES (1, 'Captain Mahmoud', 'Bodybuilding', 8, 7000.00);
INSERT INTO Trainers VALUES (2, 'Captain Mona', 'Yoga and Pilates', 5, 5500.00);
INSERT INTO Trainers VALUES (3, 'Captain Tarek', 'CrossFit', 10, 8500.00);
INSERT INTO Trainers VALUES (4, 'Captain Salma', 'Cardio', 3, 4000.00);

INSERT INTO Membership_Types VALUES (1, 'Basic Monthly', 300.00, 'Gym access only');
INSERT INTO Membership_Types VALUES (2, 'Pro 6 Months', 1500.00, 'Gym + Classes');
INSERT INTO Membership_Types VALUES (3, 'VIP Annual', 2500.00, 'Gym + Classes + Spa + PT');

INSERT INTO Rooms VALUES (1, 50, 'Rubber');
INSERT INTO Rooms VALUES (2, 20, 'Wood');
INSERT INTO Rooms VALUES (3, 30, 'Mat');
INSERT INTO Rooms VALUES (4, 15, 'Concrete');

INSERT INTO Staff VALUES (1, 'Kareem Nabil', 'Receptionist', 'Morning');
INSERT INTO Staff VALUES (2, 'Heba Adel', 'Manager', 'Morning');
INSERT INTO Staff VALUES (3, 'Mazen Fathy', 'Cleaner', 'Night');
INSERT INTO Staff VALUES (4, 'Dina Wael', 'Receptionist', 'Night');

INSERT INTO Subscriptions VALUES (1, '2026-01-01', '2026-02-01', 'Expired', 1, 1);
INSERT INTO Subscriptions VALUES (2, '2026-03-01', '2026-09-01', 'Active', 2, 2);
INSERT INTO Subscriptions VALUES (3, '2026-01-15', '2027-01-15', 'Active', 3, 3);
INSERT INTO Subscriptions VALUES (4, '2026-04-01', '2026-05-01', 'Active', 4, 1);

INSERT INTO Classes VALUES (1, 'Morning Yoga', '08:00:00', '09:00:00', 2, 2);
INSERT INTO Classes VALUES (2, 'CrossFit Madness', '18:00:00', '19:30:00', 1, 3);
INSERT INTO Classes VALUES (3, 'HIIT Cardio', '10:00:00', '11:00:00', 3, 4);

INSERT INTO Enrollments VALUES (1, 2, 1);
INSERT INTO Enrollments VALUES (2, 3, 2);
INSERT INTO Enrollments VALUES (3, 4, 3);
INSERT INTO Enrollments VALUES (4, 2, 3);

INSERT INTO Equipment VALUES (1, 'Treadmill A1', '2023-05-10', 'Good', 1);
INSERT INTO Equipment VALUES (2, 'Dumbbell Set', '2024-01-20', 'Good', 1);
INSERT INTO Equipment VALUES (3, 'Yoga Mats', '2025-02-15', 'Needs Replacement', 2);
INSERT INTO Equipment VALUES (4, 'Rowing Machine', '2023-08-30', 'Under Repair', 3);

INSERT INTO Payments VALUES (1, 300.00, '2026-01-01', 'Cash', 1);
INSERT INTO Payments VALUES (2, 1500.00, '2026-03-01', 'Credit Card', 2);
INSERT INTO Payments VALUES (3, 2500.00, '2026-01-15', 'Bank Transfer', 3);
INSERT INTO Payments VALUES (4, 300.00, '2026-04-01', 'Cash', 4);

SELECT * FROM Members;
SELECT * FROM Trainers;
SELECT * FROM Membership_Types;
SELECT * FROM Rooms;
SELECT * FROM Staff;
SELECT * FROM Subscriptions;
SELECT * FROM Classes;
SELECT * FROM Enrollments;
SELECT * FROM Equipment;
SELECT * FROM Payments;

-- Query 1: (Covers: a. Aggregation function, g. GROUP BY, h. AS)
-- Meaning: Find the total salary paid to trainers per specialization.
SELECT Specialization, SUM(Salary) AS Total_Salary 
FROM Trainers 
GROUP BY Specialization;

-- Query 2: (Covers: b. Outer join, g. GROUP BY)
-- Meaning: List all Membership Types and the count of subscriptions for each, even if zero.
SELECT m.Name AS Membership_Name, COUNT(s.Subscription_ID) AS Total_Subscriptions 
FROM Membership_Types m 
LEFT JOIN Subscriptions s ON m.Type_ID = s.Type_ID 
GROUP BY m.Name;


-- Query 3: (Covers: c. Nested query, d. IN)
-- Meaning: Find the names and phone numbers of members who have an 'Active' subscription.
SELECT Name, Phone_Number 
FROM Members 
WHERE Member_ID IN (
    SELECT Member_ID 
    FROM Subscriptions 
    WHERE Status = 'Active'
);

-- Query 4: (Covers: d. LIKE, Logical operator AND)
-- Meaning: Find staff members whose name starts with 'M' and who work the night shift.
SELECT Name, Job_Title, Shift 
FROM Staff 
WHERE Name LIKE 'M%' AND Shift = 'Night';


-- Query 5: (Covers: e. Link 3 or more tables)
-- Meaning: Show member names, the classes they are enrolled in, and their trainer's name.
SELECT m.Name AS Member_Name, c.Class_Name, t.Name AS Trainer_Name 
FROM Members m 
JOIN Enrollments e ON m.Member_ID = e.Member_ID 
JOIN Classes c ON e.Class_ID = c.Class_ID 
JOIN Trainers t ON c.Trainer_ID = t.Trainer_ID;

-- Query 6: (Covers: f. UNION ALL)
-- Meaning: Create a combined directory list of all Members and Trainers in the facility.
SELECT Name, 'Member' AS Role 
FROM Members 
UNION ALL 
SELECT Name, 'Trainer' AS Role 
FROM Trainers;