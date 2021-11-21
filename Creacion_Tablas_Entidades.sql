CREATE SCHEMA Dragones_Y_Mazmorras;

USE Dragones_Y_Mazmorras;

CREATE TABLE Rol(
Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
Fuerza INTEGER NOT NULL,
Vida_personaje INTEGER NOT NULL,
Mana INTEGER NOT NULL,
CONSTRAINT PRIMARY KEY (Tipo_rol)
);

CREATE TABLE Personaje(
Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
Nivel_personaje INTEGER NOT NULL,
Oro_total INTEGER NOT NULL,
Apariencia VARCHAR(50) NOT NULL,
Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
Dragones_desbloq INTEGER NOT NULL,
PRIMARY KEY (Nombre_personaje),
CONSTRAINT FK_Tipo_rol_personaje FOREIGN KEY (Tipo_rol) REFERENCES Rol(Tipo_rol)
);

CREATE TABLE Ciudad(
	Nombre_ciudad VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_ciudad)
);

CREATE TABLE Tienda(
	Nombre_tienda VARCHAR(50) UNIQUE NOT NULL,
	Nombre_ciudad VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_tienda, Nombre_ciudad),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad)
);

CREATE TABLE Forja(
	Nombre_forja VARCHAR(50) UNIQUE NOT NULL,
	Nombre_ciudad VARCHAR(50) UNIQUE NOT NULL,
	Arma_dispon ENUM('ESPADA', 'HACHA', 'BACULO'),
	PRIMARY KEY (Nombre_forja, Nombre_ciudad),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad)
);

CREATE TABLE Daga(
ID INTEGER UNIQUE NOT NULL,
Nombre_daga VARCHAR(50) UNIQUE NOT NULL,
CONSTRAINT PRIMARY KEY (ID)
);

CREATE TABLE Porta(
	ID_Daga INTEGER UNIQUE NOT NULL,
    Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (ID_Daga, Nombre_personaje),
    CONSTRAINT FOREIGN KEY (ID_Daga) REFERENCES Daga(ID),
    CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
);

CREATE TABLE Compra(
	ID INTEGER NOT NULL,
	Nombre_tienda VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (ID, Nombre_tienda),
	CONSTRAINT FOREIGN KEY (ID) REFERENCES Daga(ID),
	CONSTRAINT FOREIGN KEY (Nombre_tienda) REFERENCES Tienda(Nombre_tienda)
);

CREATE TABLE Visita(
	Nombre_ciudad VARCHAR(50) UNIQUE NOT NULL,
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_ciudad, Nombre_personaje),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
);

CREATE TABLE Arma(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	Peso INTEGER NOT NULL,
	PRIMARY KEY (Tipo_arma, Nombre_personaje),
    CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
);

CREATE TABLE Posee(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_personaje, Tipo_arma),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje),
	CONSTRAINT FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma)
);

CREATE TABLE Fabrica(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Nombre_forja VARCHAR(50) UNIQUE NOT NULL,
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	Fecha_fabricacion DATETIME,
	Nombre VARCHAR(50) UNIQUE NOT NULL,
	Daño INTEGER NOT NULL,
	PRIMARY KEY (Tipo_arma, Nombre_forja, Nombre_personaje, Fecha_fabricacion),
	CONSTRAINT FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma),
	CONSTRAINT FOREIGN KEY (Nombre_forja) REFERENCES Forja(Nombre_forja),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
);

CREATE TABLE Mision_indi(
	Cod_misionindi INTEGER NOT NULL,
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Cod_misionindi),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
);



CREATE TABLE Enemigo(
	Cod_enemigo INTEGER NOT NULL,
	Cod_misionindi INTEGER NOT NULL,
	Nombre_enemigo VARCHAR(50) NOT NULL,
	Oro INTEGER NOT NULL,
	Vida_enemigo INTEGER NOT NULL,
	PRIMARY KEY (Cod_enemigo, Cod_misionindi),
	CONSTRAINT FOREIGN KEY (Cod_misionindi) REFERENCES Mision_indi(Cod_misionindi)
);



CREATE TABLE Habilidad(
	Nombre_habilidad VARCHAR(50) NOT NULL,
	Nivel_desbloq INTEGER NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
	Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
	PRIMARY KEY (Nombre_habilidad),
	CONSTRAINT FOREIGN KEY (Tipo_rol) REFERENCES Personaje(Tipo_rol)
);

CREATE TABLE Escuadron( # Depende de personaje pero todavia no se como hacerlo.
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL, ## ARRAY DE LOS 3 TIPOS DE PERSONAJES, NO UNO SOLO.
	Nivel_escuadron INTEGER UNIQUE NOT NULL,
	Cod_escuadron INTEGER UNIQUE NOT NULL,
	PRIMARY KEY (Cod_escuadron)
);

CREATE TABLE Dragon(
	Nombre_dragon VARCHAR(50) NOT NULL,
	Vida_dragon INTEGER NOT NULL,
	Nivel_dragon INTEGER NOT NULL, # Nivel minimo para lucharlo
	PRIMARY KEY (Nombre_dragon)
);

CREATE TABLE Mision_escuadron(
	Cod_misionesc INTEGER UNIQUE NOT NULL AUTO_INCREMENT, 
    Nombre_dragon VARCHAR(50) NOT NULL,
    PRIMARY KEY (Cod_misionesc, Nombre_dragon),
    CONSTRAINT FK_Nombre_Mision_Dragon FOREIGN KEY (Nombre_dragon) REFERENCES Dragon(Nombre_dragon)
);

CREATE TABLE Participa_escuadron(
	Cod_misionesc INTEGER UNIQUE NOT NULL,
    Cod_escuadron INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (Cod_misionesc, Cod_escuadron),
    CONSTRAINT FK_Codigo_Mision_Escuadron FOREIGN KEY (Cod_misionesc) REFERENCES Mision_escuadron(Cod_misionesc),
    CONSTRAINT FK_Codigo_Escuadron FOREIGN KEY (Cod_escuadron) REFERENCES Escuadron(Cod_escuadron)
);

CREATE TABLE Desbloquea( # Esta tabla se puede llegar a borrar dado a que los niveles minimos asociados al dragon ya pueden hacer esta relacion.
	Nombre_dragon VARCHAR(50) NOT NULL, # Dragon que has luchado
    Siguiente_dragon VARCHAR(50) NOT NULL, # Dragon que desbloqueas
    PRIMARY KEY (Nombre_dragon, Siguiente_dragon),
    CONSTRAINT FK_Nombre_Dragon_Actual FOREIGN KEY (Nombre_dragon) REFERENCES Dragon(Nombre_dragon),
    CONSTRAINT FK_Nombre_Siguiente_Dragon FOREIGN KEY (Siguiente_dragon) REFERENCES Dragon(Nombre_dragon)
);

CREATE TABLE Pocion(
	Codigo_pocion INTEGER NOT NULL,
	Vida_restaurada INTEGER NOT NULL,
	Mana_restaurada INTEGER NOT NULL,
    PRIMARY KEY (Codigo_pocion)
);

CREATE TABLE Druida(
	ID_NPC INTEGER UNIQUE NOT NULL,
	PRIMARY KEY (ID_NPC)
);

CREATE TABLE NPC_regala(
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	Codigo_pocion INTEGER NOT NULL,
	ID_NPC INTEGER UNIQUE NOT NULL,
	Fecha_regalo DATETIME,
	PRIMARY KEY (Nombre_personaje, Codigo_pocion, ID_NPC, Fecha_regalo),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje),
	CONSTRAINT FOREIGN KEY (Codigo_pocion) REFERENCES Pocion(Codigo_pocion),
	CONSTRAINT FOREIGN KEY (ID_NPC) REFERENCES Druida(ID_NPC)
);

