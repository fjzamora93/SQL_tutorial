CREATE DATABASE IF NOT EXISTS ag2_proyectos;

-- DDL de la creación y carga de datos.
use ag2_proyectos;
/*
DROP TABLE asignacion;
DROP TABLE empleados;
DROP TABLE departamentos;
DROP TABLE proyectos;*/

/*DESACTIVAMOS LAS RESTRICCIONES DE INTEGRIDAD REFERENCIAL */

SET foreign_key_checks = 0;


CREATE TABLE IF NOT EXISTS empleados(
	idempleado INT(11) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellidos VARCHAR(25) NOT NULL,
    sexo CHAR(1) DEFAULT " ",
    municipio VARCHAR(50)  DEFAULT " ",
    fecha_nac DATE,
    sueldo INT(11) NOT NULL,
    idpto INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS proyectos(
idproyecto INT(11) NOT NULL,
nombre VARCHAR(25),
fecha_ini DATE,
fecha_fin DATE
);

CREATE TABLE IF NOT EXISTS departamentos(
idpto INT(11) NOT NULL,
nombre VARCHAR(25),
presupuestos INT(11)
);

CREATE TABLE IF NOT EXISTS asignacion(
idempleado INT(11) NOT NULL,
idproyecto INT(11) NOT NULL
);

ALTER TABLE departamentos
	ADD PRIMARY KEY (idpto);

ALTER TABLE proyectos
	ADD PRIMARY KEY (idproyecto);
    
ALTER TABLE empleados
	ADD PRIMARY KEY (idempleado, nombre);

ALTER TABLE empleados
	ADD CONSTRAINT idpto_fk  FOREIGN KEY (idpto) 
    REFERENCES departamentos(idpto) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE asignacion
	ADD CONSTRAINT idempleado_fk FOREIGN KEY (idempleado) REFERENCES empleados(idempleado)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    ADD CONSTRAINT idproyecto_fk FOREIGN KEY (idproyecto) REFERENCES proyectos(idproyecto)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION;


INSERT INTO empleados(idempleado, nombre, apellidos, sexo, fecha_nac, sueldo, municipio, idpto)
	VALUES(10478, 'Alberto', 'Pérez López', 'M', '1965-09-12', 1500, 'Madrid', 1),
		(10479, 'Gloria', 'Ruiz Ruiz', 'F', '1968-06-12', 1650, 'Sevilla', 2),
		(10480, 'Antonio', 'García Montero', 'M', '1969-10-12', 1350, 'Madrid', 1),
		(10481, 'Ana', 'López Ramírez', 'F', '1970-05-12', 1250, 'Sevilla', 3),
		(10482, 'Eduardo', 'Chicón Terrales', 'M', '1920-05-12', 1470, 'Córdoba', 2);
        
INSERT INTO proyectos (idproyecto, nombre, fecha_ini, fecha_fin)
	VALUES(1, 'SINUBE', '2018-09-12', '2019-09-12'),
		(2, 'TRASPI', '2017-09-12', '2019-09-12'),
		(3, 'RUNTA', '2016-09-12', '2019-09-12'),
		(4, 'CARTAL', '2019-05-12', '2019-09-12');
        
INSERT INTO departamentos (idpto, nombre, presupuestos)
	VALUES(1, 'I+D', 50000),
		(2, 'Diseño', 25000),
		(3, 'Ventas', 15000),
		(4, 'Marketing', 10000);
        
INSERT INTO asignacion (idempleado,idproyecto)
VALUES (10478, 1),
	(10480, 3),
	(10481, 1),
	(10482, 2);


/*REESTABLECEMOS LAS RESTRICCIONES DE INTEGRIDAD REFERENCIAL */
SET foreign_key_checks = 1;
COMMIT;

-- DML pedido en las sentencias.

-- 1.Se pide que muestres todos los datos introducidos en las tablas. Para ello deberías extraer las cuatro tablas incluidas con comandos de selección.

SELECT * FROM empleados;
SELECT * FROM proyectos;
SELECT * From departamentos;
SELECT * FROM asignacion;


 /*2.Se necesita una lista de los proyectos (sólo indicando el nombre y la fecha de inicio) que empiezan a partir de Marzo. En la cabecera de la columna de la fecha debe de poner
 “Fecha de inicio del proyecto”.*/
CREATE VIEW ejercicio_2 AS 
SELECT nombre, fecha_ini AS "Fecha de inicio del proyecto" FROM proyectos
	WHERE MONTH(fecha_ini) > 3;
    
    -- No hemos tenido en cuenta el año porque no se especificaba.

-- 3.Se necesita un listado de todos los empleados que tengan el apellido López, como primero o segundo apellido
CREATE VIEW ejercicio_3 AS
SELECT * FROM empleados
WHERE apellidos LIKE "%López%";

/* 4.Se pide que muestres el nombre del proyecto que tiene asignado el empleado “10480”, siguiendo estos pasos.
   5.Son dos sentencias SELECT: Primero averigua el número de de proyecto del empleado “10480” y luego cuando tengas el número de proyecto realizar la consulta sobre la tabla Proyectos.*/
CREATE VIEW ejercicio_4 AS
SELECT idproyecto FROM asignacion
WHERE idempleado = 10480;

CREATE VIEW ejercicio_5 AS
SELECT nombre FROM proyectos
WHERE idproyecto IN (SELECT idproyecto FROM ejercicio_4);


-- Se puede hacer en una sentencia de la siguiente forma:

SELECT nombre FROM proyectos
WHERE idproyecto IN (SELECT idproyecto FROM asignacion
			WHERE idempleado = 10480);
            
-- 6.Sacar un listado de los empleados que sean de Madrid o Córdoba. Realiza el select de dos maneras posibles.

-- Comprobando si están en la lista de valores
CREATE VIEW ejercicio_6a AS
SELECT * FROM empleados
	WHERE municipio IN ('Madrid', 'Cordoba');

-- Comparando varchar
CREATE VIEW ejercicio_6b AS
SELECT * FROM empleados 
	WHERE municipio LIKE "Madrid" OR municipio LIKE "Cordoba";

-- 7.Sacar un listado de los empleados que tengan un sueldo entre 1300 y 1550 Euros  

CREATE VIEW ejercicio_7 AS
SELECT * FROM empleados
	WHERE sueldo > 1300 and sueldo <  1550;
    

-- 8.Ordena los empleados por fecha de nacimiento descendente y sólo los que hayan nacido después de 1976

/*No hay empleados que nazcan después de 1976, así que hemos puesto 1966*/

CREATE VIEW ejercicio_8 AS
SELECT * from empleados 
	WHERE YEAR(fecha_nac) > 1966
    ORDER BY fecha_nac DESC;

-- 9.Se ha detectado un error y es necesario sumar 5000 Euros al presupuesto del departamento de Marketing. Modifícalo sin tener que volver a insertar de nuevo el registro.


UPDATE departamentos
	SET presupuestos = presupuestos + 5000
	WHERE nombre LIKE "Marketing";
CREATE VIEW ejercicio_9 AS
SELECT nombre, presupuestos FROM departamentos
	WHERE nombre LIKE "Marketing";

-- 10.Se va a cambiar de proyecto a “Alberto Pérez López”. Modifícalo para que tenga asignado el proyecto “RUNTA”

 
 UPDATE asignacion
	SET idproyecto = (SELECT idproyecto FROM proyectos WHERE nombre LIKE "Runta")
    WHERE idempleado in (SELECT idempleado FROM empleados WHERE nombre LIKE "Alberto" AND apellidos LIKE "Pérez López");

CREATE VIEW ejercicio_10 AS
SELECT * FROM asignacion;


 /* 11.Por motivos de logística “Antonio García Montero” ya no seguirá en el proyecto que tenía asignado y por lo tanto hay que quitarle esa asignación.
 Hazlo en dos pasos al igual que en la consulta 4.*/
 
 
 SELECT idempleado FROM empleados
 WHERE nombre LIKE "Antonio" AND apellidos LIKE "García Montero";
 
 DELETE FROM asignacion
 WHERE idempleado = 10480;
 
 CREATE VIEW ejercicio_11 AS
 SELECT * FROM asignacion;
 
 -- Se puede hacer en una consulta
 
 DELETE FROM asignacion
 WHERE idempleado LIKE (SELECT idempleado FROM empleados WHERE nombre LIKE "Antonio" AND apellidos LIKE "García Montero");

 SELECT * FROM asignacion;
 

 -- 12.Sacar todos los empleados del departamento de Diseño y que ganen más de 1500 Euros.*/
 
 CREATE VIEW ejercicio_12 AS
SELECT * FROM empleados 
WHERE sueldo > 1500 AND 
idpto IN (SELECT idpto FROM departamentos WHERE nombre LIKE "Diseño");
 
 -- 13.Incrementar en un 5% el sueldo de los empleados que pertenezcan al departamento de I+D y que ganen menos de 1400 Euros. 

 
 UPDATE empleados
 SET sueldo =  sueldo * 1.05
 WHERE sueldo < 1400 AND
 idpto IN (SELECT idpto FROM departamentos WHERE nombre LIKE "I+D");
 
 CREATE VIEW ejericio_13 AS
 SELECT * FROM empleados;


