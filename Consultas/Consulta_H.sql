#Obtener el nivel de los magos que han derrotado a todos los espectros y han
#comprado todas las dagas disponibles.

SELECT personaje.Nivel_personaje, personaje.Nombre_personaje
FROM personaje, rol, compra
WHERE rol.Tipo_rol = personaje.Tipo_rol
AND personaje.Nombre_personaje = compra.Nombre_personaje
AND rol.Tipo_rol = "MAGO"
AND personaje.Nombre_personaje IN (SELECT personaje.Nombre_personaje
									FROM personaje, mision_indi, enemigo
									WHERE personaje.Nivel_personaje = mision_indi.Nombre_personaje
									AND mision_indi.Cod_misionindi = enemigo.Cod_misionindi
                                    GROUP BY Nombre_personaje
                                    HAVING count(Nombre_enemigo) = (SELECT count(DISTINCT Nombre_enemigo) FROM enemigo))
GROUP BY personaje.Nombre_personaje
HAVING count(*) = (SELECT count(DISTINCT daga.Nombre_daga) FROM daga);