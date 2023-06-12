-- procedimiento para retornar una tabla de registros de partida de un usuario por su id
use Hanoi;

delimiter $$
drop procedure if exists spObtenerDiscosPartida$$
create procedure spObtenerDiscosPartida(in idUserAux int, in nombrePila int)
begin
	declare idPartidaAux int;
    select fk_id_partida from usuario where id_usuario=idUserAux into idPartidaAux;
	
		SELECT distinct p.nombre as pila ,d.nombre as disco FROM pila p INNER JOIN disco_pila ON disco_pila.fk_id_pila=p.id_pila inner join disco as d 
			where disco_pila.fk_id_disco=d.id_disco and disco_pila.fk_id_partida=idPartidaAux and p.nombre=nombrePila order by pila asc, disco asc;
end
$$
DELIMITER ;

-- procedure para retornar el nivel y puntaje de una partida
DELIMITER $$
DROP PROCEDURE IF EXISTS spObtenerTiempoNivel$$
CREATE PROCEDURE spObtenerTiempoNivel(IN idUserAux INT)
BEGIN
	DECLARE idPartidaAux INT;
	SELECT fk_id_partida INTO idPartidaAux FROM usuario WHERE id_usuario = idUserAux;
    SELECT distinct tiempo, nivel FROM partida WHERE id_partida = idPartidaAux;
END
$$
DELIMITER ;

-- PROCEDURE PARA CREAR UN NUEVO USUARIO
DELIMITER $$

DROP FUNCTION IF EXISTS crearUsuario$$
CREATE FUNCTION crearUsuario(userAux varchar(25), pwdAux varchar(15))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SET existe = userExist(userAux, pwdAux);
    
    IF existe THEN
        RETURN true;
    ELSE
        INSERT INTO usuario (nombre, pwd,fecha_creacion,fecha_actualizacion) VALUES (userAux, pwdAux,now(),now());
        RETURN FALSE;
    END IF;
END$$

DELIMITER ;



-- FUNCIÓN PARA VERIFICAR SI EXISTE UN NUEVO USUARIO
DELIMITER $$
DROP FUNCTION IF EXISTS userExist$$
CREATE FUNCTION userExist(userAux varchar(25), pwdAux varchar(15))
RETURNS BOOLEAN
deterministic
BEGIN
    DECLARE userCount INT;
    SET userCount = (SELECT COUNT(*) FROM usuario WHERE nombre = userAux AND pwd = pwdAux);
    IF userCount > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END$$
DELIMITER ;



-- PROCEDURES PARA GUARDAR UN NUEVO JUEGO EN PAUSA
-- DEBEMOS CREAR PRIMERO LA PARTIDA CON DATOS DE TIEMPO Y NIVEL, LUEGO RELACIONAR EN LA TABLA DISCOS_PILA
DELIMITER $$
DROP PROCEDURE IF EXISTS crearPartida$$
CREATE PROCEDURE crearPartida(in iduserAux int, in tiempoAux int, nivelAux int,in puntajeAux int)
BEGIN
	declare idPartida int;
    -- creamos la partida
    insert into partida(tiempo,nivel) values(tiempoAux,nivelAux);
    -- insertamos el puntaje de dicha partida
    insert into puntaje(puntaje,fk_id_usuario) values (puntajeAux,iduserAux);
    -- obtenemos el id de la partida creada
    SET idPartida = (SELECT id_partida FROM partida ORDER BY id_partida desc LIMIT 1);
    -- actualizamos el campo id_partida del usuario
    update usuario set fk_id_partida=idPartida where id_usuario=iduserAux;
    -- retornamos el id de la partida para posteriormente insertar los discos
	select idPartida;
END$$
DELIMITER ;


-- procedure para guardar un nuevo juego en pausa, recibe los datos que van en la tabla pila_disco
DELIMITER $$
DROP procedure IF EXISTS guardarJuego$$
CREATE procedure guardarJuego(in idPartidaAux int, in discoAux int,in idpilaAux int)
BEGIN
	declare idDisco int;
    set idDisco=(select id_disco from disco where nombre=discoAux);
    insert into pila_disco(fk_id_partida,fk_id_pila,fk_id_disco) values(idPartidaAux,idpilaAux,idDisco);
END$$
DELIMITER ;

-- procedure para actualizar el tiepo y nivel en la tabla partida
DELIMITER $$
DROP procedure IF EXISTS actualizarTiempoNivel$$
CREATE procedure actualizarTiempoNivel(in idusuarioAux int, in tiempoAux int,in nivelAux int)
BEGIN
	declare idPartidaAux int;
    set idPartidaAux=(select fk_id_partida from usuario where id_usuario=idusuarioAux);
    update partida set tiempo=tiempoAux, nivel=nivelAux where id_partida=idPartidaAux;
END$$
DELIMITER ;

-- **************************procedure para actualizar