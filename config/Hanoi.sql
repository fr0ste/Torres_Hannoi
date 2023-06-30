-- Base de datos
Drop database if exists Hanoi;
CREATE DATABASE Hanoi;
CREATE USER 'hanoi'@'localhost' IDENTIFIED BY 'hanoi';
GRANT ALL PRIVILEGES ON Hanoi.* TO 'hanoi'@'localhost';
FLUSH PRIVILEGES;
USE Hanoi;

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
# Procedimientos SQL.

-- FUNCIÓN PARA VERIFICAR OBTENER EL NUMERO DE DISCOS
DELIMITER $$
DROP FUNCTION IF EXISTS obtenerNumeroDiscos$$
CREATE FUNCTION obtenerNumeroDiscos(idPartidaAux int)
RETURNS integer
DETERMINISTIC
BEGIN
    DECLARE total INT;
    
    SELECT count(*) into total FROM disco_pila WHERE fk_id_partida = idPartidaAux AND estatus = 1;
	RETURN total;
END$$
DELIMITER ;


-- Procedure para verificar si existe o no un a partida guardada
DELIMITER $$
DROP FUNCTION IF EXISTS existPartida$$
CREATE FUNCTION existPartida(idUsuarioAux INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idPartidaAux INT;
    DECLARE total INT;
    SELECT fk_id_partida INTO idPartidaAux FROM usuario WHERE id_usuario = idUsuarioAux;
    
-- Obtenemos el id de la partida, desde un with para usarlo posteriormente
    with
-- Contamos los registros guardados
        existe as (SELECT COUNT(*) AS tot FROM disco_pila WHERE fk_id_partida = idPartidaAux AND estatus = 1)
    SELECT tot INTO total FROM existe;
        
    IF total = 0 THEN
        SET idPartidaAux = 0;
    END IF;

    RETURN idPartidaAux;
END$$
DELIMITER ;

-- Para crear la tabla puntaje
DELIMITER $$
DROP PROCEDURE IF EXISTS obtenerTiempoPuntaje$$
CREATE PROCEDURE obtenerTiempoPuntaje(IN nivelAux INT)
BEGIN
    WITH n AS (
        SELECT id_nivel AS id FROM nivel WHERE numero = nivelAux
    )
    SELECT u.nombre, p.tiempo FROM usuario AS u
    INNER JOIN puntaje AS p ON u.id_usuario = p.fk_id_usuario
    WHERE p.fk_id_nivel = (SELECT id FROM n) and tiempo<>0 order by p.tiempo asc;
END$$
DELIMITER ;



delimiter $$
drop procedure if exists spObtenerDiscosPartida$$
create procedure spObtenerDiscosPartida(in idUserAux int, in nombrePila int)
begin
	declare idPartidaAux int;
    select fk_id_partida from usuario where id_usuario=idUserAux into idPartidaAux;
	
		SELECT distinct p.nombre as pila ,d.nombre as disco FROM pila p INNER JOIN disco_pila ON disco_pila.fk_id_pila=p.id_pila inner join disco as d 
			where disco_pila.fk_id_disco=d.id_disco and disco_pila.fk_id_partida=idPartidaAux and p.nombre=nombrePila and estatus=1 order by pila asc, disco asc;
end
$$
DELIMITER ;
-- Procedure para retornar el nivel y puntaje de una partida
DELIMITER $$
DROP PROCEDURE IF EXISTS spObtenerTiempoNivel$$
CREATE PROCEDURE spObtenerTiempoNivel(IN idUserAux INT)
BEGIN
	DECLARE idPartidaAux INT;
	SELECT fk_id_partida INTO idPartidaAux FROM usuario WHERE id_usuario = idUserAux;
    SELECT distinct tiempo, numero as nivel FROM partida inner join nivel on partida.fk_id_nivel=nivel.id_nivel WHERE id_partida = idPartidaAux;
END
$$
DELIMITER ;

-- Procedure para guardar el puntaje al terminar una partida
DELIMITER $$
DROP PROCEDURE IF EXISTS guardarPuntajeTiempo$$
CREATE PROCEDURE guardarPuntajeTiempo(in iduserAux int, in tiempoAux int, nivelAux int)
BEGIN
    DECLARE idPuntajeAux INT;
    DECLARE idNivelAux INT;
    
    SELECT id_nivel INTO idNivelAux FROM nivel WHERE numero = nivelAux;
    
    SELECT id_puntaje INTO idPuntajeAux FROM puntaje AS p
    WHERE p.fk_id_nivel = idNivelAux AND p.fk_id_usuario = iduserAux;
    
    IF idPuntajeAux is null THEN
        INSERT INTO puntaje(tiempo, fk_id_nivel, fk_id_usuario) VALUES (tiempoAux, idNivelAux, iduserAux);
    ELSE
		UPDATE puntaje SET tiempo = tiempoAux WHERE id_puntaje = idPuntajeAux;
        
    END IF;
    
-- Call iniciarJuego(idPartida);
END$$
DELIMITER ;


-- PROCEDURE PARA CREAR UN NUEVO USUARIO
DELIMITER $$

DROP procedure IF EXISTS crearUsuario$$
CREATE procedure crearUsuario(in userAux varchar(20),in  pwdAux varchar(20))
BEGIN
    DECLARE existe BOOLEAN;
    DECLARE userExists integer;
    DECLARE idUsuario INT;
    SET existe = userExist(userAux, pwdAux);
    
    IF existe <> 0 THEN
        SET userExists = 1;
    ELSE
        SET userExists = 0;
        INSERT INTO usuario (nombre, pwd, fecha_creacion, fecha_actualizacion) VALUES (userAux, pwdAux, NOW(), NOW());
        SET idUsuario = LAST_INSERT_ID();
        CALL crearPartida(idUsuario, 0, 1);
    END IF;
    
    select userExists;
END$$

DELIMITER ;


-- FUNCIÓN PARA VERIFICAR SI EXISTE UN NUEVO USUARIO
DELIMITER $$
DROP FUNCTION IF EXISTS userExist$$
CREATE FUNCTION userExist(userAux varchar(20), pwdAux varchar(20))
RETURNS integer
DETERMINISTIC
BEGIN
    DECLARE idAux INT;
    
    SELECT id_usuario into idAux FROM usuario WHERE nombre = userAux AND pwd = pwdAux;
    
    IF idAux > 0 THEN
        RETURN idAux;
    ELSE
		set idAux=0;
        RETURN idAux;
    END IF;
END$$
DELIMITER ;




-- PROCEDURES PARA GUARDAR UN NUEVO JUEGO EN PAUSA
-- DEBEMOS CREAR PRIMERO LA PARTIDA CON DATOS DE TIEMPO Y NIVEL, LUEGO RELACIONAR EN LA TABLA DISCOS_PILA
DELIMITER $$
DROP PROCEDURE IF EXISTS crearPartida$$
CREATE PROCEDURE crearPartida(in iduserAux int, in tiempoAux int, nivelAux int)
BEGIN
    declare idPartida int;
    declare idNivel int;
-- obtenemos el id del nivel
    SET idNivel = (SELECT id_nivel FROM nivel where numero=nivelAux);
    
-- Creamos la partida
    insert into partida(tiempo,fk_id_nivel) values(tiempoAux,idNivel);
-- Obtenemos el id de la partida creada
    SET idPartida = LAST_INSERT_ID();
# Actualizamos el campo id_partida del usuario
    update usuario set fk_id_partida=idPartida where id_usuario=iduserAux;
    
    call iniciarJuego(idPartida);
END$$
DELIMITER ;

-- Procedure para guardar un nuevo juego en pausa, recibe los datos que van en la tabla pila_disco
DELIMITER $$
DROP PROCEDURE IF EXISTS iniciarJuego$$
CREATE PROCEDURE iniciarJuego(in idPartidaAux INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 8 DO
        INSERT INTO disco_pila (fk_id_partida, fk_id_pila, fk_id_disco, estatus)
        VALUES (idPartidaAux, 1, i+1, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

-- Procedure para actualizar el timepo y nivel en la tabla partida
DELIMITER $$
DROP procedure IF EXISTS actualizarTiempoNivel$$
CREATE procedure actualizarTiempoNivel(in idusuarioAux int, in tiempoAux int,in nivelAux int)
BEGIN
	declare idPartidaAux int;
    declare idNivel int;
-- Obtenemos el id del nivel
    SET idNivel = (SELECT id_nivel FROM nivel where numero=nivelAux);
-- Obtenemos el id de la partida
    set idPartidaAux=(select fk_id_partida from usuario where id_usuario=idusuarioAux);
    update partida set tiempo=tiempoAux, fk_id_nivel=idNivel where id_partida=idPartidaAux;
END$$
DELIMITER ;


--- Procedure para borrar logicamente el juego guardado, ponemos el estatus a 0 
DELIMITER $$
DROP procedure IF EXISTS borrarJuego$$
CREATE procedure borrarJuego(in idusuarioAux int)
BEGIN
	declare idPartidaAux int;
-- Otenemos el id de la partida
    set idPartidaAux=(select fk_id_partida from usuario where id_usuario=idusuarioAux);
    
    update disco_pila set estatus = 0 where fk_id_partida=idPartidaAux;
END$$
DELIMITER ;

-- Procedure para actualizar los datos de la partida del usuario
DELIMITER $$
DROP procedure IF EXISTS actualizarJuego$$
CREATE procedure actualizarJuego(in idPartidaAux int, in discoAux int,in idpilaAux int)
BEGIN
	declare idDiscoPila int;
    declare idDisco int;
    set idDisco=(select id_disco from disco where nombre=discoAux);
    set idDiscoPila=obtenerIdDiscoPila(idPartidaAux);
-- Si el idDisco es 0 y necesitamos guardar más crearemos un nuevo registro, si no pues solo actualizamos los datos en la tabla
    if idDiscoPila <> 0 then
		update disco_pila set fk_id_pila=idpilaAux, fk_id_disco=idDisco, estatus=1 where id_disco_pila=idDiscoPila;
	else
		insert into disco_pila(fk_id_partida,fk_id_pila,fk_id_disco,estatus) values(idPartidaAux,idpilaAux,idDisco,1);
	end if;
END$$
DELIMITER ;

--- Procedure para seleccionar el id de disco_pila
DELIMITER $$
DROP function IF EXISTS obtenerIdDiscoPila$$
CREATE function obtenerIdDiscoPila(idPartidaAux int)
returns int
deterministic
BEGIN
	declare idDiscoPilaAux int;
-- Obtenemos el id de la partida
    set idDiscoPilaAux=(select id_disco_pila from disco_pila where estatus = 0 and fk_id_partida=idPartidaAux limit 1);
    if idDiscoPilaAux is null then
		set idDiscoPilaAux=0;
	end if;
    return idDiscoPilaAux;
END$$
DELIMITER ;
DELIMITER $$

-- Funcion para obtener el id de la partida
DELIMITER $$
DROP FUNCTION IF EXISTS obtenerIdPartida$$
CREATE FUNCTION obtenerIdPartida(idUsuarioAux INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idPartidaAux INT;

-- Obtenemos el id de la partida
    SET idPartidaAux = (SELECT fk_id_partida FROM usuario WHERE id_usuario = idUsuarioAux);

    IF idPartidaAux IS NULL THEN
        SET idPartidaAux = 0;
    END IF;

    RETURN idPartidaAux;
END$$
DELIMITER ;


-- Funcion para obtener el id de la partida
DELIMITER $$
DROP FUNCTION IF EXISTS obtenerTiempo$$
CREATE FUNCTION obtenerTiempo(idUsuarioAux INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE idPartidaAux INT;
    DECLARE tiempoAux int;

-- Obtenemos el id de la partida
    SET idPartidaAux = (SELECT fk_id_partida FROM usuario WHERE id_usuario = idUsuarioAux);
	set tiempoAux = (SELECT tiempo FROM partida WHERE id_partida = idPartidaAux);
    IF tiempoAux IS NULL THEN
        SET tiempoAux = 0;
    END IF;

    RETURN tiempoAux;
END$$
DELIMITER ;

