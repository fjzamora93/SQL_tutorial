SELECT dni as javier
FROM clientes as cli;

/* Eso es poner un alias, para que en la salida se vea distinto

*/

SELECT distinct(direccion) as casa
FROM clientes as cli;

/*
El DISTINCT lo vamos a usar mucho para sacar elementos
distintos de una base de datos.

Al final el punto es hacer consultar coherentes
*/

use pepe;
SELECT distinct(credito) 
FROM clientes as cli
WHERE (credito >=500) 
and nombre LIKE "%A%"
and nombre (is not "Antonio")
and (fecha_de_alta is not null);


order by credito asc, APELLIDOS desc;

/*el order by, seguido del campo y un asc o desc,
nos ordenará los resultados.*/

/*CAMPOS AGREGADOS Al utilizar el símbolo (*) con el astericos
seguido del campo, nos va a contar el número de nulos*/

