#Obtener el nivel de los magos que han derrotado a todos los espectros y han
#comprado todas las dagas disponibles.

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
