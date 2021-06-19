-- Crear database
DROP DATABASE unidad2;
CREATE DATABASE unidad2;

\c unidad2;
\q

-- Punto 1 - Cargar el respaldo de la base de datos unidad2.sql desde afuera por el error: -bash: unidad2.sql: No such file or directory
psql -U mari02 unidad2 < unidad2.sql

psql

-- Punto 2
BEGIN;

INSERT INTO compra (id, cliente_id, fecha)
VALUES (33, 1, current_date);

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (9, 33, 4);

UPDATE producto SET stock = stock - 4
WHERE id = 9;

COMMIT;

-- Punto 3

BEGIN;

INSERT INTO compra (cliente_id, fecha)
VALUES (2, NOW());

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (1, (SELECT MAX(id) FROM compra), 3);

UPDATE producto SET stock = stock - 3
WHERE id = 1;

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES(2, (SELECT MAX(id) FROM compra), 3);

UPDATE producto SET stock = stock - 3
WHERE id = 2;

INSERT INTO detalle_compra (producto_id, compra_id, cantidad)
VALUES (8, (SELECT MAX(id) FROM compra), 3);

UPDATE producto SET stock = stock - 3
WHERE id = 8;

COMMIT;

-- Punto 4

\set AUTOCOMMIT off
\echo :AUTOCOMMIT

INSERT INTO cliente (nombre, email)
VALUES ('Usuario nuevo', 'suemail@desafiolatam.com');

SELECT * FROM cliente;

ROLLBACK;

SELECT * FROM cliente;

\set AUTOCOMMIT on
\echo :AUTOCOMMIT