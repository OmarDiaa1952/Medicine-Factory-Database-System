CREATE TABLE Client (
    ClientID CHAR(7) NOT NULL,
    name CHAR(20) NOT NULL,
    phone_number CHAR(11),
    PRIMARY KEY (ClientID)
);

CREATE TABLE Hospital (
    Reputation CHAR(2),
    ClientID CHAR(7) NOT NULL,
    PRIMARY KEY (ClientID),
    FOREIGN KEY (ClientID)
        REFERENCES Client (ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Factory (
    Type CHAR(10),
    ClientID CHAR(7) NOT NULL,
    PRIMARY KEY (ClientID),
    FOREIGN KEY (ClientID)
        REFERENCES Client (ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Client_address (
    address CHAR(30) NOT NULL,
    ClientID CHAR(7) NOT NULL,
    PRIMARY KEY (address , ClientID),
    FOREIGN KEY (ClientID)
        REFERENCES Client (ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Pharmacy (
    Reach CHAR(20) NOT NULL,
    ClientID CHAR(7) NOT NULL,
    PRIMARY KEY (ClientID),
    FOREIGN KEY (ClientID)
        REFERENCES Client (ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Employee (
    EmpID CHAR(7) NOT NULL,
    firstName CHAR(13) NOT NULL,
    secondName CHAR(13),
    lastName CHAR(13) NOT NULL,
    Gender CHAR(6),
    working_hours CHAR(9),
    hiringDate DATE,
    Salary DECIMAL(6 , 2 ),
    phoneNumber CHAR(11),
    bonus DECIMAL(3 , 2 ),
    birthate DATE,
    DNumber CHAR(3),
    PRIMARY KEY (EmpID)
);

CREATE TABLE Manager (
    Expereience CHAR(50) NOT NULL,
    EmpID CHAR(7) NOT NULL,
    PRIMARY KEY (EmpID),
    FOREIGN KEY (EmpID)
        REFERENCES Employee (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Department (
    EmpID CHAR(7) NOT NULL,
    Name CHAR(12) NOT NULL,
    numEmployees INT,
    DNumber CHAR(3),
    PRIMARY KEY (DNumber),
    FOREIGN KEY (EmpID)
        REFERENCES Manager (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Employee ADD CONSTRAINT foreignKey
	FOREIGN KEY (DNumber) REFERENCES Department(DNumber)
		ON DELETE CASCADE
        ON UPDATE CASCADE
;

CREATE TABLE Employee_address (
    EmpID CHAR(7) NOT NULL,
    address CHAR(30) NOT NULL,
    PRIMARY KEY (EmpID , address),
    FOREIGN KEY (EmpID)
        REFERENCES Employee (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Dependent (
    EmpID CHAR(7) NOT NULL,
    DepID CHAR(7) NOT NULL,
    firstName CHAR(10) NOT NULL,
    secondName CHAR(10),
    lastName CHAR(10) NOT NULL,
    gender CHAR(6),
    working_hours CHAR(9),
    hiringDate DATE,
    Salary DECIMAL(6 , 2 ),
    phoneNumber CHAR(11),
    bonus DECIMAL(3 , 2 ),
    birthdate DATE,
    PRIMARY KEY (EmpID , DepID),
    FOREIGN KEY (EmpID)
        REFERENCES Manager (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Driver (
    License CHAR(10) NOT NULL,
    EmpID CHAR(7) NOT NULL,
    veh_number CHAR(6) NOT NULL UNIQUE,
    destination CHAR(30),
    maintenance_date DATE,
    PRIMARY KEY (EmpID , veh_number),
    FOREIGN KEY (EmpID)
        REFERENCES Employee (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Truck (
    veh_number CHAR(6) NOT NULL,
    truck_load CHAR(10),
    PRIMARY KEY (veh_number),
    FOREIGN KEY (veh_number)
        REFERENCES Driver (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Car (
    veh_number CHAR(6) NOT NULL,
    model CHAR(20),
    PRIMARY KEY (veh_number),
    FOREIGN KEY (veh_number)
        REFERENCES Driver (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Bus (
    veh_number CHAR(6) NOT NULL,
    numPassengers INT,
    PRIMARY KEY (veh_number),
    FOREIGN KEY (veh_number)
        REFERENCES Driver (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Has (
    EmpID CHAR(7) NOT NULL,
    veh_number CHAR(6) NOT NULL,
    PRIMARY KEY (EmpID , veh_number),
    FOREIGN KEY (EmpID)
        REFERENCES Manager (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (veh_number)
        REFERENCES Car (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Salesman (
    target CHAR(10),
    EmpID CHAR(7) NOT NULL,
    veh_number CHAR(6) NOT NULL,
    PRIMARY KEY (EmpID),
    FOREIGN KEY (EmpID)
        REFERENCES Employee (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (veh_number)
        REFERENCES Bus (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Medicine (
    MedID CHAR(7) NOT NULL,
    Name CHAR(20) NOT NULL,
    Quantity INT,
    Price DECIMAL(3 , 2 ),
    Description CHAR(100),
    Manufacture_date DATE,
    Usage_duration CHAR(10),
    Expiry_date DATE,
    EmpID CHAR(7) NOT NULL,
    PRIMARY KEY (MedID),
    FOREIGN KEY (EmpID)
        REFERENCES Salesman (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Liquid (
    Volume CHAR(10),
    MedID CHAR(7) NOT NULL,
    PRIMARY KEY (MedID),
    FOREIGN KEY (MedID)
        REFERENCES Medicine (MedID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Tablet (
    numTablets INT,
    MedID CHAR(7) NOT NULL,
    PRIMARY KEY (MedID),
    FOREIGN KEY (MedID)
        REFERENCES Medicine (MedID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Chemist (
    Lab_access CHAR(10) NOT NULL,
    EmpID CHAR(7) NOT NULL,
    veh_number CHAR(6) NOT NULL,
    PRIMARY KEY (EmpID),
    FOREIGN KEY (EmpID)
        REFERENCES Employee (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (veh_number)
        REFERENCES Bus (veh_number)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Raw_Materials (
    MatName CHAR(20) NOT NULL UNIQUE,
    Description CHAR(100),
    Quantity INT,
    EmpID CHAR(7) NOT NULL,
    PRIMARY KEY (MatName),
    FOREIGN KEY (EmpID)
        REFERENCES Chemist (EmpID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Makes (
    Matname CHAR(20) NOT NULL,
    MedID CHAR(7) NOT NULL,
    PRIMARY KEY (Matname , MedID),
    FOREIGN KEY (MedID)
        REFERENCES Medicine (MedID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Matname)
        REFERENCES Raw_materials (MatName)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Buy (
    payment_value DECIMAL(4 , 2 ),
    receipt_date DATE,
    discount CHAR(4),
    quantinty INT,
    ClientID CHAR(7) NOT NULL,
    MedID CHAR(7) NOT NULL,
    PRIMARY KEY (ClientID , MedID),
    FOREIGN KEY (MedID)
        REFERENCES Medicine (MedID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ClientID)
        REFERENCES Client (ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Supplier (
    SupName CHAR(20) NOT NULL,
    phone_number CHAR(11),
    PRIMARY KEY (SupName)
);

CREATE TABLE Supplier_address (
    SupName CHAR(20) NOT NULL,
    address CHAR(30) NOT NULL,
    PRIMARY KEY (SupName , address),
    FOREIGN KEY (SupName)
        REFERENCES Supplier (SupName)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Supply (
    SupName CHAR(20) NOT NULL,
    MatName CHAR(20) NOT NULL,
    payment_value DECIMAL(6 , 2 ),
    receipt_date DATE,
    quantity INT,
    PRIMARY KEY (SupName , MatName),
    FOREIGN KEY (MatName)
        REFERENCES Raw_Materials (MatName)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SupName)
        REFERENCES Supplier (SupName)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Purchased (
    MatName CHAR(20) NOT NULL,
    price DECIMAL(6 , 2 ),
    PRIMARY KEY (MatName),
    FOREIGN KEY (MatName)
        REFERENCES Raw_Materials (MatName)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Manufactured (
    MatName CHAR(20) NOT NULL,
    Manufactured_date DATE,
    PRIMARY KEY (MatName),
    FOREIGN KEY (MatName)
        REFERENCES Raw_Materials (MatName)
        ON DELETE CASCADE ON UPDATE CASCADE
);
