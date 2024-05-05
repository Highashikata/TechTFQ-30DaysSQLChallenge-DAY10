SELECT *
FROM   auto_repair; 

--- we are using the pivot table function
CREATE EXTENSION IF NOT EXISTS tablefunc;

--- 

select 
	velocity,
	select indicator, value, count(*) FILTER(WHERE value = 'good') over(order by client) Good from auto_repair,
	count(*) FILTER(WHERE value = 'wrong') over(order by client) Wrong,
	count(*) FILTER(WHERE value = 'regular') over(order by client) Regular
FROM	
	crosstab('select indicator, value from 
			 auto_repair order by 1'
			, 'SELECT distinct value from auto_repair where indicator = ''velocity''')
as result(
	velocity numeric,
	Good numeric,
	Wrong numeric,
	Regular numeric);
			 


----
SELECT
INDICATOR,
	VALUE
FROM AUTO_REPAIR
WHERE
	INDICATOR = 'velocity'
ORDER BY 
	value;
	
-- Fetching the Data
SELECT *
FROM   auto_repair;  

-- Doing transformation before pivoting the table
SELECT V.VALUE AS VELOCITY,
	L.VALUE AS LEVEL,
	COUNT(1) AS VALUE
FROM AUTO_REPAIR L
JOIN AUTO_REPAIR V ON L.CLIENT = V.CLIENT
AND L.AUTO = V.AUTO
AND L.REPAIR_DATE = V.REPAIR_DATE
WHERE L.INDICATOR = 'level'
	AND V.INDICATOR = 'velocity'
GROUP BY V.INDICATOR,
	L.VALUE,
	V.VALUE
ORDER BY V.VALUE,
	L.VALUE;
	
	
-- Now pivoting the talbe using CROSSTAB
-- Extension install.
CREATE EXTENSION IF NOT EXISTS tablefunc;

----- Draft and testing queries

-- SELECT
-- 	velocity,
-- 	good,
-- 	wrong,
-- 	regular
-- FROM
-- 	CROSSTAB('SELECT 
-- 			 	V.VALUE AS VELOCITY,
-- 				L.VALUE AS LEVEL,
-- 				COUNT(1) AS VALUE
-- 			  FROM 
-- 			 	AUTO_REPAIR L
-- 			  JOIN 
-- 			 	AUTO_REPAIR V 
-- 			  ON 
-- 			 	L.CLIENT = V.CLIENT
-- 				AND L.AUTO = V.AUTO
-- 				AND L.REPAIR_DATE = V.REPAIR_DATE
-- 			  WHERE 
-- 			 	L.INDICATOR = ''level''
-- 				AND V.INDICATOR = ''velocity''
-- 			  GROUP BY 
-- 			 	V.INDICATOR,
-- 				L.VALUE,
-- 				V.VALUE
-- 			  ORDER BY 
-- 			 	V.VALUE,
-- 				L.VALUE', 
-- 			 'SELECT distinct value, level from(
-- 					SELECT V.VALUE AS VELOCITY,
-- 						L.VALUE AS LEVEL,
-- 						COUNT(1) AS VALUE
-- 					FROM AUTO_REPAIR L
-- 					JOIN AUTO_REPAIR V ON L.CLIENT = V.CLIENT
-- 					AND L.AUTO = V.AUTO
-- 					AND L.REPAIR_DATE = V.REPAIR_DATE
-- 					WHERE L.INDICATOR = ''level''
-- 						AND V.INDICATOR = ''velocity''
-- 					GROUP BY V.INDICATOR,
-- 						L.VALUE,
-- 						V.VALUE
-- 					ORDER BY V.VALUE,
-- 						L.VALUE
-- 			)') as result(
-- 				velocity numeric,
-- 				good numeric,
-- 				wrong numeric,
-- 				regular numeric
-- 			);
	

	

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
	
	
	
	

