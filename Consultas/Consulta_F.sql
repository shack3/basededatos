#Obtener los tanques que únicamente portan hachas de doble punta.
SELECT * 
FROM personaje, fabrica
WHERE fabrica.Nombre_personaje = personaje.Nombre_personaje
AND personaje.Tipo_rol = "TANQUE"
AND fabrica.Nombre = "Hacha de doble punta"
AND fabrica.Nombre_personaje NOT IN (SELECT DISTINCT fabrica.Nombre_personaje #fabrica.Nombre 
										FROM fabrica
										WHERE fabrica.Nombre <> "Hacha de doble punta");
						