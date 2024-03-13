use ag2_proyectos;

INSERT IGNORE INTO empleados(idempleado, nombre, apellidos, sexo, fecha_nac, sueldo, municipio, idpto)
	VALUES(10483, 'María', 'González Martínez', 'F', '1985-03-21', 1800, 'Madrid', 4),
		(10484, 'Juan', 'Sánchez Pérez', 'M', '1978-12-05', 2000, 'Sevilla', 5),
		(10485, 'Luisa', 'Fernández Rodríguez', 'F', '1990-07-15', 1550, 'Málaga', 3),
		(10486, 'Pedro', 'Martín López', 'M', '1982-09-30', 1700, 'Málaga', 2),
		(10487, 'Sofía', 'Díaz García', 'F', '1975-04-18', 1900, 'Madrid', 4);
        
INSERT IGNORE INTO empleados(idempleado, nombre, apellidos, sexo, fecha_nac, sueldo, municipio, idpto)
	VALUES(10488, 'Rosa', 'Gómez Sánchez', 'F', '1987-08-14', 1750, 'Madrid', 1),
		(10489, 'Manuel', 'Martínez Rodríguez', 'M', '1979-11-27', 1900, 'Sevilla', 2),
		(10490, 'Laura', 'Pérez Gutiérrez', 'F', '1992-02-03', 1600, 'Málaga', 3),
		(10491, 'Javier', 'López Ruiz', 'M', '1983-06-25', 1850, 'Córdoba', 4),
		(10492, 'Carmen', 'Fernández Martín', 'F', '1980-04-09', 1700, 'Sevilla', 1);
        
SET foreign_key_checks = 0;



UPDATE asignacion
SET idproyecto =  FLOOR(1 + (RAND() * 4))
WHERE idproyecto > 4;
	

SELECT * FROM asignacion;

-- SET foreign_key_checks = 1;


DELETE FROM asignacion
WHERE idempleado in (SELECT idempleado FROM empleados 
	WHERE nombre LIKE 'A%');
    
