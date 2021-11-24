#Obtener nombres, vida y fuerza de guerreros que hayan recibido una poción de
#todos los druidas existentes. => Guerreros tales que no hay druida que no les haya dado pocion

SELECT personaje.Nombre_personaje, rol.Vida_personaje, rol.Fuerza, personaje.Nombre_jugador
FROM personaje, rol
WHERE personaje.Tipo_rol = rol.Tipo_rol
AND rol.Tipo_rol = "GUERRERO"
AND NOT EXISTS (SELECT * FROM npc_regala
				WHERE NOT EXISTS(SELECT * FROM druida
									 WHERE personaje.Nombre_personaje = npc_regala.Nombre_personaje
									 AND npc_regala.ID_NPC = druida.ID_NPC));
                                     