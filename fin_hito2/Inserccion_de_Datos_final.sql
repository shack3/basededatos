
INSERT INTO Ciudad  (Nombre_ciudad)
VALUES ("Glider"), ("Forgesand"), ("Hiltore"), ("Gazegreenelven"),("Greenbat"), ("Huntdwarf");

INSERT INTO Tienda
VALUES ("Tienda de el ojo del lobo", "Glider"), ("Tienda de el huracan despiadado", "Forgesand"), ("Tienda Bazar", "Hiltore"), ("Tienda de ogros", "Gazegreenelven"), ("Tienda de la esquina endiablada", "Greenbat"), ("Tienda de los articulos prohibidos", "Huntdwarf")
,("Tienda de Rolla", "Huntdwarf"), ("Tienda de Swithron", "Glider"), ("Tienda de Aldlas", "Forgesand");

INSERT INTO Forja(Nombre_forja, Nombre_ciudad, Arma_dispon) VALUES 
("Forja de Harmek", "Glider", "ESPADA"), 
("Forja del enano risueño", "Glider", "ESPADA"), 
("Forja de Tebez", "Glider", "BACULO"),
("Forja del enano risueño", "Forgesand", "HACHA"), 
("Forja de Tebez", "Hiltore", "BACULO");


INSERT INTO Rol (Tipo_rol, Fuerza, Vida_personaje, Mana)
VALUES ("MAGO", 12, 200, 100), ("GUERRERO", 20, 400, 50), ("TANQUE", 40, 800, 10);

INSERT INTO Pocion VALUES 
(0,20,50), 
(1,50,100), 
(2,100,250);

INSERT INTO Druida VALUES 
(007),
(008),
(009),
(006);

INSERT INTO Dragon (Nombre_dragon, Vida_dragon)
VALUES ("Dehiss", 1000),("Rannyexba", 1500),("Pastan", 2500),("Grifin", 3060),("Kystorm", 4800),("Ocho cabezas", 12000);

INSERT INTO Desbloquea
VALUES (1, 2),(2, 3),(3, 4),(4, 5),(5, 6);

INSERT INTO Jugador VALUES
("Breakfury"),
("Hammerpowerthunder"),
("Battlerboar"),
("Cloakbane"),
("Greyblade");

INSERT INTO Daga(Nombre_daga) VALUES 
("Daga de madera"), 
("Daga de bronce"),
("Daga de bronce"),  
("Daga de marfil"),
("Daga de marfil"), 
("Daga de diamante");


INSERT INTO Personaje VALUES 
("Raendan", 0, 20, "Guapo", "MAGO", 2, "Breakfury", 1,200), 
("Manddin", 0, 500, "Bello", "MAGO", 3, "Hammerpowerthunder", 2,200), 
("Xadel", 0, 628, "Feo", "MAGO", 4, "Greyblade", 2,200), 
("Enso", 0, 430, "Mediocre", "MAGO", 1, "Battlerboar", 3,200),
("Stanto", 0, 2000, "Alto", "GUERRERO", 3, "Cloakbane", 4,400),
("Makwi", 0, 110, "Gordo", "GUERRERO", 0, "Greyblade", 1,400), 
("Carorhall", 0, 900, "Reluciente", "GUERRERO", 4, "Breakfury", 4,400), 
("Dryto", 0, 1345, "Poderoso", "GUERRERO", 1, "Hammerpowerthunder", 3,400),
("Ahkarg", 0, 1625, "Especialista", "TANQUE", 0, "Battlerboar", 1,800),
("Bucksel", 0, 829, "Armario", "TANQUE", 6, "Cloakbane", 2,800),
("Mashgor", 0, 35, "Bajo", "TANQUE", 2, "Greyblade", 3,800), 
("Gim", 0, 78, "Elfo", "TANQUE", 5, "Breakfury", 4,800);

INSERT INTO Mision_indi (Nombre_personaje) VALUES 
("Raendan"), 
("Ahkarg"), 
("Bucksel"), 
("Manddin"),
("Carorhall");

INSERT INTO Arma
VALUES ("HACHA", "Ahkarg", 12, "Hacha de mano"), ("HACHA", "Bucksel", 15, "Hacha  arrojadiza"), ("HACHA", "Mashgor", 18, "Hacha  de  doble  punta")
, ("BACULO", "Raendan", 4, "Baculo de madera"), ("BACULO", "Manddin", 6, "Mensajero de Mana"), ("BACULO", "Xadel", 10, "Raiz de Oscuridad"), 
("ESPADA", "Stanto", 7, "Alfanje"), ("ESPADA", "Makwi", 10, "Espada flamigera"), ("ESPADA", "Carorhall", 14, "Bracamante");


INSERT INTO NPC_regala(Nombre_personaje, Codigo_pocion, ID_NPC, Fecha_regalo) VALUES 
("Stanto", 0, 007, "2018-4-12 12:34:41"), 
("Stanto", 1, 008, "2018-4-12 12:34:41"), 
("Stanto", 1, 009, "2018-4-12 12:34:41"), 
("Stanto", 2, 006,"2018-4-12 14:32:43"),
("Carorhall", 1, 006,"2018-4-12 14:32:43"),
("Bucksel", 0, 006,"2018-4-12 14:32:43");


INSERT INTO Compra(ID_daga, Nombre_tienda, Nombre_personaje) VALUES 
(2, "Tienda de el ojo del lobo", "Makwi"), 
(4, "Tienda de el huracan despiadado", "Carorhall"),
(1, "Tienda de el ojo del lobo", "Xadel"), 
(3, "Tienda de el ojo del lobo", "Xadel"), 
(5, "Tienda de el ojo del lobo", "Xadel"), 
(6, "Tienda de el ojo del lobo", "Xadel"),
(3, "Tienda de Rolla", "Stanto"),
(4, "Tienda de Rolla", "Enso"),
(4, "Tienda de Rolla", "Dryto");

INSERT INTO Habilidad 
VALUES ("Intelecto Arcano", 0, "Aumenta el mana", "MAGO"), ("Traslacion", 3, "Te trasladas a un radio de 30m", "MAGO"), ("Nova de Escarcha", 10, "Inflige una tormenta", "MAGO"),
("Tajo de mandoble", 0, "Tajo de mandoble bro", "GUERRERO"), ("Impacto abrumador", 3, "Coges carrerilla e impactas con el escudo", "GUERRERO"), ("Ataque en torbellino", 10, "Giras como Link en The legend of Zelda", "GUERRERO"),
("Impacto feroz", 0, "Golpeas el suelo con gran fuerza", "TANQUE"), ("Rompespaldas", 3, "Si el enemigo esta de espaldas es un 100% kill", "TANQUE"), ("Seismo", 10, "Golpeas repetidamente el suelo creando un seismo", "TANQUE");

INSERT INTO Tipo_enemigo VALUES
("ESPECTRO"),
("GOBLIN"),
("TROLL");

#################	EDITO	#########################
INSERT INTO Enemigo (Nombre_tipoene, Cod_misionindi, Nombre_enemigo, Oro, Vida_enemigo) VALUES 
("TROLL", 1, "Ibe", 80, 100),
("TROLL", 2, "Ry", 10,20),
("TROLL", 3, "Ulne", 100,200),
("TROLL", 4, "Fargan", 1000,2000), 
("GOBLIN", 1, "Kruulha", 20, 100), 
("GOBLIN", 2, "Rargbal", 80, 201),
("GOBLIN", 3, "Aalor", 80, 230), 
("GOBLIN", 4, "Goleth", 800, 3301),
("ESPECTRO", 1, "Ligos", 80, 201), 
("ESPECTRO", 2, "Bachpai", 50, 120), 
("ESPECTRO", 3, "Lira", 8, 20), 
("ESPECTRO", 4, "Ligos", 80, 201), 
("ESPECTRO", 4, "Bachpai", 50, 120), 
("ESPECTRO", 4, "Lira", 8, 20), 
("ESPECTRO", 4, "Hana", 800, 2201);

INSERT INTO Fabrica VALUES 
('ESPADA', 1, "Makwi", "2008-7-12 13:24:53", "Espada flamígera", 43),
('ESPADA', 1, "Makwi", "2008-7-12 13:24:23", "Alfanje", 43),
('ESPADA', 1, "Makwi", "2008-7-12 13:23:53", "Bracamarte", 43),
('HACHA', 2, "Gim", "2008-7-12 03:26:23", "Hacha de doble punta", 20),
('HACHA', 2, "Mashgor", "2008-7-12 03:14:23", "Hacha de doble punta", 20),
('HACHA', 4, "Mashgor", "2008-7-12 03:34:23", "Hacha de mano", 20),
('HACHA', 2, "Mashgor", "2008-7-12 03:06:23", "Hacha arrojadiza", 20),
('BACULO', 3, "Manddin", "2008-7-15 10:11:01", "Raiz de Oscuridad", 19),
('BACULO', 5, "Manddin", "2008-7-15 10:21:41", "Mensajero de Maná", 19),
('BACULO', 5, "Manddin", "2008-7-15 10:21:21", "Báculo de Madera", 19),
('BACULO', 2, "Enso", "2008-7-15 10:21:21", "Mensajero de Maná", 19),
('ESPADA', 2, "Dryto", "2008-7-15 10:21:21", "Espada flamígera", 34);


INSERT INTO Escuadron(Nombre_personaje_tanque, Nombre_personaje_mago, Nombre_personaje_guerrero, Nivel_escuadron)
VALUES ("Ahkarg", "Raendan", "Stanto", 0), ("Bucksel", "Manddin", "Makwi", 2), ("Mashgor", "Xadel", "Carorhall", 4), ("Ahkarg", "Xadel", "Makwi", 0);

INSERT INTO Mision_escuadron
VALUES (1, 1), (2, 4), (3, 5);

INSERT INTO Participa_escuadron
VALUES (1, 1), (2,2),(3,3);

###################### A TOMAR POR CULO ESTO ###########################
#INSERT INTO Porta
#VALUES (0, "Ahkarg"), (0, "Raendan"), (3, "Makwi"), (1, "Mashgor"), (2, "Xadel"), (1, "Carorhall");


INSERT INTO Posee
VALUES ("ESPADA", "Makwi"), ("HACHA", "Mashgor"),("BACULO", "Manddin");


INSERT INTO Visita
VALUES ("Glider", "Ahkarg"), ("Glider", "Raendan"), ("Forgesand", "Carorhall"), ("Huntdwarf", "Xadel");