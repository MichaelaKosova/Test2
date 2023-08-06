CREATE TABLE address (
  id serial,
  street varchar(255),
  street_number int,
  city varchar(255),
  zip_code varchar(6)
);
INSERT INTO address(street,street_number,city,zip_code) VALUES ('Doktorská', 1, 'Engetov', '123 00');
INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 1, 'Engetov', '111 11');
INSERT INTO address(street,street_number,city,zip_code) VALUES ('Pacientská', 2, 'Engetov', '567 89');


CREATE TABLE doctor (
  id serial,
  name varchar(255),
  surname varchar(255),
  address_id int,
  phone_number varchar(20),
  email varchar(255)
);
INSERT INTO doctor(name,surname,address_id,phone_number,email) VALUES ('Jan', 'Doktor', 1, '+420 123 456 789', 'doktor@engeto.cz');


CREATE TABLE patient (
  id serial,
  name varchar(255),
  surname varchar(255),
  address_id int,
  insurance_company varchar(255)
);
INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Petr', 'Pacient', 2, 'Engeto insurance');
INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Libor', 'Pacient', 3, 'Engeto insurance');
INSERT INTO patient(name,surname,address_id,insurance_company) VALUES ('Stanislav', 'Pacient', 3, 'State insurance');


CREATE TABLE medicament (
  id serial,
  name varchar(255),
  price_insurance float,
  price_patient float,
  unit varchar(10)
);
INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Super Pills', 10.5, 4, 'package');
INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Extra Pills', 18.1, 8.2, 'package');
INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Common Pills', 5, 6.1, 'package');
INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Super Sirup', 12, 8, 'milliliter');
INSERT INTO medicament(name,price_insurance,price_patient,unit) VALUES ('Extra Sirup', 16.3, 10.3, 'milliliter');


CREATE TABLE prescription (
  id serial,
  doctor_id int,
  patient_id int,
  valid_from datetime,
  valid_to datetime,
  is_released boolean
);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-10-06 11:35:12', '2019-10-16 11:35:12', true);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 2, '2019-10-06 12:00:06', '2019-10-16 12:00:06', false);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 3, '2019-10-06 14:04:53', '2019-10-16 14:04:53', true);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-10-08 08:05:40', '2019-10-18 08:05:40', true);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 1, '2019-11-11 09:12:42', '2019-11-21 09:12:42', false);
INSERT INTO prescription(doctor_id,patient_id,valid_from,valid_to,is_released) VALUES (1, 2, '2019-11-11 10:07:35', '2019-11-21 10:07:35', false);


CREATE TABLE list_of_medicaments (
  prescription_id int,
  medicament_id int,
  amount int
);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (1, 1, 2);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (1, 4, 100);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (2, 3, 2);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (2, 4, 250);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 1, 1);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 2, 3);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (3, 3, 2);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (4, 3, 1);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (4, 4, 150);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 1, 3);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 2, 1);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 4, 300);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (5, 5, 300);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (6, 2, 4);
INSERT INTO list_of_medicaments(prescription_id,medicament_id,amount) VALUES (6, 5, 400);


SELECT 
	insurance_company AS "pojišťovna", 
	COUNT(id) AS "počet pacientů"
FROM patient
GROUP BY insurance_company
ORDER BY insurance_company;


SELECT 
	CONCAT(a.street, ' ', a.street_number) AS "ulice", 
	COUNT(p.id) AS "počet pacientů"
FROM patient AS p
JOIN address AS a 
	ON p.address_id = a.id
GROUP BY a.street, a.street_number
ORDER BY a.street, a.street_number;


SELECT 	
	m.unit AS 'jednotka',
	count (m.id) AS 'pocet leku v kategorii'
FROM medicament m 
GROUP BY m.unit 
ORDER BY m.unit; 


SELECT unit AS "jednotka", COUNT(id) AS "počet léků v kategorii"
FROM medicament
GROUP BY unit
ORDER BY unit;


SELECT  
	CONCAT(p.surname, ' ', p.name) AS 'pacient',
	count(pr.id) AS 'pocet receptu pro pacienta'
FROM patient AS p
JOIN prescription AS pr
	ON p.id = pr.patient_id 
GROUP BY p.surname, p.name 
ORDER BY p.surname, p.name;


SELECT 
	CONCAT(p.name, ' ', p.surname) AS "pacient", 
	COUNT(pre.id) AS "počet receptů pro pacienta"
FROM prescription AS pre
JOIN patient AS p 
	ON pre.patient_id = p.id
GROUP BY p.id
ORDER BY p.name, p.surname;


SELECT 	
	p.insurance_company AS 'pojistovna',
	m.name AS 'lek',
	sum(lm.amount) AS 'pocet prodanych balicku'
FROM prescription AS pre
JOIN patient AS p 	
	ON p.id = pre.patient_id 
JOIN list_of_medicaments AS lm 
	ON lm.prescription_id = pre.id 
JOIN medicament AS m 
	ON m.id = lm.medicament_id 
WHERE m.unit = 'package'
GROUP BY p.insurance_company, m.id
ORDER BY p.insurance_company;



SELECT 
	p.insurance_company AS "pojišťovna", 
	m.name AS "lék", 
	SUM(lm.amount) AS "prodaných balíčků"
FROM prescription AS pre
JOIN patient AS p 
	ON pre.patient_id = p.id
JOIN list_of_medicaments AS lm 
	ON pre.id = lm.prescription_id
JOIN medicament AS m 
	ON lm.medicament_id = m.id
WHERE m.unit = 'package'
GROUP BY p.insurance_company, m.id
ORDER BY p.insurance_company;


SELECT unit AS "sledované typy jednotky"
FROM medicament
GROUP BY unit
HAVING SUM(price_insurance + price_patient) > 50;


SELECT 
	d.id AS "identifikátor lékaře", 
	COUNT(pre.id) AS "počet vydaných receptů"
FROM prescription AS pre
INNER JOIN doctor AS d 
	ON pre.doctor_id = d.id
GROUP BY d.id
HAVING COUNT(pre.id) > 5;


SELECT 		
	p.insurance_company AS 'pojistovna',
	count(p.id) AS 'pocet pacientu'
FROM patient AS p
GROUP BY p.insurance_company 
HAVING count(p.id) >= 1
ORDER BY count(p.id) DESC;


SELECT 	
	p.name AS 'jmeno',
	p.surname AS 'prijmeni',
	count (pre.id) AS 'pocet receptu'
FROM patient AS p
JOIN prescription AS pre
	ON p.id = pre.patient_id 
WHERE p.name IN ('Petr', 'Libor')
GROUP BY p.name, p.surname
HAVING count(pre.id) >=1;


SELECT 
	p.name AS "jméno", 
	p.surname AS "příjmení", 
	COUNT(pre.id) AS "počet receptů"
FROM prescription AS pre
INNER JOIN patient AS p 
	ON pre.patient_id = p.id
WHERE name = 'Petr' OR name = 'Libor'
GROUP BY name, surname
HAVING COUNT(pre.id) >= 1;


SELECT 
	AVG(price_patient) AS "průměrný doplatek na léky"
FROM medicament;


SELECT 	
	count(pre.id) AS 'pocet uplatnenych receptu'
FROM prescription AS pre 
WHERE is_released = '1';


SELECT 
	COUNT(id) AS "počet receptů, které pacienti uplatnili"
FROM prescription
WHERE is_released = true;


SELECT 
	max(price_insurance + price_patient) AS 'cena nejdrazsiho leku'
FROM medicament m; 


SELECT 
	MAX(price_insurance + price_patient) AS "cena nejdražšího léku"
FROM medicament;


SELECT 	
	sum(price_insurance),
	sum(price_patient)
FROM medicament m ;


SELECT SUM(price_insurance) > SUM(price_patient) AS "Jsou příspěvky pojišťoven větší než doplatky pacientů?"
FROM medicament;


SELECT 
	name,
	surname
FROM doctor d 
UNION
SELECT
	name,
	surname
FROM patient p ;


SELECT name, surname
FROM doctor
UNION
SELECT name, surname
FROM patient;


SELECT 
	name, 
	surname
FROM doctor
WHERE address_id IN (SELECT id
    FROM address
    WHERE city = 'Engetov');

   
SELECT id
FROM address
WHERE city = 'Engetov';
   
   
SELECT 
	CONCAT(street, ' ', street_number, ', ', city) AS "Adresa",
    (SELECT COUNT(id)
    FROM patient AS p
    WHERE p.address_id = a.id) AS "Počet pacientů na adrese"
FROM address AS a;
   

SELECT 
	p.id AS "ID pacienta", 
	CASE p.insurance_company WHEN 'Engeto insurance' THEN true ELSE false END AS "Je v naší pojišťovně?"
FROM patient AS p;
   

SELECT 
	p.id AS "ID pacienta", 
	CASE WHEN p.insurance_company = 'Engeto insurance' THEN true ELSE false END AS "Je v naší pojišťovně?"
FROM patient AS p;


SELECT 
	p.id AS "ID pacienta", 
	CASE WHEN p.insurance_company != 'Engeto insurance' THEN false ELSE true END AS "Je v naší pojišťovně?"
FROM patient AS p;


SELECT *
FROM patient AS p
WHERE CASE WHEN p.insurance_company = 'Engeto insurance' THEN true END;


SELECT p.id AS "ID pacienta",
    CASE p.insurance_company WHEN 'Engeto insurance'
        THEN
            CASE a.street_number WHEN 1
                THEN CONCAT('Spadá do naší pojišťovny a žije na adrese ', a.street, ' ', a.street_number)
                ELSE 'Spadá do naší pojišťovny, ale nebydlí na adrese, která nás zajímá  '
            END
        ELSE 'Nespadá do naší pojišťovny'
    END AS "Status pacienta"
FROM patient AS p
JOIN address AS a ON a.id = p.address_id
ORDER BY p.id;


SELECT 
	CONCAT (name, ' ', surname) AS "Jméno pacienta"
FROM patient 
WHERE id IN (SELECT DISTINCT patient_id 
    FROM prescription 
    WHERE is_released = false
);


SELECT 
	m.name AS 'jmeno leku',
	m.unit AS 'jednotka',
	sum(lm.amount) AS 'pocet vyskytu'
FROM medicament AS m
JOIN list_of_medicaments AS lm
	ON m.id = lm.medicament_id 
GROUP BY m.name
ORDER BY sum(lm.amount);


SELECT name AS "Název", 
    (SELECT SUM(amount)
    FROM list_of_medicaments AS lm 
    WHERE lm.medicament_id = m.id) AS "Počet výskytů",
    unit AS "Jednotka"
FROM medicament AS m;


SELECT 
	pre.id AS 'id receptu'	
FROM prescription AS pre
JOIN list_of_medicaments AS lm
	ON pre.id = lm.prescription_id 
WHERE medicament_id  IN (SELECT DISTINCT 
	m.id
	FROM medicament AS m
	WHERE price_patient > price_insurance)
	;


SELECT 
	id AS "Identifikátor receptu"
FROM prescription AS p
JOIN list_of_medicaments AS lm ON p.id = lm.prescription_id
WHERE medicament_id in (SELECT DISTINCT id
    FROM medicament
    WHERE price_patient > price_insurance);



SELECT 	
	name AS 'jmeno leku',
	CASE WHEN name LIKE '%Pills%' THEN TRUE ELSE FALSE END
FROM medicament;


SELECT name, CASE WHEN name LIKE '%Pills' THEN true ELSE false END
FROM medicament;


SELECT 
	street AS 'ulice',
	city AS 'mesto'
FROM address
ORDER BY (CASE street WHEN NULL THEN city ELSE street END) asc;


SELECT street, city 
FROM address 
ORDER BY (CASE street WHEN NULL THEN city ELSE street END) ASC;



