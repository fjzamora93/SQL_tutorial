-- DATA TYPES: https://dev.mysql.com/doc/refman/8.0/en/data-types.html

create database if not exists pepe;
use pepe;

-- DROP TABLE pepe.sucursales; Borraría la tabla
-- También se puede hacer botón derecho y DROP TABLE sobre la tabla que quieras borrar..

/*
OIDO COCINA
Cuando quieres que un campo no sea nulo, hay que decirlo explicitamente ponienod NOT NULL.
Si no definimos como NOT NULL, va a admitir NULO.

DEFAULT "" quiere decir dos cosas -> que por defecto tiene una cadena en blanco.
								-> que NUNCA será nulo, ya que va a tener un hueco en blanco por defecto.
                                
DEFAULT NULL es para indicar que por defecto es nulo.

Lo que hay entre paréntesis que es la longitud máxima de ese campo.

 NOT NULL UNIQUE sería una forma de encubrir una clave primaria, aunque lo suyo es hacerlo declariando PRIMARY KEY.
*/


/*
Incluir en las tablas directamente las claves ajenas y después poner restricciones de negocio. No poner las restricciones en la misma creación.
 a las mismas puede crear problemas en cualquier base de datos (especialmente en MySQL). 
 Para prevenirlo, se recomienda hacer las modificaciones y restricciones enna sentencia aparte de la que se usa explícitamente para crear la tabla.
Esta es la sentencia: 

ALTER TABLE 'clientes'
	ADD CONSTRAINT 'clientes_ibfk_1' FERIGN KEY ('NSUCURSUAL') REFERENCES 'sucursales' ('NSUCURSAL) ON DELETE NO ACTION

¿Por qué sucede esto? Tiene que ver con el orden en el que se crean las tablas.
Tú puedes crear una tabla, pero aquella a la que está referenciando es posible que aún no se haya creado.
*/

CREATE TABLE if not exists directores (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    sueldo float DEFAULT NULL
);

-- Fíjate en que primero se crea Directores y luego Sucursales. Ya que Directores aparecerá referenciado en Sucursales.
CREATE TABLE if not exists Sucursales (
    nSucursal INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(255),
    Director INT,
    FOREIGN KEY (Director) REFERENCES directores(id) -- Segunda forma de crear una FK. Como vemos, se crea el campo director en una linea, y se referencia en otra.
    -- Esta Sintaxis no le gusta a MySQL porque te exige que la tabla de directores haya sido creada antes de que sea referenciada. 
    
);

CREATE TABLE if not exists clientes (
    DNI CHAR(9) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) DEFAULT "",
    Fecha DATE DEFAULT NULL,
    Credito DECIMAL(10,2) DEFAULT NULL,
    nSucursal INTEGER REFERENCES Sucursales(nSucursal) -- Primera forma de referenciar una FK. Como vemos, se crea y se referencia en la misma línea.
    -- Taly como están referenciadas las FK (dentro de la tabla y la otra también), MySQL lo va a ejecutar BIEN, 
    -- pero la realidad es que cuando vayamos al diccionario, NO VAMOS A VER esta FK. Para ello, tendrá que modificarse desde fuera de la tabla.
); 

/*
Existen dos sintaxis para meter la FK.
Primera forma:
    ->nSucursal INTEGER REFERENCES Sucursales(nSucursal)
    ->FOREIGN KEY (Director) REFERENCES directores(id)
    
En cualquier caso, si vamos al diccionario, no veremos estas FK,
ya que para eso hace falta meter el ALTER TABLE (una alteración posterior).
*/



