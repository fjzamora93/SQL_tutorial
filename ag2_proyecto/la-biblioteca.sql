DROP DATABASE biblioteca;

CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;
SET foreign_key_checks = 0;

CREATE TABLE IF NOT EXISTS libros (
	isbn VARCHAR(100) NOT NULL UNIQUE,
    titulo VARCHAR(25) NOT NULL,
    id_autor INT NOT NULL,
    año_publicacion INT,
    genero VARCHAR(25),
    id_editorial VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS autores (
	id_autor INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(25) NOT NULL,
	pais VARCHAR(25) NOT NULL
);


CREATE TABLE IF NOT EXISTS  editoriales (
	id_editorial VARCHAR(25) NOT NULL UNIQUE,
    nombre VARCHAR(25) NOT NULL, 
    direccion  VARCHAR(25) NOT NULL,
    pais VARCHAR(25) NOT NULL
);


CREATE TABLE IF NOT EXISTS usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellidos VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS prestamos(
	id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(25),
    id_usuario INT(10),
    fecha_prestamos DATE,
    fecha_devolucion DATE
);

ALTER TABLE libros
	ADD CONSTRAINT id_autor_fk FOREIGN KEY (id_autor)
    REFERENCES autores(id_autor)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE libros
	ADD CONSTRAINT id_editorial_fk FOREIGN KEY (id_editorial)
    REFERENCES editoriales(id_editorial)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE prestamos
	ADD CONSTRAINT isbn_fk FOREIGN KEY(isbn)
    REFERENCES libros(isbn) 
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE prestamos
	ADD CONSTRAINT id_usuario_fk FOREIGN KEY(id_usuario)
    REFERENCES usuarios(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE;


INSERT INTO libros (isbn, titulo, id_autor, año_publicacion, genero, id_editorial)
	VALUES
    ('978-1-4028-9462-6', 'El Gran Gatsby', 1, 1925, 'Novela', 1),
	('978-3-16-148410-0', 'Cien años de soledad', 2, 1967, 'Realismo mágico', 2),
	('978-0-14-243720-9', 'Moby-Dick', 3, 1851, 'Novela de aventuras', 3),
	('978-0-553-21268-1', '1984', 4, 1949, 'Distopía', 1),
	('978-1-4165-7350-1', 'Harry Potter', 5, 1951, 'Novela', 4),
	('978-0-00-735195-9', 'To Kill a Mockingbird', 5, 1960, 'Novela', 2);

INSERT INTO autores (id_autor, nombre, pais) VALUES
	(1, "F. Scott Fitzgerald", 'Reino Unido'),
    (2, "Gabriel García Márquez", 'España'),
    (3, "Herman Melville", 'Reino Unido'),
    (4, "George Orwell", 'Estados Unidos'),
    (5, 'J.K. Rowling', 'Reino Unido'),
    (6, 'Harper Lee','Estados Unidos');

INSERT INTO editoriales (id_editorial, nombre, direccion, pais) VALUES
	(1, 'Editorial ExLibris', 'Calle de los Libros 123', 'España'),
	(2, 'Libros y Más', 'Avenida de las Letras 456', 'México'),
	(3, 'Books Unlimited', 'Broadway Street 789', 'Estados Unidos'),
	(4, 'Papel y Tinta', 'Rue des Livres 321', 'Francia'),
	(5, 'Booklandia', 'Bookish Avenue 987', 'Canadá'),
	(6, 'Libreros Unidos', 'Librarian Lane 654', 'Reino Unido');

INSERT INTO usuario (nombre, apellidos) VALUES
	('Juan', 'Martínez López'),
	('María', 'García Pérez'),
	('Carlos', 'Rodríguez Fernández'),
	('Ana', 'Sánchez Gómez'),
	('Pedro', 'Martín García'),
	('Laura', 'López Rodríguez');

INSERT INTO prestamos (isbn, id_usuario, fecha_prestamos, fecha_devolucion) VALUES
	('978-1-4028-9462-6', 101,  '2024-02-01', '2024-02-15'),
	('978-3-16-148410-0', 102, '2024-02-03', '2024-02-17'),
	('978-0-14-243720-9', 103,  '2024-02-05', '2024-02-20'),
	('978-0-553-21268-1', 104, '2024-02-07', '2024-02-22'),
	('978-1-4165-7350-1', 105,  '2024-02-09', '2024-02-25'),
	('978-0-00-735195-9', 106, '2024-02-11', '2024-02-28');
    
SET foreign_key_checks = 1;

/*Listar todos los libros de un autor específico:*/

SELECT titulo FROM libros
	WHERE id_autor in (SELECT id_autor FROM autores 
		WHERE nombre LIKE "Herman%"
    );


DELETE FROM prestamos
	WHERE isbn IN (SELECT isbn FROM libros
					WHERE año_publicacion > 1950);

SELECT * FROM prestamos;


/*
Mostrar los libros disponibles (no prestados):
*/

SELECT * FROM libros
LEFT OUTER JOIN prestamos
ON libros.isbn = prestamos.isbn
ORDER BY año_publicacion DESC;

SELECT * FROM libros
WHERE isbn NOT IN (SELECT isbn FROM prestamos);

SELECT * FROM libros
LEFT OUTER JOIN prestamos
ON libros.isbn = prestamos.isbn
UNION
SELECT * FROM libros
RIGHT OUTER JOIN prestamos
ON libros.isbn = prestamos.isbn;


/*
Calcular la cantidad total de libros por género, que solamente de los que tengan más de 2 copias:
*/

SELECT genero, COUNT(*) as recuento
FROM libros
GROUP BY genero
HAVING recuento > 2;


/*
Actualizar la fecha de devolución de un préstamo:
*/

UPDATE prestamos 
SET fecha_devolucion = '2024-02-29'
WHERE isbn IN (SELECT isbn FROM libros WHERE titulo LIKE 'Moby-Dick');

SELECT * FROM prestamos WHERE fecha_devolucion > '2024-02-28';


/*
Insertar un nuevo libro en la base de datos:
*/

INSERT INTO libros (isbn, titulo, id_autor, año_publicacion, genero, id_editorial)
SELECT UUID(), titulo, id_autor, año_publicacion, genero, id_editorial 
FROM libros
WHERE isbn IN (SELECT isbn FROM prestamos);

SELECT * FROM libros;

idempleado
/*
Insertar un nuevo libro en la base de datos:
Eliminar un libro que no ha sido prestado aún:
Listar los libros junto con sus editoriales:
Mostrar la cantidad total de libros prestados por país de la editorial:
Seleccionar los libros que contienen una palabra clave en su título:
Mostrar los préstamos realizados en un rango de fechas específico:
Mostrar los autores junto con el número total de libros que han escrito:
Seleccionar los libros más antiguos disponibles en la biblioteca:
*/