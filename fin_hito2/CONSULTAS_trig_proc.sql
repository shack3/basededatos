#---------------------------------------------A---------------------------------------------
SELECT *
FROM Dragon
WHERE nombre_dragon = 'Grifin' OR nombre_dragon = 'Ocho cabezas';

#---------------------------------------------B---------------------------------------------
SELECT p.nombre_personaje
FROM Personaje p INNER JOIN Compra c ON p.nombre_personaje = c.nombre_personaje
WHERE tipo_rol = 'Guerrero' 
AND nombre_tienda = 'Tienda de Rolla'
AND c.nombre_personaje IN (SELECT p.nombre_personaje
		                 FROM Personaje p INNER JOIN Fabrica f ON p.nombre_personaje = f.nombre_personaje
                         INNER JOIN Forja ON f.Id_forja = Forja.Id_forja
                         WHERE Nombre_forja = "Forja del enano risueño");

#---------------------------------------------C---------------------------------------------
SELECT oro_total, nombre_personaje
FROM Personaje 
ORDER BY oro_total DESC;

#---------------------------------------------D---------------------------------------------
SELECT nombre_jugador, sum(dragones_desbloq)
FROM Personaje 
GROUP BY nombre_jugador;

#---------------------------------------------E---------------------------------------------
SELECT DISTINCT Personaje.Nombre_jugador 
FROM Personaje, Compra, Tienda
WHERE Personaje.Nombre_personaje = Compra.Nombre_personaje
	  AND Tienda.Nombre_tienda = Compra.Nombre_tienda
	  AND Tienda.Nombre_ciudad NOT IN (SELECT Forja.Nombre_ciudad 
										FROM Forja
										GROUP BY Nombre_ciudad
										HAVING COUNT(*) > 2);
                                        
#---------------------------------------------F---------------------------------------------
SELECT * 
FROM Personaje, Fabrica
WHERE Fabrica.Nombre_personaje = Personaje.Nombre_personaje
AND Personaje.Tipo_rol = "TANQUE"
AND Fabrica.Nombre = "Hacha de doble punta"
AND Fabrica.Nombre_personaje NOT IN (SELECT DISTINCT Fabrica.Nombre_personaje #fabrica.Nombre 
										FROM Fabrica
										WHERE Fabrica.Nombre <> "Hacha de doble punta");
                                        
#---------------------------------------------G---------------------------------------------
SELECT Personaje.Nombre_personaje, Rol.Vida_personaje, Rol.Fuerza, Personaje.Nombre_jugador
FROM Personaje, Rol, NPC_regala
WHERE Personaje.Tipo_rol = Rol.Tipo_rol
AND Personaje.Nombre_personaje = NPC_regala.Nombre_personaje
GROUP BY Personaje.Nombre_personaje
HAVING COUNT(*) = (SELECT count(DISTINCT ID_NPC) FROM Druida);




#---------------------------------------------H---------------------------------------------
SELECT Personaje.Nivel_personaje, Personaje.Nombre_personaje
FROM Personaje INNER JOIN Rol ON Rol.Tipo_rol = Personaje.Tipo_rol
			   INNER JOIN Compra ON Personaje.Nombre_personaje = Compra.Nombre_personaje
WHERE Rol.Tipo_rol = "MAGO"
AND Personaje.Nombre_personaje IN(SELECT Personaje.Nombre_personaje 
								  FROM Personaje INNER JOIN Compra ON Personaje.Nombre_personaje = Compra.Nombre_personaje
												 INNER JOIN Daga ON Compra.Id_daga = Daga.Id_daga
								  GROUP BY Personaje.Nombre_personaje
								  HAVING count(DISTINCT Daga.Nombre_daga) = (SELECT count(DISTINCT Daga.Nombre_daga) FROM Daga))
GROUP BY Personaje.Nombre_personaje
HAVING COUNT(*) = (SELECT COUNT(DISTINCT Enemigo.Nombre_enemigo)
				   FROM Enemigo
                   WHERE Enemigo.Nombre_tipoene = "ESPECTRO");





#---------------------------------------------I---------------------------------------------
SELECT Nombre_personaje,Nivel_personaje,Oro_total,Apariencia,Tipo_rol,Dragones_desbloq
FROM Personaje INNER JOIN Escuadron ON Personaje.Nombre_personaje=Escuadron.Nombre_personaje_tanque
GROUP BY Escuadron.Nombre_personaje_tanque
HAVING COUNT(Nombre_personaje_tanque) = (SELECT MAX(can)
										 FROM (SELECT count(Nombre_personaje_tanque) as can
											   FROM Escuadron
                                               Group BY Nombre_personaje_tanque) P);
                                               
#---------------------------------------------J---------------------------------------------
SELECT distinct Arma.Nombre, Arma.Tipo_arma, Peso,Nombre_forja
FROM Arma INNER JOIN Fabrica ON Arma.Tipo_arma=Fabrica.Tipo_arma
INNER JOIN Forja ON Forja.Id_forja=Fabrica.Id_forja
WHERE Arma.Peso= (SELECT MIN(Peso)
					   FROM Arma
                       WHERE Tipo_arma= "Hacha");                                               






#--------------------------------------------PROCEDIMIENTOS--------------------------------------------
#---------------------------------------------------A--------------------------------------------------

ALTER TABLE Personaje
ADD Enemigos_eliminados INTEGER ;


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

#-------------------------------------------------------------------------------------------
#----------------------------------PRUEBAS PROCEDIMIENTO A----------------------------------
#-------------------------------------------------------------------------------------------



SELECT * FROM Personaje WHERE Nombre_personaje="Dryto";

UPDATE Personaje SET Enemigos_eliminados= "51" WHERE Nombre_personaje="Dryto";

CALL aumento_vida();

SELECT * FROM Personaje WHERE Nombre_personaje="Dryto";








#---------------------------------------------B---------------------------------------
ALTER TABLE Personaje
ADD Ultima_conex DATE  ;

DELIMITER $$
CREATE PROCEDURE ult_conexion(IN Fecha Date)
BEGIN 
	DECLARE Fecha_ult Date;
    DECLARE diff Integer;
    DECLARE Nombre VARCHAR(30);
    
    
    DECLARE done INT DEFAULT FALSE;
    DECLARE cursor1 CURSOR FOR SELECT Nombre_personaje,Ultima_conex FROM Personaje ;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor1;
		bucle: LOOP
			FETCH cursor1 INTO Nombre, Fecha_ult;
		
			IF done THEN
				LEAVE bucle;
			END IF;
			
			SELECT Ultima_conex INTO Fecha_ult  
					FROM Personaje
					WHERE Nombre = Nombre_personaje;
			
			SELECT DATEDIFF(Fecha, Fecha_ult) INTO diff;
            
			IF diff >= 60 THEN
				DELETE FROM Personaje
				Where Nombre = Nombre_personaje;
			END IF;
			
        END LOOP bucle;
		CLOSE cursor1;
        
END $$
DELIMITER ;

#-------------------------------------------------------------------------------------------
#----------------------------------PRUEBAS PROCEDIMIENTO B----------------------------------
#-------------------------------------------------------------------------------------------
SELECT * FROM Personaje;

UPDATE Personaje SET Ultima_conex= "2020-10-01" WHERE Nombre_personaje="Raendan";
UPDATE Personaje SET Ultima_conex= "2017-12-11" WHERE Nombre_personaje="Ahkarg";
UPDATE Personaje SET Ultima_conex= "2021-11-11" WHERE Nombre_personaje="Bucksel";

CALL `Dragones_Y_Mazmorras`.`ult_conexion`("2021-12-19");

SELECT * FROM Personaje;




#---------------------------------------TRIGGERS--------------------------------------------
#-------------------------------------------A-----------------------------------------------
DELIMITER //
CREATE TRIGGER Drakes BEFORE UPDATE ON Personaje
FOR EACH ROW
BEGIN
	IF NEW.Dragones_desbloq >= 3 THEN
	SET NEW.Vida_personaje = NEW.Vida_personaje + 5;
	END IF;
END//
DELIMITER ;
#-------------------------------------------------------------------------------------------
#----------------------------------PRUEBAS TRIGGER A----------------------------------------
#-------------------------------------------------------------------------------------------

SELECT * FROM Personaje WHERE Nombre_personaje="Enso";

UPDATE Personaje SET Dragones_desbloq= 3 WHERE Nombre_personaje="Enso";

SELECT * FROM Personaje WHERE Nombre_personaje="Enso";





#---------------------------------------------B---------------------------------------------
DELIMITER //
CREATE TRIGGER Bloqueo AFTER INSERT ON Participa_escuadron
FOR EACH ROW
BEGIN
	DECLARE Min_Dragon INTEGER;
	DECLARE Minimo INTEGER;
  
    SELECT Num_dragon INTO Min_Dragon
    FROM Mision_escuadron INNER JOIN Participa_escuadron ON Mision_escuadron.Cod_mision=Participa_escuadron.Participa_Cod_mision
    WHERE Participa_escuadron.Participa_Cod_mision=NEW.Participa_Cod_mision;
    
    SELECT min(Dragones_desbloq) INTO Minimo
    FROM Personaje INNER JOIN Escuadron ON Personaje.Nombre_personaje=Escuadron.Nombre_personaje_tanque OR Personaje.Nombre_personaje=Escuadron.Nombre_personaje_mago OR Personaje.Nombre_personaje=Escuadron.Nombre_personaje_guerrero
    INNER JOIN Participa_escuadron ON Escuadron.Cod_escuadron=Participa_escuadron.Participa_Cod_escuadron
    INNER JOIN Mision_escuadron ON Mision_escuadron.Cod_mision=Participa_escuadron.Participa_Cod_mision
    WHERE Participa_escuadron.Participa_Cod_escuadron=NEW.Participa_Cod_escuadron; 
    
    
    IF Minimo<Min_Dragon Then
		SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT =' ERROR: Un Personaje no tiene el Dragon desbloqueado';
	END IF;
    
END//
DELIMITER ; 
#-------------------------------------------------------------------------------------------
#----------------------------------PRUEBAS TRIGGER B----------------------------------------
#-------------------------------------------------------------------------------------------
DROP TRIGGER Bloqueo;

SELECT * FROM Personaje WHERE Nombre_Personaje="Bucksel" OR Nombre_personaje = "Enso" OR Nombre_personaje="Stanto";

INSERT INTO Escuadron(Nombre_personaje_tanque, Nombre_personaje_mago, Nombre_personaje_guerrero)
VALUES ("Bucksel", "Enso", "Stanto");

SELECT * FROM Escuadron;


INSERT INTO Participa_escuadron(Participa_Cod_mision, Participa_Cod_escuadron) VALUES (12338, 3); #La mision con codigo 12338 contiene un dragon de nivel 6
INSERT INTO Participa_escuadron(Participa_Cod_mision, Participa_Cod_escuadron) VALUES (23452, 3); #La mision con codigo 23452 contiene un dragon de nivel 1

SELECT * FROM Participa_escuadron;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE Participa FROM Participa_escuadron AS Participa LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
													   LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision
                                                       WHERE  `Nivel_escuadron` < `Num_dragon`;

DELETE FROM Participa_escuadron WHERE Participa_Cod_escuadron= 1;


DELETE FROM Escuadron;

DELETE FROM Participa_escuadron WHERE Participa_escuadron.Participa_Cod_escuadron IN (SELECT * FROM (SELECT Participa_escuadron.Participa_Cod_escuadron FROM  Participa_escuadron 
												LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
												LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision
												WHERE `Nivel_escuadron` < `Num_dragon`)AS A);
#------------------------------------




SELECT * FROM Participa_escuadron 
			LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
			LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision;



SELECT Participa_escuadron.Participa_Cod_escuadron FROM Participa_escuadron LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
								  LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision;

SELECT Participa_escuadron.Participa_Cod_escuadron FROM  Participa_escuadron 
												LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
												LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision
												WHERE `Nivel_escuadron` < `Num_dragon`;
#Selecciona todo 
SELECT * FROM Participa_escuadron 
			LEFT JOIN Escuadron ON Participa_escuadron.Participa_Cod_escuadron=Escuadron.Cod_escuadron 
			LEFT JOIN Mision_escuadron ON Participa_escuadron.Participa_Cod_mision=Mision_escuadron.Cod_mision;

