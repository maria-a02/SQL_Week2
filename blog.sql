-- Crear base de datos llamada blog.
DROP DATABASE blog;
CREATE DATABASE blog;

\c blog

-- Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuarios(
    id INT PRIMARY KEY,
    email VARCHAR (50));

CREATE TABLE posts(
    id INT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR,
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id));

CREATE TABLE comentarios(
    id INT PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    texto VARCHAR,
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id));

-- Insertar los siguientes registros.
\copy usuarios FROM 'usuarios.csv' csv header;
\copy posts FROM 'posts.csv' csv header;
\copy comentarios FROM 'comentarios.csv' csv header;

-- Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT email, p.id, titulo
FROM usuarios u
INNER JOIN posts p
ON u.id = usuario_id
WHERE u.id = 5;

-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT u.email, c.id, c.texto
FROM comentarios c
INNER JOIN usuarios u
ON u.id = c.usuario_id
WHERE u.email != 'usuario06@hotmail.com';

-- Listar los usuarios que no han publicado ningún post.
SELECT *
FROM usuarios u
LEFT JOIN posts p
ON u.id = p.usuario_id
WHERE p.id IS NULL;

-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT c.*, p.*
FROM posts p
FULL OUTER JOIN comentarios c
ON p.id = c.post_id;

-- Listar todos los usuarios que hayan publicado un post en Junio.
SELECT * FROM posts
JOIN usuarios
ON usuarios.id = posts.usuario_id
WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30';