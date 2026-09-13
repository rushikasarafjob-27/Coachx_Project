CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(30),
    Gender VARCHAR(10),
    Income DECIMAL(10,2)
);

INSERT INTO Customer VALUES
(101,'Amit','Delhi','Male',65000),
(102,'Priya','Mumbai','Female',82000),
(103,'Rahul','Delhi','Male',55000),
(104,'Neha','Pune','Female',90000),
(105,'Rohan','Bangalore','Male',75000),
(106,'Pooja','Delhi','Female',45000),
(107,'Karan','Mumbai','Male',60000),
(108,'Anjali','Chennai','Female',85000),
(109,'Vikas','Pune','Male',72000),
(110,'Sneha','Delhi','Female',95000);

CREATE TABLE Account ( AccountID INT PRIMARY KEY, CustomerID INT, AccountType VARCHAR(20), Balance DECIMAL(12,2), FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) );
INSERT INTO Account VALUES
(201,101,'Savings',120000),
(202,102,'Current',85000),
(203,103,'Savings',45000),
(204,104,'Savings',175000),
(205,105,'Current',95000),
(206,106,'Savings',35000),
(207,107,'Savings',65000),
(208,108,'Current',220000),
(209,109,'Savings',70000),
(210,110,'Current',150000);

CREATE TABLE Transactions
(
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2),
    FOREIGN KEY(AccountID)
    REFERENCES Account(AccountID)
);

INSERT INTO Transactions VALUES
(301,201,'Credit',15000),
(302,202,'Debit',5000),
(303,203,'Credit',8000),
(304,204,'Debit',12000),
(305,205,'Credit',10000),
(306,206,'Debit',2000),
(307,207,'Credit',5000),
(308,208,'Debit',15000),
(309,209,'Credit',9000),
(310,210,'Debit',7000);



CREATE TABLE Loan
(
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(12,2),
    LoanStatus VARCHAR(20),
    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID)
);

INSERT INTO Loan VALUES
(401,101,300000,'Approved'),
(402,102,500000,'Pending'),
(403,103,250000,'Approved'),
(404,104,700000,'Approved'),
(405,105,450000,'Rejected'),
(406,106,150000,'Approved'),
(407,107,350000,'Pending'),
(408,108,800000,'Approved'),
(409,109,200000,'Rejected'),
(410,110,600000,'Approved');


--1.	Display all customers
SELECT * from Customer

--2.	Display customers from Delhi. 

select * from Customer
WHERE City = 'Delhi';

--3.	Display female customers. 

select * from Customer
WHERE Gender = 'Female'

--4.	Find customers whose income is greater than ₹70,000. 

select * from Customer
WHERE income > 70000

-- 5.	Display all savings accounts. 

Select * from Account
where AccountType = 'savings'

--6Display all credit transactions. 

select * from Transactions
where TransactionType = 'credit'

--7.	Display approved loans. 

Select * from Loan
where LoanStatus = 'Approved'

--8.	Display customers sorted by income (highest first). 

Select * from Customer
order by Income desc

--9.	Find the customer with the highest income. 


SELECT *
FROM customer
WHERE income = (SELECT MAX(income) FROM customer);



-- 10.	Display accounts with a balance greater than ₹1,00,000.

Select * from Account
where Balance > 100000

--11.	Find the total customer income. 

select sum(income) as totalincome from Customer

--12.	Find the average account balance. 

select Avg(balance) as Average_Balance from Account

--13.	Find the maximum loan amount. 

Select Max(loanamount) as Loan_amount_Max from Loan

--14.	Count the number of approved loans. 

Select count(*) as approved_Loan from Loan where LoanStatus='Approved'

--15.	Find the total debit transaction amount.

Select sum(amount) as Total_Debit_Amount from Transactions
where TransactionType='Debit'

--16.	Count customers by city. 

Select city, count(*) as Customer_Count from Customer 
Group By City

--17.	Find the average income by city. 

Select City, AVG(Income) as Averageincome from Customer
group by city

--18.	Count customers by gender. 

Select gender, count(*) as Count_Customer from Customer
group by Gender

--19.	Find the total loan amount by loan status. 

Select Loanstatus, sum(loanamount) as Total_Amount from Loan
Group by Loanstatus


--20.	Find the total transaction amount by transaction type.


Select transactiontype, sum(amount)as total_transec from Transactions
group by TransactionType

--21Display customer names with their account balance. 
SELECT Customer.CustomerID, Customer.CustomerName, Customer.City,  Customer.Gender, Account.AccountType, Account.Balance
FROM Customer
JOIN Account
  ON Customer.CustomerID = Account.CustomerID;



  --22.	Display customer names with their loan amount. 

  select Customer.CustomerID,
       Customer.CustomerName,
       Customer.City,
       Customer.Gender,
       Loan.LoanAmount,
       Loan.LoanStatus
FROM Customer
JOIN Loan ON Customer.CustomerID = Loan.CustomerID;

--23.	Display customer names with transaction amounts. 


SELECT Customer.CustomerID, Customer.CustomerName,Customer.City,Customer.Gender,
       Transactions.TransactionID,
       Transactions.TransactionType,
       Transactions.Amount
from Customer
JOIN Account
ON Customer.CustomerID = Account.CustomerID
JOIN Transactions
ON Account.AccountID = Transactions.AccountID;



--24.	Display customer, account, and loan details together. 

SELECT Customer.CustomerID,
       Customer.CustomerName,
       Customer.City,
       Customer.Gender,
       Account.AccountType,
       Account.Balance,
       Loan.LoanAmount,
       Loan.LoanStatus
FROM Customer
JOIN Account ON Customer.CustomerID = Account.CustomerID
JOIN Loan ON Customer.CustomerID = Loan.CustomerID;


--25.	Display customers who do not have an approved loan.

SELECT Customer.CustomerID,
       Customer.CustomerName,
       Customer.City,
       Customer.Gender,
       Loan.LoanAmount,
       Loan.LoanStatus
FROM Customer
JOIN Loan
  ON Customer.CustomerID = Loan.CustomerID
WHERE Loan.LoanStatus <> 'Approved';
