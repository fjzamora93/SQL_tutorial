CREATE DATABASE IF NOT EXISTS  examen_bbdd;

USE examen_bbdd;
SET foreign_key_checks = 0;

START TRANSACTION;

CREATE TABLE IF NOT EXISTS centros(
numce INT NOT NULL,
nomce VARCHAR(255),
dirce VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS departamentos(
numde INT NOT NULL,
numce int NULL,
direc INT NULL,
tidir CHAR(1) NULL,
presu FLOAT NULL,
depde INT NULL,
nomde VARCHAR(255) NULL
);



INSERT INTO centros (numce, nomce, dirce)
	VALUES (10, 'SEDE CENTRAL', 'C/ ATOCHA, 820 MADRID'),
		(20, 'RELACIÓN CON CLIENTES', 'C/ ATOCHA, 405 MADRID');


INSERT INTO departamentos (numde, numce, direc, tidir, presu, depde, nomde)
	VALUES (100, 10, 260, 'P', 72, NULL, 'DIRECCIÓN GENERAL'),
	(110, 20, 180, 'P', 90, 100, 'DIRECC.COMERCIAL'),
	(111, 20, 180, 'F', 66, 110, 'SECTOR INDUSTRIAL'),
	(112, 20, 270, 'P', 54, 110, 'SECTOR SERVICIOS'),
	(120, 10, 150, 'F', 18, 100, 'ORGANIZACIÓN'),
	(121, 10, 150, 'P', 12, 120, 'PERSONAL'),
	(122, 10, 350, 'P', 36, 120, 'PROCESO DE DATOS'),
	(130, 10, 310, 'P', 12, 100, 'FINANZAS');

CREATE TABLE IF NOT EXISTS empleados(
	numem INT NOT NULL,
	extel INT NULL,
	fecna DATE NULL,
    fecin DATE NULL,
    salar FLOAT NULL,
    comis FLOAT NULL, 
    numhi INT NULL, 
    nomem VARCHAR(255) NULL, 
    numde INT NULL
);

INSERT INTO empleados (numem, extel, fecna, fecin, salar, comis, numhi, nomem, numde)
	VALUES(110, 350, '1970-11-10', '1985-02-15', 1800, NULL, 3, 'CESAR', 121),
		(120, 840, '1968-06-09', '1988-10-01', 1900, 110, 1, 'MARIO', 112),
		(130, 810, '1965-09-09', '1981-02-01', 1500, 110, 2, 'LUCIANO', 112),
		(150, 340, '1972-08-10', '1997-01-15', 2600, NULL, 0, 'JULIO', 121),
		(160, 740, '1980-07-09', '2005-11-11', 1800, 110, 2, 'AUREO', 111),
		(180, 508, '1974-10-18', '1996-03-18', 2800, 50, 2, 'MARCOS', 110),
		(190, 350, '1972-05-12', '1992-02-11', 1750, NULL, 4, 'JULIANA', 121),
		(210, 200, '1970-09-28', '1999-01-22', 1910, NULL, 2, 'PILAR', 100),
		(240, 760, '1967-02-26', '1989-02-24', 1700, 100, 3, 'LAVINIA', 111),
		(250, 250, '1976-10-27', '1997-03-01', 2700, NULL, 0, 'ADRIANA', 100),
		(260, 220, '1973-12-03', '2001-07-12', 720, NULL, 6, 'ANTONIO', 100),
		(270, 800, '1975-05-21', '2003-09-10', 1910, 80, 3, 'OCTAVIO', 112),
		(280, 410, '1978-01-10', '2010-08-10', 1500, NULL, 5, 'DOROTEA', 130),
		(285, 620, '1979-10-25', '2011-02-15', 1910, NULL, 0, 'OTILIA', 122),
		(290, 910, '1967-11-30', '1988-02-14', 1790, NULL, 3, 'GLORIA', 120),
		(310, 480, '1976-11-21', '2001-01-15', 1950, NULL, 0, 'AUGUSTO', 130),
		(320, 620, '1977-12-25', '2003-02-05', 2400, NULL, 2, 'CORNELIO', 122),
		(330, 850, '1958-08-19', '1980-03-01', 1700, 90, 0, 'AMELIA', 112),
		(350, 610, '1979-04-13', '1999-09-10', 2700, NULL, 1, 'AURELIO', 122),
		(360, 750, '1978-10-29', '1998-10-10', 1800, 100, 2, 'DORINDA', 111),
		(370, 360, '1977-06-22', '2000-01-20', 1860, NULL, 1, 'FABIOLA', 121),
		(380, 880, '1978-03-30', '1999-01-01', 1100, NULL, 0, 'MICAELA', 112),
		(390, 500, '1976-02-19', '2010-10-08', 1290, NULL, 1, 'CARMEN', 110),
		(400, 780, '1979-08-18', '2011-11-01', 1150, NULL, 0, 'LUCRECIA', 111),
		(410, 660, '1968-07-14', '1989-10-13', 1010, NULL, 0, 'AZUCENA', 122),
		(420, 450, '1966-10-22', '1988-11-19', 2400, NULL, 0, 'CLAUDIA', 130),
		(430, 650, '1967-10-26', '1988-11-19', 1260, NULL, 1, 'VALERIANA', 122),
		(440, 760, '1966-09-26', '1986-02-28', 1260, 100, 0, 'LIVIA', 111),
		(450, 880, '1966-10-21', '1986-02-28', 1260, 100, 0, 'SABINA', 112),
		(480, 760, '1965-04-04', '1986-02-28', 1260, 100, 1, 'DIANA', 111),
		(490, 880, '1964-06-06', '1988-01-01', 1090, 100, 0, 'HORACIO', 112),
		(500, 750, '1965-10-08', '1987-01-01', 1200, 100, 0, 'HONORIA', 111),
		(510, 550, '1966-05-04', '1986-11-01', 1200, NULL, 1, 'ROMULO', 110),
		(550, 780, '1970-01-10', '1998-01-21', 600, 120, 0, 'SANCHO', 111);

SET foreign_key_checks = 1;

/*
Crear una vista y ejecutadla para en cada departamento con presupuesto inferior a 35.000 €, 
hallar le nombre del Centro donde está ubicado y el máximo salario de sus empleados 
(si dicho máximo excede de 1.500 €). Clasificar alfabéticamente por nombre de departamento.
*/


CREATE VIEW ejercicio_1 AS
SELECT dep.nomde, centro.nomce, MAX(emp.salar) AS salario_maximo
FROM departamentos AS dep
JOIN centros AS centro ON dep.numce = centro.numce
JOIN empleados AS emp ON dep.numde = emp.numde
WHERE dep.presu < 35000
GROUP BY dep.nomde, centro.nomce
HAVING MAX(emp.salar) >= 1500
ORDER BY dep.nomde;


/*
2. Crear una consulta para hallar por orden alfabético los nombres de los departamentos 
que dependen de los que tienen un presupuesto inferior a 30.000 €. 
También queremos conocer el nombre del departamento del que dependen y su presupuesto.

ENTIENDO QUE EL ENUNCIADO SE REFIERE AL NOMBRE DE LOS EMPLEADOS... ya que 
después vuelve a pedir el nombre del departamento
*/

SELECT nomde, nomem, presu 
FROM departamentos, empleados
WHERE departamentos.numde = empleados.numde
AND departamentos.presu < 30000
ORDER BY empleados.nomem;


/*
3. Crear una consulta para obtener los nombres y los salarios medios de los departamentos
 cuyo salario medio supera al salario medio de la empresa.
 
*/

SELECT AVG(salar), nomde FROM empleados, departamentos
WHERE empleados.numde = departamentos.numde
GROUP BY nomde
HAVING AVG(salar) > (SELECT AVG(salar) FROM empleados);


/*
4. Crear una vista y ejecutadla para para los departamentos cuyo director lo sea en funciones,
 hallar el número de empleados y la suma de sus salarios, comisiones y número de hijos.

*/

-- director en funciones?

/*
5. Crear una consulta para los departamentos cuyo presupuesto anual supera los 35.000 €, 
hallar cuantos empleados hay por cada extensión telefónica.
*/

SELECT COUNT(extel), empleados.numde
FROM empleados , departamentos
WHERE empleados.numde = departamentos.numde
AND departamentos.presu > 35000
GROUP BY empleados.numde;

/*
6. Crear una consulta para hallar por orden alfabético los nombres de los empleados 
y su número de hijos para aquellos que son directores en funciones.
*/


/*
7. Crear una vista y ejecutadla para hallar si hay algún departamento (suponemos que sería de reciente creación)
 que aún no tenga empleados asignados ni director en propiedad.
*/



CREATE VIEW ejercicio_7 AS
SELECT * FROM departamentos 
WHERE numde NOT IN (SELECT numde FROM empleados);






/*
Crear una consulta que añada un nuevo empleado de nombre NORBERTO
 y sin departamento asignado. Inventar el resto de los datos.
*/
 
INSERT INTO empleados (numem, extel, fecna, fecin, salar, comis, numhi, nomem, numde)
	VALUES(660, 666, '1970-11-10', '1985-02-15', 1800, NULL, 3, 'Norberto', null);
    
    
/*
10. Crear una consulta para mostrar los nombres de departamentos que no tienen empleados 
haciendo uso la combinación externa LEFT JOIN.
 Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.
*/
SELECT departamentos.numde, empleados.nomem 
FROM departamentos LEFT OUTER JOIN empleados 
ON empleados.numde = departamentos.numde;

/*
11. Crear una consulta para mostrar los nombres de departamentos que no tienen empleados
 haciendo uso la combinación externa RIGH JOIN. 
Muestra una segunda columna con los nombres de empleados para asegurarnos que realmente está a NULL.
*/


/*
12. Crear una consulta que actualice el sueldo de los empleados del departamento SECTOR SERVICIOS 
en un 15% y cuya sede sea la SEDE CENTRAL 
y que se controle mediante una transacción, dando el commit después del borrado;
 verifica antes el estado del autocommit de la BBDD.
*/

START TRANSACTION;
SELECT @@autocommit;
SET autocommit = 0;

UPDATE empleados
SET salar = salar*1.15
WHERE numde IN (SELECT numde FROM departamentos
				WHERE numce = (SELECT numce FROM centros 
								WHERE nomce LIKE 'SEDE CENTRAL'));
COMMIT;


/*
Crear una consulta que borre el nuevo empleado de nombre NORBERTO 
y sin departamento asignado y que se controle mediante una transacción, 
dando el roolback después del borrado; verifica antes el estado del autocommit de la BBDD.
*/

START TRANSACTION;
SELECT @@autocommit;
SET autocommit = 0;

SELECT * FROM empleados WHERE nomem LIKE 'Norberto';

DELETE FROM empleados
WHERE nomem LIKE 'Norberto'
AND numde IS NULL;

SELECT * FROM empleados WHERE nomem LIKE 'Norberto';

ROLLBACK;


/*
14. Muestra la combinación de las 3 tablas CENTROS, DEPARTAMENTOS y EMPLEADOS 
haciendo uso de INNER JOIN y muestra: empleados, centro y salario de aquellos empleados
 cuya fecha de incorporación en la empresa es mayor de 1998.
*/

SELECT numem, departamentos.numce, salar, departamentos.numde, nomce, nomem, nomde 
FROM empleados INNER JOIN departamentos
	ON empleados.numde = departamentos.numde
INNER JOIN CENTROS 
	ON departamentos.numce = CENTROS.numce
AND empleados.fecin > '1998-01-01';