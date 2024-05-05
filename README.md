# TechTFQ-30DaysSQLChallenge-DAY10


Add Missing values SQL challenge

going through the challenge of SQL interview questions featured in the TechTFQ channel



In this repository we will be going through the SQL interview questions featured in the following YouTube video [SQL Interview Questions]([https://www.youtube.com/watch?v=o5W-iAK21ws&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=9](https://www.youtube.com/watch?v=oU8fhP17ozk&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=10)).

# **Day 10: The problem statement:  Auto Repair SQL**


**PROBLEM STATEMENT :**
Create the second table from the 1st one.

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY10/assets/96960411/e64fd362-eda2-42f4-8822-20f88b7795b5)


**DDL & DML**

```
DROP TABLE IF EXISTS auto_repair;

CREATE TABLE auto_repair
  (
     client      VARCHAR(20),
     auto        VARCHAR(20),
     repair_date INT,
     indicator   VARCHAR(20),
     value       VARCHAR(20)
  );

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2022,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2022,
            'velocity',
            '90');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2023,
            'level',
            'regular');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2023,
            'velocity',
            '80');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2024,
            'level',
            'wrong');

INSERT INTO auto_repair
VALUES     ('c1',
            'a1',
            2024,
            'velocity',
            '70');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2022,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2022,
            'velocity',
            '90');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2023,
            'level',
            'wrong');

INSERT INTO auto_repair
VALUES     ('c2',
            'a1',
            2023,
            'velocity',
            '50');

INSERT INTO auto_repair
VALUES     ('c2',
            'a2',
            2024,
            'level',
            'good');

INSERT INTO auto_repair
VALUES     ('c2',
            'a2',
            2024,
            'velocity',
            '80');

SELECT *
FROM   auto_repair; 
```

**DQL**
```
SELECT *
FROM   auto_repair; 

--- we are using the pivot table function
CREATE EXTENSION IF NOT EXISTS tablefunc;

--- Final Solution
SELECT 
	velocity
	, coalesce(good, 0) as good
	, coalesce(wrong, 0) as wrong
	, coalesce(regular, 0) as regular
FROM crosstab('
			SELECT 
			  	V.VALUE AS VELOCITY,
				L.VALUE AS LEVEL,
				COUNT(1) AS VALUE
			FROM AUTO_REPAIR L
			JOIN AUTO_REPAIR V ON L.CLIENT = V.CLIENT
			AND L.AUTO = V.AUTO
			AND L.REPAIR_DATE = V.REPAIR_DATE
			WHERE L.INDICATOR = ''level''
				AND V.INDICATOR = ''velocity''
			GROUP BY V.INDICATOR,
				L.VALUE,
				V.VALUE
			ORDER BY V.VALUE,
				L.VALUE', 'SELECT DISTINCT VALUE
					FROM AUTO_REPAIR
				WHERE
					INDICATOR = ''level''
				ORDER BY VALUE') 
as result(
	velocity numeric,
	good numeric,
	regular numeric,
	wrong numeric
);

```
