CREATE OR REPLACE VIEW v_michaela_kosova_project_SQL_secondary_final AS 
SELECT
	c.country,
	c.population,
	e.year,
	e.GDP
FROM countries AS c 
JOIN economies AS e
	ON c.country = e.country
	AND e.year >=2006 
	AND e.year <=2018
WHERE c.continent = 'Europe'
;