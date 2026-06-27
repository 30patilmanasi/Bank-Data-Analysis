use bank_analytics;

select * from finan_1;	
select * from finance_2;

-- KPI 1 :- Year wise loan amount Stats

select year(issue_d) as issue_year, concat(format(sum(loan_amnt)/1000000,0),'M') as loan_amt 
from finan_1
group by year(issue_d)
order by year(issue_d);

-- KPI 2 :- Grade and sub grade wise revol_bal
select grade,sub_grade, concat(format(sum(revol_bal)/1000000,0),'M') as revol_bal
from finan_1 join finance_2
on finan_1.id = finance_2.id
group by grade,sub_grade
order by grade;


-- KPI 3 :- Total Payment for Verified Status Vs Total Payment for Non Verified Status

select  verification_status, concat(format(sum(total_pymnt)/1000000,1),'M') as total_payment
from finan_1 join finance_2 
on finan_1.id = finance_2.id
where verification_status in ("not verified","verified")
group by verification_status
order by total_payment;

-- KPI 5 :- Home ownership Vs last payment date stats

SELECT home_ownership,count(last_pymnt_d) AS "Total"
FROM finan_1 
LEFT JOIN finance_2 
ON finan_1.id=finance_2.id
GROUP BY home_ownership;

-- KPI 4 :- Month Wise and State Wise Loan Status

Select addr_state as 'Address State',monthname(issue_d) as Month , loan_status as 'Loan Status', count(loan_status) as Total
FROM finan_1
group by addr_state,monthname(issue_d), loan_status
Order by addr_state;