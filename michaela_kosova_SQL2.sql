SELECT DISTINCT YEAR
FROM v_michaela_kosova_project_sql_primary_final;


SELECT
	a.average_wage_2006, 
	a.average_price_milk_2006,
	b.average_price_bread_2006,
	round(a.average_wage_2006/a.average_price_milk_2006,2) AS l_milk_per_wage_2006,
	round(a.average_wage_2006/b.average_price_bread_2006,2) AS kg_bread_per_wage_2006
FROM (
	SELECT 
		year,
		round(avg(average_wage)) AS average_wage_2006, 
		average_price AS average_price_milk_2006
	FROM v_michaela_kosova_project_sql_primary_final
	WHERE year = 2006 AND food_category = 'Mléko polotučné pasterované'
	) a
JOIN (
	SELECT 
		year,
		round(avg(average_wage)) AS average_wage_2006, 
		average_price AS average_price_bread_2006
	FROM v_michaela_kosova_project_sql_primary_final
	WHERE year = 2006 AND food_category = 'Chléb konzumní kmínový'
	) b
	ON a.year = b.year
;


SELECT
	a.average_wage_2018, 
	a.average_price_milk_2018,
	b.average_price_bread_2018,
	round(a.average_wage_2018/a.average_price_milk_2018,2) AS l_milk_per_wage_2018,
	round(a.average_wage_2018/b.average_price_bread_2018,2) AS kg_bread_per_wage_2018
FROM (
	SELECT 
		year,
		round(avg(average_wage)) AS average_wage_2018, 
		average_price AS average_price_milk_2018
	FROM v_michaela_kosova_project_sql_primary_final
	WHERE year = 2018 AND food_category = 'Mléko polotučné pasterované'
	) a
JOIN (
	SELECT 
		year,
		round(avg(average_wage)) AS average_wage_2018, 
		average_price AS average_price_bread_2018
	FROM v_michaela_kosova_project_sql_primary_final
	WHERE year = 2018 AND food_category = 'Chléb konzumní kmínový'
	) b
	ON a.year = b.year
;	