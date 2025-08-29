### 3 EXPLORATORY DATA ANALAYSIS (EDA)
 
          # KEY FINDINGS :-

          -- 1 What is the count of distinct cities in the dataset?
 # ANSWER :- 3
 ## QUERY :-   
             SELECT COUNT(DISTINCT CITY) COUNT_DIST_CITIES FROM AMAZON_SALES;      
         
          -- 2 For each branch, what is the corresponding city?
 # ANSWER :- yangon,naypitaw and mandalay.
 ## QUERY :-        
             SELECT DISTINCT BRANCH, CITY AS BRANCH_WISE_CITY FROM AMAZON_SALES;

         --  3 What is the count of distinct product lines in the dataset?
 # ANSWER :- 6
 ## QUERY :-
             SELECT COUNT(DISTINCT PRODUCT_LINE) AS COUNT_DIST_PRODUCT_LINE FROM AMAZON_SALES;

		  -- 4 Which payment method occurs most frequently?
 # ANSWER :- ewallet
 ## QUERY :-
             SELECT PAYMENT,COUNT(PAYMENT) AS MOSTLY_USED_PAY_METHOD FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 1 DESC
             LIMIT 1;

		  -- 5 Which product line has the highest sales?
 # ANSWER :- food and beverages
 ## QUERY :-         
             SELECT PRODUCT_LINE,SUM(TOTAL) HIGHEST_SALES FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;

		  -- 6 How much revenue is generated each month?
 # ANSWER :- january : 116291.86800000005, march : 109455.50700000004 and februay : 97219.37399999997
 ## QUERY :-        
             SELECT MONTHNAME(STR_TO_DATE(DATE,'%m/%d/%Y'))AS MONTH, SUM(TOTAL) AS TOTAL_REVENUE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC;

		  -- 7 In which month did the cost of goods sold reach its peak?
 # ANSWER :- january
 ## QUERY :- 
             SELECT MONTHNAME(STR_TO_DATE(DATE,'%m/%d/%Y')) PEAK_MONHT,SUM(COGS) AS COGS FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;

          -- 8 Which product line generated the highest revenue?
 # ANSWER :- food and beverages
 ## QUERY :-
             SELECT PRODUCT_LINE ,SUM(TOTAL) AS HIGHEST_REVENUE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
			 LIMIT 1;

		  -- 9 In which city was the highest revenue recorded?
 # ANSWER :- naypyitaw
 ## QUERY :-
             SELECT CITY, SUM(TOTAL) HIGHEST_REVENUE_CITY FROM AMAZON_SALES
			 GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;

          -- 10 Which product line incurred the highest Value Added Tax?
 # ANSWER :- food and beverages
 ## QUERY :-
             SELECT PRODUCT_LINE,SUM(TAX) AS HIGHEST_VAT_PROD_LINE FROM AMAZON_SALES
			 GROUP BY 1
             ORDER BY 2 DESC 
             LIMIT 1;
             
          -- 11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
 # ANSWER :- added column sales_performance good if sales_greater then avgerag else bad.
 ## QUERY :- 
			 SELECT PRODUCT_LINE, SUM(TOTAL) AS TOTAL_SALES,
             (CASE 
             WHEN SUM(TOTAL) > (SELECT AVG(TOTAL) FROM AMAZON_SALES) THEN 'GOOD'
			 ELSE 'BAD'
			 END) AS SALES_PERFORMANCE
             FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC;
 
          -- 12 Identify the branch that exceeded the average number of products sold.
 # ANSWER :- branch A, branch C, branch B.
 ## QUERY :- 
             SELECT BRANCH, SUM(QUANTITY) AS AVG_PRODUCT_SOLD FROM AMAZON_SALES
			 GROUP BY 1 
             HAVING SUM(QUANTITY) > (SELECT AVG(QUANTITY) FROM AMAZON_SALES);
             
          -- 13 Which product line is most frequently associated with each gender?
 # ANSWER :- fashion accessories and health & beauty 
 ## QUERY :- 
             WITH PRODUCTLINE_RANK AS 
             (SELECT GENDER,PRODUCT_LINE,COUNT(*) PURCHASE_SALES,
             ROW_NUMBER()OVER(PARTITION BY GENDER ORDER BY COUNT(*)DESC) AS ROW_NUM 
             FROM AMAZON_SALES
             GROUP BY 1,2)
             SELECT GENDER,PRODUCT_LINE FROM PRODUCTLINE_RANK
             WHERE ROW_NUM = 1;
             
          -- 14 Calculate the average rating for each product line.
 # ANSWER :- 7.113218390804598, 7.029213483146067, 7.003289473684212, 6.92470588235294, 6.916265060240964 and 6.8375
 ## QUERY :-
             SELECT PRODUCT_LINE, AVG(RATING) AVG_RATING_PROD_LINE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC;
             
          -- 15 Count the sales occurrences for each time of day on every weekday.
 # ANSWER :- weekday based on sales_occurrences 
 ## QUERY :- 
             SELECT DAY_NAME AS WEEKDAY,TIME_OF_DAY, COUNT(*)AS SALES_OCCURRENCES FROM AMAZON_SALES
             GROUP BY 1,2
             ORDER BY 
             CASE DAY_NAME 
             WHEN 'MONDAY' THEN 1 
             WHEN 'TUESDAY' THEN 2
             WHEN 'WEDNESDAY' THEN 3 
             WHEN 'THURSDAY' THEN 4 
             WHEN 'FRIDAY' THEN 5 
             WHEN 'SATURDAY' THEN 6
             WHEN 'SUNDAY' THEN 7 
             END,
             SALES_OCCURRENCES DESC;
             
          -- 16 Identify the customer type contributing the highest revenue.
 # ANSWER :- member
 ## QUERY :- 
			 SELECT CUSTOMER_TYPE, SUM(TOTAL) AS CUST_TYPE_HIGHEST_REVENUE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;
             
          -- 17 Determine the city with the highest VAT percentage.
 # ANSWER :- naypyitaw
 ## QUERY :-
             SELECT CITY, SUM(TAX) AS CITY_HIGHEST_VAT_PERCTAGE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC 
             LIMIT 1;
             
          -- 18 Identify the customer type with the highest VAT payments.
 # ANSWER :- member 
 ## QUERY :-
             SELECT CUSTOMER_TYPE, SUM(TAX) AS HIGHEST_VAT FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;
             
          -- 19 What is the count of distinct customer types in the dataset?
 # ANSWER :- 2 
 ## QUERY :-
			 SELECT COUNT(DISTINCT CUSTOMER_TYPE) AS UNIQUE_CUST_TYPE FROM AMAZON_SALES;
              
          -- 20 What is the count of distinct payment methods in the dataset?
 # ANSWER :- 3 
 ## QUERY :-
             SELECT COUNT(DISTINCT PAYMENT) UNIQUE_PAYMENT_METHOD FROM AMAZON_SALES;
             
          -- 21 Which customer type occurs most frequently?
 # ANSWER :- 3 
 ## QUERY :- member
             SELECT CUSTOMER_TYPE AS MOST_FREQUENTLY_OCCURS, COUNT(*)  AS COUNT FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;
             
          -- 22 Identify the customer type with the highest purchase frequency.
 # ANSWER :- member: 2785
 ## QUERY :-
             SELECT CUSTOMER_TYPE,SUM(QUANTITY) AS HIGHEST_PURCHASE FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;
             
		  -- 23 Determine the predominant gender among customers.
 # ANSWER :- female
 ## QUERY :-
			 SELECT GENDER,COUNT(CUSTOMER_TYPE)GENDER_COUNT FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
		     LIMIT 1;
             
          -- 24 Examine the distribution of genders within each branch.
 # ANSWER :- branch wise distribution
 ## QUERY :-
             SELECT BRANCH, GENDER, COUNT(*) GENDER_COUNT  FROM AMAZON_SALES
             GROUP BY 1,2
             ORDER BY 1,2;
            
          -- 25 Identify the time of day when customers provide the most ratings.
 # ANSWER :- afternoon
 ## QUERY :-
             SELECT TIME_OF_DAY, COUNT(RATING) AS MOST_RATING FROM AMAZON_SALES
             GROUP BY 1
             LIMIT 1;
             
          -- 26 Determine the time of day with the highest customer ratings for each branch.
 # ANSWER :- branch wise highest customer rating by time of day
 ## QUERY :- 
             WITH HIGHEST_CUST_RATING AS (
             SELECT BRANCH,TIME_OF_DAY, SUM(RATING) AS HIGHEST_RATING 
             FROM AMAZON_SALES
             GROUP BY 1,2
             ORDER BY 3 DESC)
             SELECT BRANCH, TIME_OF_DAY FROM HIGHEST_CUST_RATING;
             
          -- 27 Identify the day of the week with the highest average ratings.
 # ANSWER :- monday
 ## QUERY :-
             SELECT DAYNAME(STR_TO_DATE(DATE,'%m/%d/%Y')) DAY_NAME,AVG(RATING)HIGHEST_AVG_RATING 
             FROM AMAZON_SALES
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1;
             
          -- 28 Determine the day of the week with the highest average ratings for each branch.
 # ANSWER :- branch A: friday, branch B: monday, branch C: friday 
 ## QUERY :- 
             WITH BRANCH_WISE_AVG_RATING AS (
             SELECT BRANCH, DAYNAME(STR_TO_DATE(DATE,'%m/%d/%Y')) AS DAY_NAME, AVG(RATING) HIGHEST_AVG_RATING,
             ROW_NUMBER()OVER(PARTITION BY BRANCH ORDER BY AVG(RATING) DESC) AS ROW_NUM
             FROM AMAZON_SALES
             GROUP BY 1,2)
             SELECT BRANCH, DAY_NAME FROM BRANCH_WISE_AVG_RATING
             WHERE ROW_NUM = 1;