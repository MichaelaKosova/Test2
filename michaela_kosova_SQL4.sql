/* YEARS WHERE AVERAGE PRICE GROWTH WAS SIGNIFICANTLY HIGHER THAN AVERAGE WAGE GROWTH, DIFFERENCE GREATER THAN 10 % */

SELECT *
FROM (
SELECT
	wage1.year, 
	round(avg((wage1.average_wage - wage2.average_wage ) / wage2.average_wage * 100),2) as average_wage_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS wage1
JOIN v_michaela_kosova_project_sql_primary_final AS wage2
	ON wage1.industry_branch = wage2.industry_branch 
	AND wage1.year = wage2.year + 1
GROUP BY year
) a
JOIN (
SELECT
	food1.year_food, 
	round(avg(( food1.average_price - food2.average_price ) / food2.average_price * 100),2) as average_price_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS food1
JOIN v_michaela_kosova_project_sql_primary_final AS food2
	ON food1.food_category = food2.food_category  
	AND food1.year_food = food2.year_food + 1
GROUP BY year_food
) b
	ON a.year = b.year_food
WHERE (b.average_price_growth_percent - a.average_wage_growth_percent) > 10
ORDER BY a.year
;


/* YEARS WHERE AVERAGE PRICE GROWTH WAS HIGHER THAN AVERAGE WAGE GROWTH */

SELECT *
FROM (
SELECT
	wage1.year, 
	round(avg((wage1.average_wage - wage2.average_wage ) / wage2.average_wage * 100),2) as average_wage_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS wage1
JOIN v_michaela_kosova_project_sql_primary_final AS wage2
	ON wage1.industry_branch = wage2.industry_branch 
	AND wage1.year = wage2.year + 1
GROUP BY year
) a
JOIN (
SELECT
	food1.year_food, 
	round(avg(( food1.average_price - food2.average_price ) / food2.average_price * 100),2) as average_price_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS food1
JOIN v_michaela_kosova_project_sql_primary_final AS food2
	ON food1.food_category = food2.food_category  
	AND food1.year_food = food2.year_food + 1
GROUP BY year_food
) b
	ON a.year = b.year_food
WHERE b.average_price_growth_percent > a.average_wage_growth_percent
ORDER BY a.year
;