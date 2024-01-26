/* Car Rental Database Query Trial 
Course: ITSS 4300 Database Fundamentals
Period: Spring Semester of 2023
Original Contributors: Sid Sridharan, Hoorad Afshar, Hoogjoon Kim, Amon Kissi 
MySQL Compiler/Adapter: Hongjoon Kim
*/

/* Introduction
The purpose of this script is to compile the query trials from 
the four team members including myself. Other than the possible 
syntatical changes to accomodate to MySQL, the descriptions of
the following queries by each member have not been changed.
The order of queries and members is also preserved.

Adaptations will be noted by me, the compiler and adapter.
*/

/* Team Member 1's Queries */

SELECT 
    *
FROM
    RENTAL
WHERE
    VEHI_ID LIKE 154658;
-- Calls for the car with vehicle ID 154658 from the rental table.

SELECT 
    *
FROM
    PAYMENT
WHERE
    PAY_METHOD LIKE 'MASTERCARD';
-- Calls for the payments of a rental car that used a Mastercard.

/* Hongjoon's Queries */

SELECT 
    V.VEHI_TYPE,
    CONCAT("$",CAST(SUM(M.MAIN_COST) AS CHAR)) AS 'TOTAL MAINTENANCE COST' -- Adapted
FROM
    VEHICLE V
        RIGHT JOIN
    MAINTENANCE M ON V.VEHI_ID = M.VEHI_ID
GROUP BY VEHI_TYPE
HAVING SUM(M.MAIN_COST) > 200; 
-- Lists vehicle types with the total maintenance cost greater than $ 200.00

/* Adaptation Note:
"TO_CHAR(SUM(M.MAIN_COST)" in line 40 is omitted due to non-existence of to_char in MySQL.
"CONCAT("$",CAST(SUM(M.MAIN_COST)AS CHAR))" is used to preserve the output.
*/

SELECT 
    P.CUST_ID,
    CONCAT("$",CAST(SUM(P.PAY_AMOUNT) AS CHAR)) AS 'TOTAL RENTAL PAYMENT' -- Adapted
FROM
    CUSTOMER C
        RIGHT JOIN
    PAYMENT P ON C.CUST_ID = P.CUST_ID
GROUP BY P.CUST_ID
HAVING SUM(P.PAY_AMOUNT) > 200;
-- Retrieves a list of customers who have brought the company with gross earning of more than $200.

/* Adaptation Note:
 "TO_CHAR(SUM(P.PAY_AMOUNT), '$9999.99')" in line 56 is omitted due to non-existence of to_char 
 in MySQL. "CONCAT("$",CAST(SUM(P.PAY_AMOUNT) AS CHAR))" is used to preserve the output.
*/

SELECT 
    PAY_METHOD,
    CONCAT("$",CAST(SUM(PAY_AMOUNT) AS CHAR)) AS 'TOTAL PAYMENT AMOUNT' -- Adapted
FROM
    PAYMENT
GROUP BY PAY_METHOD
HAVING SUM(PAY_AMOUNT) > 1000;
-- Retrieves a list of payment methods with the transaction amount more than $1,000.

/* Adaptation Note:
"TO_CHAR(SUM(PAY_AMOUNT), '$9999.99')" in line 40 is omitted due to non-existence of to_char in 
MySQL. "CONCAT("$",CAST(SUM(M.MAIN_COST)AS CHAR))" is used to preserve the output.
*/

/* Team Member 2's Query */

 SELECT 
    CUST_FNAME, CUST_LNAME
FROM
    CUSTOMER
WHERE
    CUST_ID IN (SELECT 
            PAYMENT.CUST_ID
        FROM
            PAYMENT
                JOIN
            RENTAL ON PAYMENT.PAY_ID = RENTAL.PAY_ID
                JOIN
            VEHICLE ON RENTAL.VEHI_ID = VEHICLE.VEHI_ID
                JOIN
            MAINTENANCE ON VEHICLE.VEHI_ID = MAINTENANCE.VEHI_ID
        WHERE
            MAINTENANCE.MAIN_VENDOR = 'DiscountTire'); 
/* Retrieves customer’s first and last name (in that order) under the context of customer’s id 
from payment (joining rental, vehicle, and maintenance) from the vendor Discount Tire. */

/* Team Member 3's Queries */

SELECT 
    CUSTOMER.CUST_FNAME,
    CUSTOMER.CUST_LNAME,
    VEHICLE.VEHI_LIC_PLATE,
    VEHICLE.VEHI_TYPE,
    VEHICLE.VEHI_MAKE,
    VEHICLE.VEHI_MODEL,
    VEHICLE.VEHI_YEAR,
    VEHICLE.FUEL_TYPE,
    VEHICLE.VEHI_CONDITION
FROM
    VEHICLE
        JOIN
    RENTAL ON VEHICLE.VEHI_ID = RENTAL.VEHI_ID
        JOIN
    PAYMENT ON RENTAL.PAY_ID = PAYMENT.PAY_ID
        JOIN
    CUSTOMER ON PAYMENT.CUST_ID = CUSTOMER.CUST_ID; 
/* Retrieves data from Tables "CUSTOMER" "VEHICLE" "RENTAL" and "PAYMENT" to display information 
about customer name and vehicle. */

DELETE FROM RENTAL 
WHERE
    MAIN_LOGS = 'StateInsp';
/* Deletes all records from the "RENTAL" table where the "MAIN_LOGS" column has a value of 
"StateInsp". */