drop database if exists Hanoi;
create database Hanoi;
use Hanoi;

-- creación de tablas
create table partida(id_partida int auto_increment not null primary key, tiempo int not null, nivel int not null);

create table usuario(id_usuario int auto_increment primary key, nombre varchar(20), pwd varchar(20), fk_id_partida int,fecha_creacion datetime, fecha_actualizacion datetime, fecha_eliminacion datetime, foreign key (fk_id_partida) references partida(id_partida));

create table pila(id_pila int auto_increment not null primary key, nombre int);

create table disco(id_disco int auto_increment not null primary key, nombre int);

create table disco_pila(id_disco_pila int auto_increment not null primary key, fk_id_partida int not null,fk_id_pila int not null,fk_id_disco int not null,
	foreign key (fk_id_partida) references partida(id_partida),foreign key (fk_id_pila) references pila(id_pila),foreign key (fk_id_disco) references disco(id_disco));

create table puntaje(id_puntaje int not null primary key auto_increment, puntaje int, fk_id_usuario int, foreign key (fk_id_usuario) references usuario(id_usuario));

INSERT INTO partida(tiempo, nivel) VALUES
(60, 6),
(120, 4),
(90, 6),
(80, 1),
(150, 6),
(100, 6),
(110, 6),
(70, 2),
(130, 3),
(140, 1);

INSERT INTO usuario(nombre, pwd, fecha_creacion, fecha_actualizacion, fecha_eliminacion, fk_id_partida) VALUES
('Usuario1', 'pwd1', NOW(), NOW(), NULL,1),
('Usuario2', 'pwd2', NOW(), NOW(), NULL,2),
('Usuario3', 'pwd3', NOW(), NOW(), NULL,3),
('Usuario4', 'pwd4', NOW(), NOW(), NULL,4),
('Usuario5', 'pwd5', NOW(), NOW(), NULL,5),
('Usuario6', 'pwd6', NOW(), NOW(), NULL,6),
('Usuario7', 'pwd7', NOW(), NOW(), NULL,7),
('Usuario8', 'pwd8', NOW(), NOW(), NULL,8),
('Usuario9', 'pwd9', NOW(), NOW(), NULL,9),
('Usuario10', 'pwd10', NOW(), NOW(), NULL,10);

INSERT INTO pila(nombre) VALUES
(1),
(2),
(3);

INSERT INTO disco(nombre) VALUES (1),(2),(3),(4),(5),(6),(7),(8);

-- Juego 1
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(1, 1, 1),
(1, 1, 5),
(1, 1, 3),
(1, 2, 8),
(1, 2, 6),
(1, 2, 4),
(1, 2, 7),
(1, 2, 2);

-- Juego 2
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(2, 1, 1),
(2, 1, 2),
(2, 1, 3),
(2, 2, 4),
(2, 2, 5),
(2, 2, 6);

-- Juego 3
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(3, 1, 1),
(3, 1, 2),
(3, 1, 3),
(3, 1, 4),
(3, 2, 5),
(3, 2, 6),
(3, 2, 7),
(3, 2, 8);

-- Juego 4
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(4, 1, 1),
(4, 1, 2),
(4, 1, 3);

-- Juego 5
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(5, 1, 1),
(5, 1, 2),
(5, 1, 3),
(5, 1, 4),
(5, 2, 5),
(5, 2, 6),
(5, 3, 7),
(5, 3, 8);

-- Juego 6
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(6, 1, 1),
(6, 1, 2),
(6, 1, 3),
(6, 2, 4),
(6, 2, 5),
(6, 3, 6),
(6, 3, 7),
(6, 3, 8);

-- Juego 7
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(7, 1, 1),
(7, 1, 2),
(7, 1, 3),
(7, 2, 4),
(7, 2, 5),
(7, 3, 6),
(7, 3, 7),
(7, 3, 8);

-- Juego 8
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(8, 1, 1),
(8, 1, 2),
(8, 2, 3),
(8, 2, 4);

-- Juego 9
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(9, 1, 1),
(9, 1, 2),
(9, 1, 3),
(9, 2, 4),
(9, 3, 5);

-- Juego 10
INSERT INTO disco_pila(fk_id_partida, fk_id_pila, fk_id_disco) VALUES
(10, 1, 1),
(10, 1, 2),
(10, 3, 3);


INSERT INTO puntaje(puntaje, fk_id_usuario) VALUES
(10, 1),
(100, 2),
(18, 3),
(10, 4),
(100, 5),
(18, 6),
(10, 7),
(100, 8),
(18, 9),
(65, 10);




-- consulta que reciba el id del juego y de la pila(torre) y regrese los discos que le pertenecen a esa pila




set global time_zone= "-3:00"