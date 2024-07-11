use casestudy




#For this SQL project i will be answering 10 question from this data set
#Let start by introducing the table 



SELECT * FROM [the worlds 100 most powerful women];



# 1. What is the average age of the women in the dataset?


SELECT AVG (cast(AGE as int)) as Average_age 
FROM [the worlds 100 most powerful women];



#  2.	How many women in the dataset are from each country?


SELECT COUNT(NAME) AS NUM_OF_WOMEN, 
LOCATION
FROM [the worlds 100 most powerful women]
GROUP BY LOCATION 
ORDER BY COUNT(NAME) DESC;



#3.	What are the top 5 most common occupations among the women in the dataset?


SELECT top 5 CATEGORY, 
COUNT(CATEGORY) AS most_common_occupations
FROM [the worlds 100 most powerful women]
GROUP BY CATEGORY
ORDER BY most_common_occupations DESC;


#4.	How many women in the dataset are over the age of 40?


SELECT COUNT(AGE) AS OVER40WOMEN 
FROM [the worlds 100 most powerful women]
WHERE AGE > 40
ORDER BY OVER40WOMEN DESC;  


-----OR-----


SELECT NAME, 
AGE AS OVER40WOMEN 
FROM [the worlds 100 most powerful women]
WHERE AGE > 40
ORDER BY OVER40WOMEN DESC;



#5.	What is the youngest and oldest age of the women in the dataset with all data?

#YOUNGEST


SELECT *
FROM [the worlds 100 most powerful women]
where age = (select min(age) from [the worlds 100 most powerful women])


#OLDEST


SELECT top 1 rank,name,age as OldestWomanAge,LOCATION, CATEGORY
FROM [the worlds 100 most powerful women]
ORDER BY OldestWoman DESC


#6.	How many women in the dataset are from United states,Honduras,Barbados?


SELECT  LOCATION, 
COUNT(LOCATION) AS NORTH_AMERICA
FROM [the worlds 100 most powerful women]
GROUP BY LOCATION
HAVING LOCATION IN ('United states', 'Honduras', 'Barbados') ; 



#7.	How many women in the dataset are in the Technology category?


SELECT CATEGORY, 
COUNT(CATEGORY) AS WOMEN_IN_TECH
FROM [the worlds 100 most powerful women]
GROUP BY CATEGORY
HAVING CATEGORY = 'Technology';



#8.	How many women in the dataset are from Asia?



SELECT LOCATION, 
COUNT(LOCATION) AS ASIAN_GIRLPOWER
FROM [the worlds 100 most powerful women]
GROUP BY LOCATION
HAVING LOCATION IN ('China', 'India', 'Singapore',  'Indonesia' , 'Bangladesh', 'Japan', 'South Korea', 'Tiwan')
ORDER BY ASIAN_GIRLPOWER DESC;


#---or----


SELECT LOCATION , 
COUNT(
CASE
WHEN LOCATION IN ('China', 'India', 'Singapore',  'Indonesia' , 'Bangladesh', 'Japan', 
'South Korea', 'Tiwan') Then 1 END) AS GIRLS
FROM [the worlds 100 most powerful women]
GROUP BY LOCATION
ORDER BY GIRLS DESC;



# 9.	What is the standard deviation of the ages of the women in the dataset?



SELECT round(STDEV(cast(AGE as int)),2) AS STDDEV_AGE
FROM [the worlds 100 most powerful women];


 
#10.  ASSIGNMENT LOCATION TO TEMPORARY COULMNS TO SHOWCASE COLUMNS


SELECT *,
CASE 
    WHEN LOCATION IN ('United States', 'Honduras', 'Barbados') THEN 'NORTH AMERICA'
    WHEN LOCATION IN ('Germany', 'Belgium', 'Italy', 'United Kingdom', 'Spain', 'France', 'Denmark',  'Turkey', 'Finland', 'Solvakia') THEN 'EUROPE'
    WHEN LOCATION IN ('China', 'India', 'Taiwan', 'Singapore', 'Indonesia', 'Bangladesh', 'Japan', 'South Korea') THEN 'ASIA'
    WHEN LOCATION IN('Australia','New Zealand') THEN 'OCEANIA'
    WHEN LOCATION IN ('Nigeria', 'Tanzania') THEN 'AFRICA'
    ELSE 'Not Available!' END AS CONTINENT
FROM [the worlds 100 most powerful women]
ORDER BY CONTINENT;



#11. What is the median age of the women in the dataset?



select avg(cast(age as int))median_Age from
(select age,ROW_NUMBER() over (  order by age )rn,
COUNT(*) over()cnt
from [the worlds 100 most powerful women] )a
where rn between cnt*1.0/2  and cnt*1.0/2+1*1.0 
group by age