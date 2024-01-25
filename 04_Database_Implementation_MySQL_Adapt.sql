/* Car Rental Database Design and Implementation 
Course: ITSS 4300 Database Fundamentals
Period: Spring Semester of 2023
Original Contributors: Sid Sridharan, Hoorad Afshar, Hoogjoon Kim, Amon Kissi 
MySQL Adapter: Hongjoon Kim
*/

CREATE DATABASE IF NOT EXISTS car_rental;
USE car_rental;

DROP TABLE IF EXISTS RECOMMENDATION;
DROP TABLE IF EXISTS RENTAL;
DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS MAINTENANCE;
DROP TABLE IF EXISTS VEHICLE;
DROP TABLE IF EXISTS CUSTOMER;
/* Adaptation Note:
"IF NOT EXISTS" clause added to the original queries.
*/

-- ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/YYYY';
/* Adaptation Note:
This is an Oracle SQL command from the original project.
A different, MySQL-oriented method will be applied.
*/

-- / * - TABLES - * /

-- / * - CUSTOMER - * /
CREATE TABLE CUSTOMER (
  CUST_ID INT PRIMARY KEY,
  CUST_DOB DATE,
  CUST_FNAME VARCHAR(20),
  CUST_LNAME VARCHAR(20),
  CUST_GENDER CHAR(1),
  CUST_STR_ADDRESS VARCHAR(30),
  CUST_CITY VARCHAR(20),
  CUST_STATE CHAR(2),
  CUST_ZIP INT,
  CUST_EMAIL VARCHAR(30),
  CUST_PHONE_NUM CHAR(12),
  CUST_DL_NUM VARCHAR(15)
);

-- / * - PAYMENT - * /
CREATE TABLE PAYMENT (
  PAY_ID INTEGER PRIMARY KEY,
  PAY_METHOD VARCHAR(10),
  PAY_AMOUNT DECIMAL(8,2),
  PAY_DEPOSIT VARCHAR(5),
  PAY_DATETIME DATE,
  CUST_ID INT,
  CONSTRAINT fk1 FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER (CUST_ID)
);

-- / * - VEHICLE - * /
CREATE TABLE VEHICLE (
  VEHI_ID INTEGER PRIMARY KEY,
  VEHI_LIC_PLATE VARCHAR(8),
  VEHI_TYPE VARCHAR(10),
  VEHI_MAKE VARCHAR(20),
  VEHI_MODEL VARCHAR(20),
  VEHI_YEAR INTEGER,
  FUEL_TYPE VARCHAR(10),
  VEHI_CONDITION VARCHAR(10)
);

-- / * - RENTAL - * /
CREATE TABLE RENTAL (
  RENT_ID INTEGER PRIMARY KEY,
  RENT_START_DATE DATE,
  RENT_END_DATE DATE,
  RENT_TIME TIME,
  PICKUP_ADDRESS VARCHAR(30),
  DROPOFF_ADDRESS VARCHAR(30),
  MAIN_LOGS VARCHAR(10),
  PAY_ID INTEGER,
  VEHI_ID INTEGER,
  CONSTRAINT fk2 FOREIGN KEY (PAY_ID) REFERENCES PAYMENT (PAY_ID),
  CONSTRAINT fk3 FOREIGN KEY (VEHI_ID) REFERENCES VEHICLE (VEHI_ID)
);

-- / * - MAINTENANCE - * /
CREATE TABLE MAINTENANCE (
  MAIN_ID INTEGER PRIMARY KEY,
  MAIN_DATE DATE,
  MAIN_TIME VARCHAR(19),
  MAIN_WORK_DESC VARCHAR(100),
  VEHI_ID INTEGER,
  MAIN_VENDOR VARCHAR(20),
  MAIN_STATUS VARCHAR(10),
  MAIN_COST DECIMAL(8,2),
  CONSTRAINT fk4 FOREIGN KEY (VEHI_ID) REFERENCES VEHICLE (VEHI_ID)
);

-- / * - RECOMMENDATION - * /
CREATE TABLE RECOMMENDATION (
  REC_ID INTEGER PRIMARY KEY,
  REC_MESSAGE VARCHAR(100),
  CUST_ID INTEGER,
  CONSTRAINT fk5 FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER (CUST_ID)
);

/* Adaptation Note:

- VARCHAR2 and NUMBER data type is replaced with MySQL-equivalent data types: VARCHAR and DECIMAL,
respectively.

- In the RENTAL table, the data type for rent_time changed from DATE to TIME.
*/

-- / * - VALUE - * /

/* Adaptation Note:

- Problem: MySQL date format is in a YYYY-MM-DD, which cannot be changed; thus, the
insert queries below will run into problems with the original Oracle SQL formatting 
("mm/dd/yyyy"). 

- Solution: Use str_to_date method on the dates below.
*/

-- / * - CUSTOMER - * /
INSERT INTO CUSTOMER VALUES (10001, STR_TO_DATE('04/10/1997', '%m/%d/%Y'), 'Hongjoon', 'Kim', 'M', '1234 Rainbow Blvd', 'Banana Town', 'FL', '19191', 'hongtothejoon@hotmail.com', '817-989-1244', 'HP23453123');  
INSERT INTO CUSTOMER VALUES (10002, STR_TO_DATE('10/12/2002', '%m/%d/%Y'), 'Sid', 'Sridharan', 'M', '3131 Golden Gates Rd', 'Nashville', 'TN',  '12312', 'sidisacoolguy23@gmail.com', '123-321-4567', 'TN33344433'); 
INSERT INTO CUSTOMER VALUES (10003, STR_TO_DATE('04/22/1998', '%m/%d/%Y'), 'Junior', 'Kissi', 'M', '5555 Sweet Chin Dr', 'Dallas', 'TX', '76112', 'juniorrocks4141@yahoo.com', '919-089-4555', 'GH12312398');  
INSERT INTO CUSTOMER VALUES (10004, STR_TO_DATE('01/08/2000', '%m/%d/%Y'), 'Hoorad', 'Afshar', 'M', '61283 Nearly Heaven Ct', 'Buffalo', 'NY', '12343', 'hooradtheswordmaster@gmail.com', '455-123-4313', 'BBD45767543');
INSERT INTO CUSTOMER VALUES (10005, STR_TO_DATE('02/22/1990', '%m/%d/%Y'), 'George', 'Washington', 'M', '0704 Independence Blvd', 'Popes Creek',  'VA', '17767', 'georgethefounder@gmail.com', '911-911-1234', 'AMR07041776'); 

-- / * - RECOMMENDATION - * /
INSERT INTO RECOMMENDATION VALUES(101, 'The service was incredible', 10001);
INSERT INTO RECOMMENDATION VALUES(102, 'Coming back', 10002);
INSERT INTO RECOMMENDATION VALUES(103, 'The staff was amazing', 10003);
INSERT INTO RECOMMENDATION VALUES(104, 'Best car rental', 10004);
INSERT INTO RECOMMENDATION VALUES(105, 'Nice cars would recommend', 10005);

-- / * - PAYMENT - * /
INSERT INTO PAYMENT VALUES(78, 'VISA', 98.23, 'YES', STR_TO_DATE('04/14/2023', '%m/%d/%Y'), 10001);
INSERT INTO PAYMENT VALUES(64, 'DEBIT', 123.45, 'NO', STR_TO_DATE('06/28/2023', '%m/%d/%Y'), 10002);
INSERT INTO PAYMENT VALUES(02, 'MASTERCARD', 600.00, 'YES', STR_TO_DATE('07/01/2023', '%m/%d/%Y'), 10003);
INSERT INTO PAYMENT VALUES(44, 'CREDIT', 1861.19, 'YES', STR_TO_DATE('06/03/2023', '%m/%d/%Y'), 10004);
INSERT INTO PAYMENT VALUES(36, 'VISA', 455.69, 'NO', STR_TO_DATE('12/27/2023', '%m/%d/%Y'), 10005);

-- / * - VEHICLE - * /
INSERT INTO VEHICLE VALUES(154657, 'NGT-87QL', 'Sedan', 'Honda', 'Accord', 2018, 'RegularGas', 'Good');
INSERT INTO VEHICLE VALUES(154658, 'DFB-FG38', 'Sedan', 'Hyundai', 'Elantra', 2013, 'RegularGas', 'Good');
INSERT INTO VEHICLE VALUES(154659, 'VJF-GD46', 'Compact', 'Toyota', 'Corolla', 2010, 'RegularGas', 'Bad');
INSERT INTO VEHICLE VALUES(154660, 'EIO-5F7R', 'SUV', 'Mercedes', 'GLE', 2023, 'PremiumGas', 'Good');
INSERT INTO VEHICLE VALUES(154661, 'MDK-45EB', 'Truck', 'Ford', 'F-150', 2019, 'MidGrdGas', 'Good');

-- / * - RENTAL - * /
INSERT INTO RENTAL VALUES(2345, STR_TO_DATE('04/14/2023', '%m/%d/%Y'), STR_TO_DATE('04/18/2023', '%m/%d/%Y'), '01:17:30', '27 Main St', '27 Main St', 'OilChange', 78, 154657);
INSERT INTO RENTAL VALUES(2346, STR_TO_DATE('04/14/2023', '%m/%d/%Y'), STR_TO_DATE('04/18/2023', '%m/%d/%Y'), '01:17:30', '27 Main St', '27 Main St', 'StateInsp', 64, 154658);
INSERT INTO RENTAL VALUES(2347, STR_TO_DATE('04/14/2023', '%m/%d/%Y'), STR_TO_DATE('04/18/2023', '%m/%d/%Y'), '01:17:30', '27 Main St', '27 Main St', 'BrkFluid', 02, 154659);
INSERT INTO RENTAL VALUES(2348, STR_TO_DATE('04/14/2023', '%m/%d/%Y'), STR_TO_DATE('04/18/2023', '%m/%d/%Y'), '01:17:30', '27 Main St', '27 Main St', 'FrtBumpRep', 44, 154660);
INSERT INTO RENTAL VALUES(2349, STR_TO_DATE('04/14/2023', '%m/%d/%Y'), STR_TO_DATE('04/18/2023', '%m/%d/%Y'), '01:17:30', '27 Main St', '27 Main St', 'TireRep', 36, 154661);

-- / * - MAINTENANCE - * /
INSERT INTO MAINTENANCE VALUES(1736, STR_TO_DATE('02/14/2023', '%m/%d/%Y'), '04:17:00', 'OilChange', 154657, 'Driver', 'Complete', 79.99);
INSERT INTO MAINTENANCE VALUES(1737, STR_TO_DATE('02/23/2023', '%m/%d/%Y'), '18:46:00', 'StateInspection', 154658, 'KwikKar', 'Complete', 24.99);
INSERT INTO MAINTENANCE VALUES(1738, STR_TO_DATE('03/02/2023', '%m/%d/%Y'), '11:23:00', 'BrakeFluidFlush', 154659, 'BrakesPlus', 'Incomplete', 99.99);
INSERT INTO MAINTENANCE VALUES(1739, STR_TO_DATE('03/23/2023', '%m/%d/%Y'), '14:12:00', 'FrontBumperReplacement', 154660, 'CaliberCollision', 'Incomplete', 579.99);
INSERT INTO MAINTENANCE VALUES(1740, STR_TO_DATE('03/29/2023', '%m/%d/%Y'), '14:12:00', 'TireReplacement', 154661, 'DiscountTire', 'Complete', 199.99);