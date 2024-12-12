-- SHOW DATABASES;
-- DROP  DATABASE homerental;
CREATE DATABASE homerental;
USE homerental;

CREATE TABLE Branch (
    branchNo VARCHAR(4) PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(10) NOT NULL,
    postcode VARCHAR(10) NOT NULL
);
DESC Branch;

CREATE TABLE Staff (
    staffNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20) NOT NULL,
    lName VARCHAR(20) NOT NULL,
    position VARCHAR(20) NOT NULL,
    sex CHAR(1) NOT NULL,
    DOB DATE,
    salary DECIMAL(8,2),
    branchNo VARCHAR(4) NOT NULL,
    FOREIGN KEY (branchNo) REFERENCES Branch (branchNo),
    CONSTRAINT chk1 CHECK (sex = 'F' or sex = 'M')
);
DESC Staff;

CREATE TABLE Client (
    clientNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20) NOT NULL,
    lName VARCHAR(20) NOT NULL,
    telNo VARCHAR(15) NOT NULL,
    prefType VARCHAR(10),
    maxRent DECIMAL(6,2)
);
DESC Client;

CREATE TABLE PrivateOwner(
    ownerNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20) NOT NULL,
    lName VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    telNo VARCHAR(15) NOT NULL
);
DESC PrivateOwner;

CREATE TABLE PropertyForRent (
    propertyNo VARCHAR(5) PRIMARY KEY,
    street VARCHAR(50) NOT NULL ,
    city VARCHAR(10) NOT NULL,
    postcode VARCHAR(10) NOT NULL,
    type VARCHAR(10),
    rooms INT,
    rent DECIMAL(8,2),
    ownerNo VARCHAR(5) NOT NULL,
    staffNo VARCHAR(5),
    branchNo VARCHAR(4),
    FOREIGN KEY (ownerNo) REFERENCES PrivateOwner(ownerNo),
    FOREIGN KEY (staffNo) REFERENCES Staff (staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch (branchNo)
);
DESC PropertyForRent;

CREATE TABLE Viewing (
    clientNo VARCHAR(5) ,
    propertyNo VARCHAR(5),
    viewDate DATE,
    comment VARCHAR(50),
    FOREIGN KEY (clientNo) REFERENCES Client (clientNo),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent (propertyNo),
    PRIMARY KEY(clientNo,propertyNo)
);
DESC Viewing;

CREATE TABLE Registration (
    clientNo VARCHAR(5) ,
    branchNo VARCHAR(4) ,
    staffNo VARCHAR(5),
    dateJoined DATE,
    FOREIGN KEY (clientNo) REFERENCES Client (clientNo),
    FOREIGN KEY (branchNo) REFERENCES Branch (branchNo),
    PRIMARY KEY(clientNo,branchNo)
);
DESC Registration;

-- insert into branch
INSERT INTO Branch VALUES
('B005', '22 Deer Rd', 'London','SW1 4EH'),
('B007', '16 Argyll St', 'Aberdeen','AB2 3SU'),
('B003', '163 Main St', 'Glasgow','G11 9QX'),
('B004', '32 Manse Rd', 'Bristol','BS99 1NZ'),
('B002', '56 Clover Dr', 'London','NW10 6EU');

SELECT * FROM Branch;

--INSERT INTO CLIENT

INSERT INTO Client VALUES
('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425),
('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350),
('CR74', 'Mike', 'Ritchie', '01475-392178', 'House', 750),
('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600);

SELECT * FROM Client;



--INSERT INTO PRIVATEOWNER
INSERT INTO PrivateOwner VALUES
('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212'),
('CO87', 'Carol', 'Farrel', '6 Achray St, Glasgow G32 9DX', '0141-357-7419'),
('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42', '0141-943-1728'),
('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 0QR', '0141-225-7025');

SELECT * FROM PrivateOwner;


--INSERT INTO STAFF
INSERT INTO Staff VALUES
('SL21', 'John', 'White', 'Manager', 'M', '1945-10-01', 30000, 'B005'), 
('SG37', 'Ann', 'Beech', 'Assistant', 'F', '1960-11-10', 12000, 'B003'),
('SG14', 'David', 'Ford', 'Supervisor', 'M', '1958-03-24', 18000, 'B003'), 
('SA9', 'Mary', 'Howe', 'Assistant', 'F', '1970-02-19', 9000, 'B007'),
('SG5', 'Susan', 'Brand', 'Manager', 'F', '1940-06-03', 24000, 'B003'), 
('SL41', 'Julie', 'Lee', 'Assistant', 'F', '1965-06-13', 9000, 'B005');

SELECT * FROM Staff;


--INSERT INTO PROPERTYFORRENT
INSERT INTO PropertyForRent VALUES
('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House', 6, 650, 'CO46', 'SA9', 'B007'),
('PL94', '6 Argyll St', 'London', 'NW2', 'Flat', 3, 400, 'CO87', 'SL41', 'B005'),
('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', NULL, 'B003'),
('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003'),
('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG37', 'B003'),
('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

SELECT * FROM PropertyForRent;


--INSERT INTO VIEWING
INSERT INTO Viewing  VALUES
('CR56', 'PA14', '2004-05-24', 'too small'),
('CR76', 'PG4', '2004-04-20', 'too remote'),
('CR56', 'PG4', '2004-05-26', NULL),
('CR62', 'PA14', '2004-05-14', 'no dining room'),
('CR56', 'PG36', '2004-04-28', NULL);

SELECT * FROM Viewing;

--INSERT INTO REGISTRATION
INSERT INTO Registration VALUES 
('CR76', 'B005', 'SL41', '2004-01-02'), 
('CR56', 'B003', 'SG37', '2003-04-11'), 
('CR74', 'B003', 'SG37', '2002-11-16'), 
('CR62', 'B007', 'SA9', '2003-03-07');

SELECT * FROM Registration;



#1 List full details of all staff.	
SELECT * FROM Staff;

#2 Produce a list of salaries for all staff, showing only the staff number, the first and last names, and the salary details.
SELECT staffNo,fName,lName,salary FROM staff;

#3 Produce a list of monthly salaries for all staff, showing the staff number, the first and last names, and the salary details.
ALTER TABLE Staff 
ADD monthlySalary DECIMAL(10, 2) GENERATED ALWAYS AS (salary / 12) STORED;
SELECT staffNo,fName,lName,monthlySalary FROM staff;

#iv.List all staff with a salary greater than £10,000.
SELECT * FROM Staff WHERE salary >= 10000;
# v.List all staff with a salary between £20,000 and £30,000.
SELECT * FROM Staff
WHERE salary >= 20000 and salary <= 30000;
#VI SAME AS #2
#VII List all managers and supervisors
SELECT * FROM Staff WHERE position IN ("Manager", "Supervisor");

#8 List all cities where there is either a branch office or a property for rent
SELECT city from Branch
UNION
SELECT city from PropertyForRent;

#ix.List all cities where there is a branch office but no properties for rent.
SELECT city from Branch
EXCEPT
SELECT city from PropertyForRent;

#10 List all cities where there is both a branch office and at least one property for rent.
SELECT city from Branch
INTERSECT
SELECT city from PropertyForRent;

#11.List the names and comments of all clients who have viewed a property for rent.
SELECT c.fName,c.lName,v.comment from viewing v,Client c WHERE (v.clientNo = c.clientNo && v.comment IS NOT NULL);

#12 Produce a status report on property viewings
SELECT 
    V.clientNo, CONCAT(C.fName, ' ', C.lName) AS clientName, 
    V.propertyNo, P.street, P.city, 
    V.viewDate, V.comment
FROM Viewing V
JOIN Client C ON V.clientNo = C.clientNo
JOIN PropertyForRent P ON V.propertyNo = P.propertyNo;


#13.List complete details of all staff who work at the branch in Glasgow.
SELECT * FROM Staff
WHERE branchNo = (SELECT branchNo FROM Branch WHERE city = 'Glassgow');

#14 Find all owners with the string 'Glasgow' in their address.
SELECT * FROM PrivateOwner WHERE address LIKE '%Glasgow%';

#15 How many properties cost more than £350 per month to rent?
SELECT COUNT(*) AS PropertiesAbove350 FROM PropertyForRent
WHERE rent > 350;

#16 Find the minimum, maximum, and average staff salary.
SELECT 
    MIN(salary), 
    MAX(salary), 
    AVG(salary)
FROM Staff;

#17 Find the number of staff working in each branch and the sum of their salaries.
SELECT branchNo, 
    COUNT(*) AS NumberOfStaff, 
    SUM(salary) AS TotalSalary
FROM Staff
GROUP BY branchNo;

#18 List the details of all viewings on property PG4 where a comment has not been supplied.
SELECT * FROM Viewing
WHERE propertyNo = 'PG4' AND comment IS NULL;

#19 Produce a list of salaries for all staff
SELECT CONCAT(fName,' ', lName) AS StaffName, salary 
FROM Staff
ORDER BY salary DESC;

#20 Produce a list of properties arranged in order of property type. 
SELECT * FROM PropertyForRent
ORDER BY type;

#21 How many different properties were viewed in May 2004?
SELECT COUNT(DISTINCT propertyNo) AS PropertiesViewedInMay2004 FROM Viewing
WHERE MONTH(viewDate) = 05 AND YEAR(viewDate) = 2004;

#22 Find the total number of Managers and the sum of their salaries
SELECT 
    COUNT(*) AS TotalManagers, position,
    SUM(salary) AS TotalManagerSalaries
FROM Staff
WHERE position = 'Manager';

#23 For each branch office with more than one member of staff, find the number of staff working in each branch and the sum of their salaries.
SELECT 
    branchNo,
    COUNT(*) AS StaffCount, 
    SUM(salary) AS TotalSalary
FROM Staff
GROUP BY branchNo
HAVING COUNT(*) > 1;

#24 List the staff who work in the branch at 163 Main St.
SELECT * FROM Staff
WHERE branchNo = (SELECT branchNo FROM Branch WHERE street = '163 Main St');

#25 List all staff whose salary is greater than the average salary, and show by how much their salary is greater
SELECT 
    fName, lName, salary, 
    salary - (SELECT AVG(salary) FROM Staff) AS DeviationSalary
FROM Staff
WHERE salary > (SELECT AVG(salary) FROM Staff);


#26 List the properties that are handled by staff who work in the branch at 163 Main St.
SELECT * FROM PropertyForRent
WHERE staffNo IN (SELECT staffNo FROM Staff 
                  WHERE branchNo = (SELECT branchNo FROM Branch 
                                    WHERE street = '163 Main St')
);

#27 Find all staff whose salary is larger than the salary of at least one member of staff at branch B003.
SELECT * 
FROM Staff
WHERE salary > (
    SELECT MIN(salary) 
    FROM Staff 
    WHERE branchNo = 'B003'
);

#27(another Way)
SELECT * 
FROM Staff
WHERE salary > ANY (
    SELECT salary 
    FROM Staff 
    WHERE branchNo = 'B003'
);

#28 Find all staff whose salary is larger than the salary of every member of staff at branch B003.
SELECT staffNo,fName,lName 
FROM Staff
WHERE salary > (SELECT MAX(salary) FROM Staff WHERE branchNo = 'B003');

#29
#Same as Q.11

#30,31 For each branch, list the numbers and names of staff who manage properties, including the city in which the branch is located and the properties that the staff manage. 
SELECT 
    b.branchNo, b.city, s.staffNo, s.fName, s.lName, p.propertyNo
FROM Branch b
JOIN Staff s ON b.branchNo = s.branchNo
JOIN PropertyForRent p ON s.staffNo = p.staffNo;

#32 Find the number of properties handled by each staff member.
SELECT staffNo, COUNT(propertyNo) AS PropertiesHandled
FROM PropertyForRent
GROUP BY staffNo
HAVING staffNo IS NOT NULL;

#33 List all branch offices and any properties that are in the same city.
SELECT  
    Branch.city,
    Branch.branchNo,
    PropertyForRent.propertyNo
FROM Branch
JOIN PropertyForRent ON Branch.city = PropertyForRent.city;

#34 List the branch offices and properties that are in the same city along with any unmatched branches or properties. 
SELECT 
    Branch.city,
    PropertyForRent.city,
    Branch.branchNo,
    PropertyForRent.propertyNo
FROM Branch
LEFT JOIN PropertyForRent ON Branch.city = PropertyForRent.city

UNION

SELECT 
    Branch.city,
    PropertyForRent.city,
    Branch.branchNo,
    PropertyForRent.propertyNo
FROM Branch
RIGHT JOIN PropertyForRent ON Branch.city = PropertyForRent.city;


#35.Write query to create a table OwnersPropertyCount (ownerNo, fName, lName,noOfProperty) and populate from the existing tables.
CREATE TABLE OwnersPropertyCount(
    ownerNo VARCHAR(5) PRIMARY KEY,
    fName VARCHAR(20) NOT NULL,
    lName VARCHAR(20) NOT NULL,
    noOfProperty INT,
    FOREIGN KEY (ownerNo) REFERENCES PrivateOwner(ownerNo)
);

Delete From OwnersPropertyCount WHERE ownerNo IS NOT NULL;

INSERT INTO OwnersPropertyCount (ownerNo, fName, lName, noOfProperty)
SELECT 
    PrivateOwner.ownerNo, PrivateOwner.fName, PrivateOwner.lName, 
    COUNT(PropertyForRent.propertyNo) AS noOfProperty
FROM PrivateOwner
LEFT JOIN PropertyForRent ON PrivateOwner.ownerNo = PropertyForRent.ownerNo
GROUP BY PrivateOwner.ownerNo;

select * from OwnersPropertyCount;

#36.Give all staff a 3% pay increase.
UPDATE Staff
SET salary=(salary*1.03);
SELECT staffNo,fName,lName,salary FROM Staff ORDER BY salary;

#37.Give all Managers a 5% pay increase.
UPDATE Staff
SET salary=(salary*1.05)
WHERE position = "Manager";
SELECT staffNo,fName,lName,salary FROM Staff WHERE position = "Manager" ORDER BY salary;

#38.Promote David Ford (staffNo 'SG14') to Manager and change his salary to £18,000
UPDATE Staff
SET salary=18000,position = "Manager"
WHERE staffNo = "SG14";
SELECT * FROM Staff WHERE position = "Manager";

#39 Delete all viewings that relate to property PG4
DELETE FROM viewing
WHERE propertyNo = "PG4";

SELECT * FROM viewing;

#40.Delete all rows from the Viewing table
DELETE FROM viewing
WHERE propertyNo IS NOT NULL;
SELECT * FROM viewing;


#Extras

#1.Find Out staff Details who work for Same Branch which Have more than 1 Employee.
SELECT *
FROM Staff
WHERE branchNo IN (SELECT s.branchNo
FROM Staff s
Group BY branchNo
HAVING COUNT(staffNo) > 1);

#2.Create a View Which Display BranchNo,StaffNo.Position & ClientNo
CREATE VIEW custom AS
Select s.branchNo,s.staffNo,s.position,c.clientNo
From Staff s
JOIN Registration c ON s.staffNo = c.staffNo;
Select * FROM custom;

#3.SHOW all details from Cross Product of Staff,Registration
SELECT *
FROM Staff,Registration;

#4.Find the Street & city of the Branch for ALL Clients whose Max Rent > 400
SELECT c.clientNo,c.fName,c.lName,b.branchNo, b.street,b.city
FROM Client c
JOIN Registration r ON c.clientNo = r.clientNo AND maxRent > 400
JOIN Branch b ON r.branchNo = b.branchNo;

#5.Find the Max Salary For Each BranchNo
SELECT branchNo,MAX(salary) AS maxSalary
FROM Staff
NATURAL JOIN Branch
GROUP BY BranchNo;
