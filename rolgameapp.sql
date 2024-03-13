CREATE DATABASE IF NOT EXISTS rolgame;

USE rolgame;

SET foreign_key_checks = 0;
START TRANSACTION;

CREATE TABLE IF NOT EXISTS usuarios(
nombre VARCHAR(25) PRIMARY KEY NOT NULL,
contraseña VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS personajes(
nombre VARCHAR(25) UNIQUE NOT NULL,
vida INT,
habilidad INT,
atributo INT
);

CREATE TABLE IF NOT EXISTS objeto(
nombre VARCHAR(25) UNIQUE NOT NULL,
cantidad INT
);

CREATE TABLE IF NOT EXISTS inventario(
idpersonaje VARCHAR(25),
idobjeto VARCHAR(25)
);

ALTER TABLE personajes
ADD idusuario VARCHAR(25),
ADD CONSTRAINT idusuario_fk FOREIGN KEY (idusuario) 
	REFERENCES usuarios(nombre) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE inventario
ADD CONSTRAINT idpersonaje_fk FOREIGN KEY (idpersonaje) 
	REFERENCES personaje(nombre) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT idobjeto_fk FOREIGN KEY (idobjeto)
	REFERENCES objetos(nombre) ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE personajes
	ADD CONSTRAINT limite_vida CHECK (vida BETWEEN 0 AND 100),
	ADD CONSTRAINT limite_atributo CHECK (atributo BETWEEN 0 AND 20);

ALTER TABLE personajes
	MODIFY clase VARCHAR(25);

INSERT INTO personajes (nombre, vida, atributo, clase, idusuario)
	VALUES 
    ('Eric', 10, 10, 'Bardo', 0 ),
    ('Asherá', 10, 10, 'Clérigo', 0 ),
    ('Lomiom', 10, 10, 'Explorador', 0 ),
    ('Azazel', 10, 10, 'Mago', 0 )
    ;

UPDATE personajes
SET idusuario = 
	CASE 
		WHEN nombre LIKE "Asherá" THEN 'Miriam'
        WHEN nombre LIKE "Lomiom" THEN 'Cristina'
        WHEN nombre LIKE 'Azazel' THEN 'Iván'
        WHEN nombre LIKE 'Eric' THEN 'Javier'
        ELSE idusuario
	END;

SELECT * FROM personajes;

INSERT INTO usuarios (nombre, contraseña)
VALUES
('Javier', '1234'),
('Miriam', '1234'),
('Iván', '1234'),
('Cristina', '1234');


