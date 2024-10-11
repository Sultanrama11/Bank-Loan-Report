-- checking if the dataset already in the database that i created
select *
from bank_loan_db;

-- 1. Total Loan Application
select COUNT(id) as Total_Loan_Application
from bank_loan_db 
;
-- Month to Date (MTD) Loan Aplication
SELECT COUNT(id) AS MTD_Total_Applications 
FROM bank_loan_db	
WHERE MONTH(issue_date) = 11
-- PMTD (Previous Month to Date) Loan Application
SELECT COUNT(id) AS PMTD_Total_Applications 
FROM bank_loan_db
WHERE MONTH(issue_date) = 11

-- 2. Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_db
--MTD (Month to Date) Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_db
WHERE MONTH(issue_date) = 12
--PMTD (Previous Month To Date) Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM bank_loan_db
WHERE MONTH(issue_date) = 11

-- 3. Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received 
FROM bank_loan_db
--MTD (Month to Date) Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received 
FROM bank_loan_db
WHERE MONTH(issue_date) = 12
--PMTD (Previous Month to Date) Total Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received 
FROM bank_loan_db
WHERE MONTH(issue_date) = 11

-- 4. Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate 
FROM bank_loan_db
--MTD (Month to Date) Average Interest Rate
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM bank_loan_db
WHERE MONTH(issue_date) = 12
--PMTD (Previous Month to Date) Average Interest Rate
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate 
FROM bank_loan_db
WHERE MONTH(issue_date) = 11

--5. Average Debt-to-Income Ratio (DTI):
SELECT AVG(dti)*100 AS Avg_DTI 
FROM bank_loan_db
--MTD (Month to Date) Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI 
FROM bank_loan_db
WHERE MONTH(issue_date) = 12
--PMTD (Previous Month to Date) Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI 
FROM bank_loan_db
WHERE MONTH(issue_date) = 11


--Good Bank Loan vs Bad Loan
--6. Good Loan
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
 COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_db
--Good Loan Application
SELECT COUNT(id) AS Good_Loan_Applications 
FROM bank_loan_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount 
FROM bank_loan_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received 
FROM bank_loan_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
--7. Bad Loan
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
 COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_db
-- Bad Loan Application
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM bank_loan_db
WHERE loan_status = 'Charged Off'
--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM bank_loan_db
WHERE loan_status = 'Charged Off'
--Bad Loan Total Received Amount
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM bank_loan_db
WHERE loan_status = 'Charged Off'


-- 8. Loan Status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_db
    GROUP BY
        loan_status

SELECT 
 loan_status, 
 SUM(total_payment) AS MTD_Total_Amount_Received, 
 SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_db
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


-- 9. BANK LOAN REPORT | OVERVIEW
SELECT 
 MONTH(issue_date) AS Month_Munber, 
 DATENAME(MONTH, issue_date) AS Month_name, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--10. State
SELECT 
 address_state AS State, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY address_state
ORDER BY address_state

--11. Term
SELECT 
 term AS Term, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY term
ORDER BY term

--12. Employee Length
SELECT 
 emp_length AS Employee_Length, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY emp_length
ORDER BY emp_length

--13. Purpose
SELECT 
 purpose AS PURPOSE, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY purpose
ORDER BY purpose

--14. Home Ownership
SELECT 
 home_ownership AS Home_Ownership, 
 COUNT(id) AS Total_Loan_Applications,
 SUM(loan_amount) AS Total_Funded_Amount,
 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY home_ownership
ORDER BY home_ownership