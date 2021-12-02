/*a*/
select *
from dragon
where nombre_dragon = 'Grifin' or nombre_dragon = 'Ocho cabezas';

/*b*/
select p.nombre_personaje
from personaje p inner join compra c on p.nombre_personaje = c.nombre_personaje
where tipo_rol = 'Guerrero' 
and nombre_tienda = 'Tienda de Rolla'
and c.nombre_personaje in (select p.nombre_personaje
		                 from personaje p inner join fabrica f on p.nombre_personaje = f.nombre_personaje
                         where id_forja = 2);

/*c*/
select oro_total, nombre_personaje
from personaje 
order by oro_total desc;

/*d*/
select nombre_jugador, sum(dragones_desbloq)
from personaje 
group by nombre_jugador;

/*E*/
SELECT DISTINCT personaje.Nombre_jugador 
FROM personaje, compra, tienda
WHERE personaje.Nombre_personaje = compra.Nombre_personaje
	  AND tienda.Nombre_tienda = compra.Nombre_tienda
	  AND tienda.Nombre_ciudad NOT IN (SELECT forja.Nombre_ciudad 
										FROM forja
										GROUP BY Nombre_ciudad
										HAVING COUNT(*) > 2);
                                        
/*F*/
SELECT * 
FROM personaje, fabrica
WHERE fabrica.Nombre_personaje = personaje.Nombre_personaje
AND personaje.Tipo_rol = "TANQUE"
AND fabrica.Nombre = "Hacha de doble punta"
AND fabrica.Nombre_personaje NOT IN (SELECT DISTINCT fabrica.Nombre_personaje #fabrica.Nombre 
										FROM fabrica
										WHERE fabrica.Nombre <> "Hacha de doble punta");
                                        
/*G*/
SELECT personaje.Nombre_personaje, rol.Vida_personaje, rol.Fuerza, personaje.Nombre_jugador
FROM personaje, rol, NPC_Regala
WHERE personaje.Tipo_rol = rol.Tipo_rol
AND personaje.Nombre_personaje = NPC_Regala.Nombre_personaje
GROUP BY personaje.Nombre_personaje
HAVING COUNT(*) = (SELECT count(DISTINCT ID_NPC) FROM druida);

/*H*/
SELECT personaje.Nivel_personaje, personaje.Nombre_personaje
FROM personaje INNER JOIN rol ON rol.Tipo_rol = personaje.Tipo_rol
			   INNER JOIN compra ON personaje.Nombre_personaje = compra.Nombre_personaje
WHERE rol.Tipo_rol = "MAGO"
AND personaje.Nombre_personaje IN(SELECT personaje.Nombre_personaje 
								  FROM personaje INNER JOIN compra ON personaje.Nombre_personaje = compra.Nombre_personaje
												 INNER JOIN daga ON compra.Id_daga = daga.Id_daga
								  GROUP BY personaje.Nombre_personaje
								  HAVING count(DISTINCT daga.Nombre_daga) = (SELECT count(DISTINCT daga.Nombre_daga) FROM daga))
GROUP BY personaje.Nombre_personaje
HAVING COUNT(*) = (SELECT COUNT(DISTINCT enemigo.Nombre_enemigo)
				   FROM enemigo
                   WHERE enemigo.Nombre_tipoene = "ESPECTRO");

#I
SELECT Nombre_personaje,Nivel_personaje,Oro_total,Apariencia,Tipo_rol,Dragones_desbloq
FROM Personaje INNER JOIN Escuadron ON Personaje.Nombre_personaje=Escuadron.Nombre_personaje_tanque
GROUP BY Escuadron.Nombre_personaje_tanque
HAVING COUNT(Nombre_personaje_tanque) = (SELECT MAX(can)
										 FROM (SELECT count(Nombre_personaje_tanque) as can
											   FROM Escuadron
                                               Group BY Nombre_personaje_tanque) P);
                                               
#J
SELECT distinct Arma.Nombre, Arma.Tipo_arma, Peso,Nombre_forja
FROM Arma INNER JOIN Fabrica ON Arma.Tipo_arma=Fabrica.Tipo_arma
INNER JOIN Forja ON Forja.Id_forja=Fabrica.Id_forja
WHERE Arma.Peso= (SELECT MIN(Peso)
					   FROM Arma
                       WHERE Tipo_arma= "Hacha");                                               

#PROCEDIMIENTOS
#A

ALTER TABLE Personaje
ADD Enemigos_eliminados integer ;

select *
from Personaje;

update Personaje set Enemigos_eliminados= "51" where Nombre_personaje="Dryto";

DELIMITER //
CREATE PROCEDURE aumento_vida()
BEGIN

  DECLARE done INT DEFAULT FALSE;
  DECLARE Mas_vida INTEGER;
  DECLARE Nombre VARCHAR(255);
  DECLARE Rol VARCHAR(255);
  DECLARE Enemigos INTEGER;

  DECLARE cursor1 CURSOR FOR SELECT Nombre_personaje, Tipo_Rol, Vida_personaje, Enemigos_eliminados FROM Personaje ;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cursor1;
    bucle: LOOP
    FETCH cursor1 INTO Nombre,Rol,Mas_vida,Enemigos;

    IF done THEN
      LEAVE bucle;
    END IF;
	IF Rol="GUERRERO" THEN
		IF Enemigos >= 50 THEN
		UPDATE Personaje  SET Vida_personaje = Mas_vida + 10 WHERE Nombre_personaje = Nombre;
		END IF;
	END IF;
    
    
  END LOOP bucle;
  CLOSE cursor1;

END//
DELIMITER ;

call aumento_vida();

select *
from Personaje;

#B
ALTER TABLE Personaje
ADD Ultima_conex DATE  ;

select *
from Personaje;

update Personaje set Ultima_conex= "2021-11-11" where Nombre_personaje="Raendan"
DELIMITER $$
CREATE PROCEDURE ult_conexion(IN  Fecha Date, IN Nombre varchar(50))
BEGIN 
	DECLARE Fecha_ult Date;
    DECLARE diff Integer;
    SELECT Ultima_conex INTO Fecha_ult  
    FROM Personaje
    WHERE Nombre= Nombre_personaje;
    
    SELECT DATEDIFF(Fecha, Fecha_ult) INTO diff;
    IF diff >= 60 THEN
		DELETE FROM Personaje
        Where Nombre= Nombre_personaje;
	END IF;
END $$
DELIMITER ;

CALL `Dragones_Y_Mazmorras`.`ult_conexion`("2022-10-11", "Raendan");

#TRIGGERS 
#A

DELIMITER //
CREATE TRIGGER Drakes BEFORE UPDATE ON Personaje
FOR EACH ROW
BEGIN
	IF NEW.Dragones_desbloq >= 3 THEN
	SET NEW.Vida_personaje = NEW.Vida_personaje +10;
	END IF;
END//
DELIMITER ;

UPDATE Personaje SET Dragones_desbloq= 3 WHERE Nombre_personaje="Enso";

select *
from Personaje;

#B
DELIMITER //
CREATE TRIGGER Bloqueo BEFORE UPDATE ON Mision_escuadron
FOR EACH ROW
BEGIN
	DECLARE Min_Dragon INTEGER;
	DECLARE Minimo INTEGER;
  
    
    SELECT Num_dragon INTO Min_Dragon
    FROM Mission_escuadron INNER JOIN Dragon ON Mission_escuadron.Num_dragon=Dragon.Num_dragon;
    
    SELECT MIN(Dragones_desbloq) INTO Minimo
    FROM Personaje INNER JOIN Escuadron ON Personaje.Nombre_personaje=Escuadron.Nombre_personaje_tanque 
    INNER JOIN Mission_escuadron ON Escuadron.Cod_escuadron=Mission_escuadron.Cod_escuadron;
    
    IF Minimo<MinDragon Then
		SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT =' ERROR: Un Personaje no tiene el Dragon desbloqueado';
	END IF;
    
END//
DELIMITER ;
select *
from Mision_escuadron;
 INSERT INTO Mision_escuadron
VALUES (9,6);