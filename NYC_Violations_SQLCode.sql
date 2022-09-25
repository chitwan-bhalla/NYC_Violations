-- Create Table Raw Data and import first 2 million values from 85 million records for NYC Violations from Data.gov

--CREATE TABLE RAW_DATA 
--(
--ID INT PRIMARY KEY IDENTITY(1,1)  , Plate VARCHAR(255), State VARCHAR(255), LicenceType VARCHAR(255), SummonsNumber BIGINT, IssueDate DATE, ViolationTime VARCHAR (255), Violation VARCHAR(255),
--JudgmentEntryDate DATE, FineAmount INT, PenaltyAmount INT, InterestAmount DECIMAL(5,2) , ReductionAmount DECIMAL(5,2), PaymentAmount DECIMAL(5,2),
--AmountDue INT, Precinct INT, County VARCHAR(255), IssuingAgency VARCHAR(255), ViolationStatus VARCHAR(255)
--);

-- Delete the dupicate rows deom the records
SELECT COUNT(DISTINCT SummonsNumber) 
FROM RAW_DATA;

-- Find the count of duplicate recods
SELECT SummonsNumber, COUNT(SummonsNumber) AS COUNT
FROM RAW_DATA
GROUP BY SummonsNumber
HAVING COUNT(SummonsNumber)>1;

-- Delete
DELETE FROM RAW_DATA
WHERE ID NOT IN 
(
SELECT MAX(ID)
FROM RAW_DATA
GROUP BY SummonsNumber
);

--Update Nulls [01/01/1900]

UPDATE RAW_DATA
SET JudgmentEntryDate = '01/01/1900' 
WHERE JudgmentEntryDate IS NULL;

-- Check to confirm that the changes are done
SELECT JudgmentEntryDate 
FROM RAW_DATA 
WHERE JudgmentEntryDate IS NULL;


-- Data checks
-- Total Count
SELECT COUNT(*) FROM RAW_DATA;

 -- Check all the years
 SELECT DISTINCT(YEAR(IssueDate)) 
 FROM RAW_DATA
 ORDER BY 1

 -- Found issue dates greater than 2022. Will require some data cleaning
 SELECT COUNT(*) 
 FROM RAW_DATA 
 WHERE YEAR(IssueDate)>YEAR(GETDATE());

 SELECT *
 FROM RAW_DATA 
 WHERE YEAR(IssueDate)>YEAR(GETDATE());

 --Deleted rows because date could not be reconciled
 DELETE FROM RAW_DATA
 WHERE YEAR(IssueDate)>YEAR(GETDATE());

 -- Confirm Judgment Entry Dates
 SELECT COUNT(*) 
 FROM RAW_DATA 
 WHERE YEAR(JudgmentEntryDate)>YEAR(GETDATE());

 SELECT COUNT(COUNTY) from RAW_DATA WHERE COUNTY = ' ';

 -- Check if the amounts add-up
 SELECT 
	 (A.FineAmount +A.PenaltyAmount+A.InterestAmount) - A.ReductionAmount 'FULLAMT',
	 A.PaymentAmount,
	 A.FineAmount,
	 A.PenaltyAmount, 
	 A.InterestAmount, 
	 A.ReductionAmount,
	 A.ViolationStatus
 FROM 
	RAW_DATA A
 WHERE 
	(A.FineAmount +A.PenaltyAmount+A.InterestAmount) - A.ReductionAmount <> A.PaymentAmount

 -- Update Payment Amount where the amounts don't match up
 UPDATE RAW_DATA
 SET PaymentAmount =  ((FineAmount + PenaltyAmount+ InterestAmount) - ReductionAmount)
 WHERE  ((FineAmount + PenaltyAmount+ InterestAmount) - ReductionAmount) <> PaymentAmount;

 -- Check the complete sum of Fine and Penalty amount to Payment Amount to make sure they are equal
 SELECT SUM((R.FineAmount + R.PenaltyAmount + R.InterestAmount) - R.ReductionAmount) AS SUM_OF_AMOUNTS, 
 SUM(R.PaymentAmount) AS SUM_OF_AMOUNTS_DATABASE
 FROM RAW_DATA R;

 -- Analysing Cunty column and removing all blanks
  SELECT DISTINCT(County) 
  FROM RAW_DATA;

 SELECT COUNT(County) AS TOTALCOUNT 
 FROM RAW_DATA 
 WHERE County=' ';

 DELETE FROM RAW_DATA
 WHERE County = ' ';

--Check the Violation Status and update the empty ones to N/A
SELECT DISTINCT(ViolationStatus) 
FROM RAW_DATA;

SELECT COUNT(ViolationStatus) 
FROM RAW_DATA 
WHERE ViolationStatus = ' ';

UPDATE RAW_DATA
SET ViolationStatus = 'N/A'
WHERE ViolationStatus=' ';

-- Check the Violation and update the empty ones to N/A
SELECT COUNT(Violation) 
FROM RAW_DATA 
WHERE Violation=' ';

SELECT * 
FROM RAW_DATA 
WHERE Violation = ' ';

UPDATE RAW_DATA
SET Violation ='N/A'
WHERE Violation=' ';
SELECT COUNT(*) FROM RAW_DATA;
-- Clean data contains 1708349 records

-- Fix County names
SELECT DISTINCT(County) FROM RAW_DATA;

UPDATE RAW_DATA
SET
--County = 'Bronx' WHERE County IN ('BX');
--County = 'Queens' WHERE County IN ('QN', 'Q', 'Qns');
--County = 'Brooklyn' WHERE County IN ('K', 'Kings', 'BK');
--County = 'Rockland' WHERE County IN ('R');
--County = 'Manhattan' WHERE County IN ('MN', 'NY');
County = 'Staten Island' WHERE County IN ('ST');
