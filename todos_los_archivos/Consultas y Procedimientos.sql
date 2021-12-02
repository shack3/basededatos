

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
	DECLARE Minimio INTEGER;
  
    
    SELECT Num_dragon INTO Min_Dragon
    FROM Mission_escuadron INNER JOIN Dragon ON Mission_escuadron.Nombre_dragon=Dragon.Nombre_dragon;
    
    SELECT MIN(Dragones_desbloq) INTO Minimo
    FROM Personaje INNER JOIN Escuadron ON Personaje.Nombre_personaje=Escuadron.Nombre_personaje_tanque 
    INNER JOIN Mission_escuadron ON Escuadron.Cod_escuadron=Mission_escuadron.Cod_escuadron;
    
    IF Minimo<MinDragon Then
		SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT =' ERROR: Un Personaje no tiene el Dragon desbloqueado';
	END IF;
    
END//
DELIMITER ;
