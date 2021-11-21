
INSERT INTO Ciudad  (Nombre_ciudad)
VALUES ("Glider"), ("Forgesand"), ("Hiltore"), ("Gazegreenelven"),("Greenbat"), ("Huntdwarf");

INSERT INTO Rol (Tipo_rol, Fuerza, Vida_personaje, Mana)
VALUES ("MAGO", 12, 200, 100), ("GUERRERO", 20, 400, 50), ("TANQUE", 40, 800, 10);

INSERT INTO Personaje
VALUES ("Raendan", 0, 0, "Guapo", "MAGO", 0), ("Manddin", 0, 0, "Bello", "MAGO", 0), ("Xadel", 0, 0, "Feo", "MAGO", 0), ("Enso", 0, 0, "Mediocre", "MAGO", 0),
	   ("Stanto", 0, 0, "Alto", "GUERRERO", 0), ("Makwi", 0, 0, "Gordo", "GUERRERO", 0), ("Carorhall", 0, 0, "Reluciente", "GUERRERO", 0), ("Dryto", 0, 0, "Poderoso", "GUERRERO", 0),
      ("Ahkarg", 0, 0, "Especialista", "TANQUE", 0), ("Bucksel", 0, 0, "Armario", "TANQUE", 0), ("Mashgor", 0, 0, "Bajo", "TANQUE", 0), ("Gim", 0, 0, "Elfo", "TANQUE", 0);

INSERT INTO Daga 
VALUES (0, "Daga de madera"), (1, "Daga de bronce"), (2, "Daga de marfil"), (3, "Daga de diamante");

INSERT INTO Habilidad 
VALUES ("Intelecto Arcano", 0, "Aumenta el mana", "MAGO"), ("Traslacion", 3, "Te trasladas a un radio de 30m", "MAGO"), ("Nova de Escarcha", 10, "Inflige una tormenta", "MAGO"),
("Tajo de mandoble", 0, "Tajo de mandoble bro", "GUERRERO"), ("Impacto abrumador", 3, "Coges carrerilla e impactas con el escudo", "GUERRERO"), ("Ataque en torbellino", 10, "Giras como Link en The legend of Zelda", "GUERRERO"),
("Impacto feroz", 0, "Golpeas el suelo con gran fuerza", "TANQUE"), ("Rompespaldas", 3, "Si el enemigo esta de espaldas es un 100% kill", "TANQUE"), ("Seismo", 10, "Golpeas repetidamente el suelo creando un seismo", "TANQUE");