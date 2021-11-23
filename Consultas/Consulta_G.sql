#Obtener nombres, vida y fuerza de guerreros que hayan recibido una poción de
#todos los druidas existentes.

SELECT rol.Tipo_rol, rol.Vida_personaje, rol.Fuerza 
FROM rol, personaje, npc_regala
WHERE rol.Tipo_rol = personaje.Tipo_rol
AND personaje.Nombre_personaje = npc_regala.Nombre_personaje
AND rol.Tipo_rol = "GUERRERO"
GROUP BY personaje.Nombre_personaje
HAVING COUNT(*) > (SELECT COUNT(DISTINCT ID_NPC)
					FROM druida);