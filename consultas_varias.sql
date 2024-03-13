use ag2_proyectos;

SELECT * FROM departamentos;
SELECT * FROM empleados;
SELECT * FROM asignacion;
SELECT * FROM proyectos;

CREATE VIEW outer_join AS
SELECT empleados.nombre AS emp_name, asignacion.idproyecto 
FROM empleados LEFT OUTER JOIN asignacion
ON empleados.idempleado = asignacion.idempleado;

SELECT departamentos.nombre AS dep_nombre, empleados.nombre AS emp_nombre
FROM departamentos LEFT OUTER JOIN empleados
ON departamentos.idpto = empleados.idpto
ORDER BY departamentos.presupuestos ASC;



START TRANSACTION;
SET foreign_key_checks = 0;

UPDATE empleados
SET idpto = null 
WHERE nombre LIKE "A%";

ROLLBACK;

SELECT empleados.nombre AS nomb_empl, departamentos.nombre AS nomb_dep, empleados.sueldo AS salario
FROM empleados LEFT JOIN departamentos
ON empleados.idpto = departamentos.idpto
UNION ALL
SELECT empleados.nombre AS nomb_empl, departamentos.nombre AS nomb_dep, empleados.sueldo AS salario
FROM empleados RIGHT JOIN departamentos
ON empleados.idpto = departamentos.idpto
ORDER BY salario DESC
;


START TRANSACTION;
CREATE TABLE directivos  AS
(SELECT idempleado, nombre, apellidos, sueldo, idpto FROM empleados);

DELETE FROM directivos 
WHERE sueldo < (SELECT AVG(sueldo)+200 FROM empleados); 
rollback;

UPDATE directivos
SET sueldo = sueldo*1.5
WHERE sueldo = 1900;

START TRANSACTION;
UPDATE empleados
SET sueldo = (SELECT sueldo FROM directivos
			WHERE empleados.idempleado = directivos.idempleado);


UPDATE empleados
SET sueldo = (SELECT sueldo FROM directivos WHERE empleados.idempleado = directivos.idempleado)
WHERE idempleado = (SELECT idempleado FROM directivos WHERE directivos.idempleado = empleados.idempleado);

SELECT directivos.sueldo, empleados.sueldo FROM directivos, empleados 
WHERE empleados.idempleado = directivos.idempleado;


SELECT * FROM empleados RIGHT OUTER JOIN directivos
ON empleados.idempleado = directivos.idempleado
UNION 
SELECT * FROM empleados LEFT OUTER JOIN directivos
ON empleados.idempleado = directivos.idempleado
;
START TRANSACTION;
ALTER TABLE directivos
ADD CONSTRAINT restriccion_salario CHECK (sueldo > 1800);


SELECT * FROM directivos;
SELECT * FROM empleados;
ROLLBACK;



SELECT SUM(sueldo) FROM empleados
GROUP BY idpto;

SELECT * FROM empleados;
SELECT * FROM departamentos;


SELECT proyectos.nombre AS project_name, asignacion.idempleado 
FROM proyectos LEFT  JOIN asignacion
ON  proyectos.idproyecto = asignacion.idproyecto
UNION ALL
SELECT empleados.nombre AS emple_name, asignacion.idempleado 
FROM asignacion RIGHT JOIN empleados
ON  empleados.idempleado = asignacion.idempleado;



SELECT COUNT(*) FROM outer_join_3;
SELECT COUNT(empl_name) AS recuento, project_name FROM outer_join_3
GROUP BY project_name
HAVING recuento > 2;
