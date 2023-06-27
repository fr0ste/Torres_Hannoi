drop database if exists Hanoi;
create database Hanoi;
use Hanoi;

-- creación de tablas
create table nivel(id_nivel int auto_increment not null primary key, numero int);

create table partida(id_partida int auto_increment not null primary key, tiempo int not null, fk_id_nivel int not null, foreign key (fk_id_nivel) references nivel(id_nivel));

create table usuario(id_usuario int auto_increment primary key, nombre varchar(20), pwd varchar(20), fk_id_partida int,fecha_creacion datetime, fecha_actualizacion datetime, fecha_eliminacion datetime, foreign key (fk_id_partida) references partida(id_partida));

create table pila(id_pila int auto_increment not null primary key, nombre int);

create table disco(id_disco int auto_increment not null primary key, nombre int);

create table disco_pila(id_disco_pila int auto_increment not null primary key, fk_id_partida int not null,fk_id_pila int not null,fk_id_disco int not null, estatus int,
foreign key (fk_id_partida) references partida(id_partida),foreign key (fk_id_pila) references pila(id_pila),foreign key (fk_id_disco) references disco(id_disco));

create table puntaje(id_puntaje int not null primary key auto_increment, tiempo int, fk_id_nivel int not null, fk_id_usuario int not null,foreign key (fk_id_nivel) references nivel(id_nivel),foreign key (fk_id_usuario) references usuario(id_usuario));

INSERT INTO nivel(numero) VALUES
(1),
(2),
(3),
(4),
(5),
(6);

INSERT INTO pila(nombre) VALUES
(1),
(2),
(3);

INSERT INTO disco(nombre) VALUES (1),(2),(3),(4),(5),(6),(7),(8);

set global time_zone= "-3:00"
