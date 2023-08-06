CREATE OR REPLACE VIEW v_michaela_kosova_project_SQL_primary_final AS 
SELECT * 
FROM (
SELECT
	cpay.payroll_year AS year,	
	cpib.name AS industry_branch,
	round(avg(cpay.value)) AS average_wage
FROM czechia_payroll AS cpay 
JOIN czechia_payroll_industry_branch AS cpib 
	ON cpay.industry_branch_code = cpib.code 
	AND cpay.value_type_code = 5958 
GROUP BY cpib.name, cpay.payroll_year
) a
JOIN (
SELECT 
	year(cp.date_from) AS year_food,
	cpc.name AS food_category,
	cpc.price_unit AS food_unit,
	round(avg(cp.value), 2) AS average_price
FROM czechia_price AS cp 
JOIN czechia_price_category AS cpc 	
	ON cp.category_code = cpc.code 
GROUP BY cpc.name, year(cp.date_from)
) b
ON a.year = b.year_food
;