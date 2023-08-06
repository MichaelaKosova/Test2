SELECT
	a.year,
	a.average_wage_growth_percent,
	b.average_price_growth_percent,
	c.GDP_growth_percent
FROM (
SELECT
	wage1.year AS year, 
	round(avg(wage1.average_wage)) AS average_wage_per_year,
	round(avg(( wage1.average_wage - wage2.average_wage ) / wage2.average_wage * 100),2) as average_wage_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS wage1
JOIN v_michaela_kosova_project_sql_primary_final AS wage2
	ON wage1.industry_branch = wage2.industry_branch 
	AND wage1.year = wage2.year + 1
GROUP BY year
) a
JOIN (
SELECT
	food1.year_food, 
	round(avg(food1.average_price),2) AS average_price_per_year,
	round(avg(( food1.average_price - food2.average_price ) / food2.average_price * 100),2) as average_price_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS food1
JOIN v_michaela_kosova_project_sql_primary_final AS food2
	ON food1.food_category = food2.food_category  
	AND food1.year_food = food2.year_food + 1
GROUP BY year_food
) b
JOIN (
SELECT
	GDP1.year,
	GDP1.country,
	round((GDP1.GDP - GDP2.GDP) / GDP2.GDP * 100, 2) AS GDP_growth_percent
FROM v_michaela_kosova_project_sql_secondary_final AS GDP1
JOIN v_michaela_kosova_project_sql_secondary_final AS GDP2
	ON GDP1.country = GDP2.country 
	AND GDP1.country = 'Czech Republic'
	AND GDP1.year = GDP2.year + 1
) c
	ON a.year = b.year_food
	AND a.year = c.year
ORDER BY a.year 
;