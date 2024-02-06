create database if not exists pepe;
use pepe;


/*
OIDO COCINA
Cuando quieres que un campo no sea nulo, hay que decirlo explicitamente ponienod NOT NULL.
Si no definimos como NOT NULL, va a admitir NULO.

DEFAULT "" quiere decir dos cosas -> que por defecto tiene una cadena en blanco.
								-> que NUNCA será nulo, ya que va a tener un hueco en blanco por defecto.
                                
DEFAULT NULL es para indicar que por defecto es nulo.

Lo que hay entre paréntesis que es la longitud máxima de ese campo.

DROP TABLE pepe.clientes; -> borraría la tabla

 NOT NULL UNIQUE sería una forma de encubrir una clave primaria, aunque lo suyo es hacerlo con primary
*/
CREATE TABLE if not exists clientes (
    DNI CHAR(9) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) DEFAULT "",
    Fecha DATE DEFAULT NULL,
    Credito DECIMAL(10,2) DEFAULT NULL,
    nsucusal INT DEFAULT NULL,
    PRIMARY KEY (DNI),
    nSucursal INTEGER REFERENCES Sucursales(nSucursal) 
); 

CREATE TABLE if not exists directores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

CREATE TABLE if not exists Sucursales (
    nSucursal INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(255),
    Director INT,
    FOREIGN KEY (Director) REFERENCES directores(id)
);



/*
Existen dos sintaxis para meter la FK.
Primera forma:
    ->nSucursal INTEGER REFERENCES Sucursales(nSucursal)
    ->FOREIGN KEY (Director) REFERENCES directores(id)
*/


/*
DATA TYPES: https://dev.mysql.com/doc/refman/8.0/en/data-types.html

¿Cómo leches se refresca?
*/