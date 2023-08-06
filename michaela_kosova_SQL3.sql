SELECT
	food1.food_category,
	round (avg(( food1.average_price - food2.average_price ) / food2.average_price * 100),2) AS average_price_growth_2006_2018
FROM v_michaela_kosova_project_sql_primary_final AS food1
JOIN v_michaela_kosova_project_sql_primary_final AS food2
	ON food1.food_category = food2.food_category  
	AND food1.year = food2.year + 1
GROUP BY food_category
ORDER BY average_price_growth_2006_2018
;