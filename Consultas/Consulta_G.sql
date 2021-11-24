#Obtener nombres, vida y fuerza de guerreros que hayan recibido una poción de
#todos los druidas existentes. => Guerreros tales que no hay druida que no les haya dado pocion

SELECT personaje.Nombre_personaje, rol.Vida_personaje, rol.Fuerza, personaje.Nombre_jugador
FROM personaje, rol, NPC_Regala
WHERE personaje.Tipo_rol = rol.Tipo_rol
AND personaje.Nombre_personaje = NPC_Regala.Nombre_personaje
GROUP BY personaje.Nombre_personaje
HAVING COUNT(*) = (SELECT count(DISTINCT ID_NPC) FROM druida);
