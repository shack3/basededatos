
INSERT INTO Ciudad  (Nombre_ciudad)
VALUES ("Glider"), ("Forgesand"), ("Hiltore"), ("Gazegreenelven"),("Greenbat"), ("Huntdwarf");

INSERT INTO Tienda
VALUES ("El ojo del lobo", "Glider"), ("El huracan despiadado", "Forgesand"), ("Bazar", "Hiltore"), ("Tienda de ogros", "Gazegreenelven"), ("La esquina endiablada", "Greenbat"), ("Articulos prohibidos", "Huntdwarf")
,("Tienda de Rolla", "Huntdwarf"), ("Tienda de Swithron", "Glider"), ("Tienda de Aldlas", "Forgesand");

INSERT INTO Forja
VALUES ("Forja de Harmek", "Glider", "ESPADA"), ("Forja del enano risueño", "Forgesand", "HACHA"), ("Forjad de Tebez", "Hiltore", "BACULO");


INSERT INTO Rol (Tipo_rol, Fuerza, Vida_personaje, Mana)
VALUES ("MAGO", 12, 200, 100), ("GUERRERO", 20, 400, 50), ("TANQUE", 40, 800, 10);

INSERT INTO Pocion 
VALUES (0,20,50), (1,50,100), (2,100,250);

INSERT INTO Druida
VALUES (54367);

INSERT INTO Dragon
VALUES ("Dehiss", 1000, 0),("Rannyexba", 1500, 1),("Pastan", 2500, 2),("Grifin", 3060, 3),("Kystorm", 4800, 4),("Ocho cabezas", 12000, 5);

INSERT INTO Desbloquea
VALUES ("Dehiss", "Rannyexba"), ("Rannyexba", "Pastan"), ("Pastan", "Grifin"), ("Grifin", "Kystorm"), ("Kystorm", "Ocho cabezas");

INSERT INTO Jugador VALUES
("Breakfury"),
("Hammerpowerthunder"),
("Battlerboar"),
("Cloakbane"),
("Greyblade");

INSERT INTO Personaje VALUES 
("Raendan", 0, 0, "Guapo", "MAGO", 0, "Breakfury"), 
("Manddin", 0, 0, "Bello", "MAGO", 0, "Hammerpowerthunder"), 
("Xadel", 0, 0, "Feo", "MAGO", 0, "Greyblade"), 
("Enso", 0, 0, "Mediocre", "MAGO", 0, "Battlerboar"),
("Stanto", 0, 0, "Alto", "GUERRERO", 0, "Cloakbane"),
("Makwi", 0, 0, "Gordo", "GUERRERO", 0, "Greyblade"), 
("Carorhall", 0, 0, "Reluciente", "GUERRERO", 0, "Breakfury"), 
("Dryto", 0, 0, "Poderoso", "GUERRERO", 0, "Hammerpowerthunder"),
("Ahkarg", 0, 0, "Especialista", "TANQUE", 0, "Battlerboar"),
("Bucksel", 0, 0, "Armario", "TANQUE", 0, "Cloakbane"),
("Mashgor", 0, 0, "Bajo", "TANQUE", 0, "Greyblade"), 
("Gim", 0, 0, "Elfo", "TANQUE", 0, "Breakfury");

INSERT INTO Mision_indi (Nombre_personaje)
VALUES ("Raendan"), ("Ahkarg"), ("Bucksel"), ("Carorhall");

INSERT INTO Arma
VALUES ("HACHA", "Ahkarg", 12, "Hacha de mano"), ("HACHA", "Bucksel", 15, "Hacha  arrojadiza"), ("HACHA", "Mashgor", 18, "Hacha  de  doble  punta")
, ("BACULO", "Raendan", 4, "Baculo de madera"), ("BACULO", "Manddin", 6, "Mensajero de Mana"), ("BACULO", "Xadel", 10, "Raiz de Oscuridad"), 
("ESPADA", "Stanto", 7, "Alfanje"), ("ESPADA", "Makwi", 10, "Espada flamigera"), ("ESPADA", "Carorhall", 14, "Bracamante");

INSERT INTO NPC_regala(Nombre_personaje, Codigo_pocion, ID_NPC, Fecha_regalo)
VALUES ("Raendan", 1, 54367, "2018-4-12 12:34:41"), ("Raendan", 2, 54367,"2018-4-12 14:32:43");

INSERT INTO Daga 
VALUES (0, "Daga de madera"), (1, "Daga de bronce"), (2, "Daga de marfil"), (3, "Daga de diamante");

INSERT INTO Compra(ID, Nombre_tienda, Nombre_personaje)
VALUES (2, "El ojo del lobo", "Makwi"), (3, "El huracan despiadado", "Carorhall");

INSERT INTO Habilidad 
VALUES ("Intelecto Arcano", 0, "Aumenta el mana", "MAGO"), ("Traslacion", 3, "Te trasladas a un radio de 30m", "MAGO"), ("Nova de Escarcha", 10, "Inflige una tormenta", "MAGO"),
("Tajo de mandoble", 0, "Tajo de mandoble bro", "GUERRERO"), ("Impacto abrumador", 3, "Coges carrerilla e impactas con el escudo", "GUERRERO"), ("Ataque en torbellino", 10, "Giras como Link en The legend of Zelda", "GUERRERO"),
("Impacto feroz", 0, "Golpeas el suelo con gran fuerza", "TANQUE"), ("Rompespaldas", 3, "Si el enemigo esta de espaldas es un 100% kill", "TANQUE"), ("Seismo", 10, "Golpeas repetidamente el suelo creando un seismo", "TANQUE");

INSERT INTO Enemigo (Tipo_rol, Cod_misionindi, Nombre_enemigo, Oro, Vida_enemigo)
VALUES ("TANQUE", 1, "Ibe", 80, 100),("TANQUE", 2, "Ry", 10,20),("TANQUE", 3, "Ulne", 100,200),("TANQUE", 4, "Fargan", 1000,2000)
, ("GUERRERO", 1, "Kruulha", 20, 100), ("GUERRERO", 2, "Rargbal", 80, 201),("GUERRERO", 3, "Aalor", 80, 230), ("GUERRERO", 4, "Golet", 800, 3301),
("MAGO", 1, "Ligos", 80, 201), ("MAGO", 2, "Bachpai", 50, 120), ("MAGO", 3, "Lira", 8, 20), ("MAGO", 4, "Hana", 800, 2201);

INSERT INTO Fabrica
VALUES ('ESPADA', "Forja de Harmek", "Makwi", "2008-7-12 13:24:53", "Cortadora Abisal", 43),('HACHA', "Forja del enano risueño", "Mashgor", "2008-7-12 03:24:23", "Destroza enanos", 20),
('BACULO', "Forja de Harmek", "Manddin", "2008-7-15 10:21:01", "Anti-espectros", 19);

INSERT INTO Escuadron(Nombre_personaje_tanque, Nombre_personaje_mago, Nombre_personaje_guerrero, Nivel_escuadron)
VALUES ("Ahkarg", "Raendan", "Stanto", 0), ("Bucksel", "Manddin", "Makwi", 2), ("Mashgor", "Xadel", "Carorhall", 4);

INSERT INTO Mision_escuadron
VALUES (1, "Dehiss"), (2, "Grifin"), (3, "Kystorm");

INSERT INTO Participa_escuadron
VALUES (1, 1), (2,2),(3,3);

INSERT INTO Porta
VALUES (0, "Ahkarg"), (0, "Raendan"), (3, "Makwi"), (1, "Mashgor"), (2, "Xadel"), (1, "Carorhall");


INSERT INTO Posee
VALUES ("ESPADA", "Makwi"), ("HACHA", "Mashgor"),("BACULO", "Manddin");


INSERT INTO Visita
VALUES ("Glider", "Ahkarg"), ("Glider", "Raendan"), ("Forgesand", "Carorhall"), ("Huntdwarf", "Xadel");
