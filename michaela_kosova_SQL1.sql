SELECT
	wage1.year, 
	wage1.industry_branch,
	round((wage1.average_wage - wage2.average_wage) / wage2.average_wage * 100, 2) as wage_growth_percent
FROM v_michaela_kosova_project_sql_primary_final AS wage1
JOIN v_michaela_kosova_project_sql_primary_final AS wage2
	ON wage1.industry_branch = wage2.industry_branch 
	AND wage1.year = wage2.year + 1
WHERE round((wage1.average_wage - wage2.average_wage) / wage2.average_wage * 100, 2) < 0
GROUP BY industry_branch, YEAR
;