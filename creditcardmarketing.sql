-- 1. Create a new DB:
create database if not exists credit_card_classification;
use credit_card_classification;



-- 2,3. Create the table 'house_price_data'. I created it by using import wizerd .



-- 4. Select all the data from table credit_card_data to check if the data was imported correctly.
select * from credit_card_data;



-- 5. Use the alter table command to drop the column q4_balance from the database.
alter table credit_card_data
drop column `Q4 Balance`; 

select * from credit_card_data
limit 10;


-- 6. Use sql query to find how many rows of data you have.
select count(*) from credit_card_data;



-- 7. Find the unique values
-- 7.1 The unique values in the column Offer_accepted:
select distinct `Offer Accepted`
from credit_card_data
order by `Offer Accepted`asc;


-- 7.2 The unique values in the column Reward:
select distinct Reward
from credit_card_data
order by Reward asc;



-- 7.3 The unique values in the column mailer_type:
select distinct `Mailer Type`
from credit_card_data
order by `Mailer Type` asc;


-- 7.4 The unique values in the column credit_cards_held:
select distinct `# Credit Cards Held`
from credit_card_data
order by `# Credit Cards Held` asc;


-- 7.5 The unique values in the column household_size :
select distinct `Household Size`
from credit_card_data
order by `Household Size` asc;



-- 8. The customer_number of the top 10 customers with the highest average_balances
select `Average Balance`, `Customer Number`
from credit_card_data
order by `Average Balance` desc
limit 10;



-- 9. The average balance of all the customers in your data
select avg(`Average Balance`) avg_balance
from credit_card_data;



-- 10.1 The average balance of the customers grouped by Income Level:
select `Income Level`, avg(`Average Balance`) as avg_balance
from credit_card_data
group by `Income Level`;


-- 10.2 The average balance of the customers grouped by number_of_bank_accounts_open:
select `# Bank Accounts Open`, avg(`Average Balance`) as avg_balance
from credit_card_data
group by `# Bank Accounts Open`;


-- 10.3 The average number of credit cards held grouped by credit card ratings:
select `Credit Rating`, avg(`# Credit Cards Held`) as avg_Credit_Held
from credit_card_data
group by `Credit Rating`;


-- 10.4 Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open?
select `# Credit Cards Held`, avg(`# Bank Accounts Open`) AS avg_bank_accounts_open
from credit_card_data
group by `# Credit Cards Held`
order by `# Credit Cards Held` asc;  -- There is no clear correlation 



-- 11. Filter customers based on specified criteria:
select `Customer Number`,`Credit Rating`, `# Credit Cards Held`,`Own Your Home`, `Household Size`,`Offer Accepted`
from credit_card_data
where `Credit Rating` in ('Medium','High')
and `# Credit Cards Held` <= 2
and `Own Your Home` = 'Yes'
and `Household Size` >= 3
and `Offer Accepted` = 'Yes';





-- 12. The list of customers whose average balance is less than the average balance of all the customers in the database
select `Customer Number`, `Average Balance`
from credit_card_data
where `Average Balance`< ( select 
                                  avg(`Average Balance`)
							from 
                                  credit_card_data);
                                  
          
          
                                  
                                  
-- 13. Create a view for customers with below-average balance: 	
	create view customers_below_average_balance AS
    select `Customer Number`, `Average Balance`
from credit_card_data
where `Average Balance`< ( select 
                                  avg(`Average Balance`)
							from 
                                  credit_card_data);





-- 14. The number of people who accepted the offer vs number of people who did not:
select count(*), `Offer Accepted`
from credit_card_data
group by `Offer Accepted`;




-- 15. The difference in average balances of the customers with high credit card rating and low credit card rating:
select `Customer Number`,
(select avg(`Average Balance`) from credit_card_data where `Credit Rating` = 'High')  -
(select avg(`Average Balance`) from credit_card_data where `Credit Rating` = 'Low') as Credit_Rating_difference
from credit_card_data;



-- 16. Types of communication (mailer_type) used and how many customers received each:
select `Mailer Type`, count(*) as total_number
from credit_card_data
group by `Mailer Type`;



-- 17. Details of the customer with the 11th least Q1_balance:
select * from credit_card_data
order by `Q1 Balance` asc
limit 1 offset 10;








