#Obtener el nombre de los jugadores cuyos personajes no hayan comprado en
#tiendas de ciudades con más de dos forjas
SELECT personaje.Nombre_jugador 
FROM personaje, compra, tienda
WHERE personaje.Nombre_personaje = compra.Nombre_personaje
	  AND tienda.Nombre_tienda = compra.Nombre_tienda
	  AND tienda.Nombre_ciudad NOT IN (SELECT forja.Nombre_ciudad 
										FROM forja
										GROUP BY Nombre_ciudad
										HAVING COUNT(*) > 2);
                                       
