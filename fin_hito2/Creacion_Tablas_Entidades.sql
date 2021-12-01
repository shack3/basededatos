DROP SCHEMA IF EXISTS Dragones_Y_Mazmorras;
CREATE SCHEMA IF NOT EXISTS Dragones_Y_Mazmorras;

USE Dragones_Y_Mazmorras;

CREATE TABLE Rol(
Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
Fuerza INTEGER NOT NULL,
Vida_personaje INTEGER NOT NULL,
Mana INTEGER NOT NULL,
CONSTRAINT PRIMARY KEY (Tipo_rol)
);

#quitar en el git
CREATE TABLE Jugador(
Nombre_jugador VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (Nombre_jugador)
);

######################	EDITO	#############
CREATE TABLE Daga(
ID_daga INTEGER NOT NULL AUTO_INCREMENT,
Nombre_daga VARCHAR(50) NOT NULL,
CONSTRAINT PRIMARY KEY (ID_daga)
);


#Añado a personaje la clave de jugador (Un jugador puede crear varios personajes, pero un personaje es solo de un jugador)
CREATE TABLE Personaje(
Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
Nivel_personaje INTEGER NOT NULL,
Oro_total INTEGER NOT NULL,
Apariencia VARCHAR(50) NOT NULL,
Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
Dragones_desbloq INTEGER NOT NULL,
Nombre_jugador VARCHAR(50) NOT NULL,
ID_daga INTEGER NOT NULL,
Vida_personaje INTEGER NOT NULL,
PRIMARY KEY (Nombre_personaje),
CONSTRAINT FK_Tipo_rol_personaje FOREIGN KEY (Tipo_rol) REFERENCES Rol(Tipo_rol)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_Nombre_jugador_personaje FOREIGN KEY (Nombre_jugador) REFERENCES Jugador(Nombre_jugador)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT FK_ID_daga_personaje FOREIGN KEY (ID_daga) REFERENCES Daga(ID_daga)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Ciudad(
	Nombre_ciudad VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_ciudad)
);

CREATE TABLE Tienda(
	Nombre_tienda VARCHAR(50) UNIQUE NOT NULL,
	Nombre_ciudad VARCHAR(50) NOT NULL,
	PRIMARY KEY (Nombre_tienda, Nombre_ciudad),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Forja(
	Id_forja INTEGER NOT NULL AUTO_INCREMENT,
	Nombre_forja VARCHAR(50) NOT NULL,
	Nombre_ciudad VARCHAR(50) NOT NULL,
	Arma_dispon ENUM('ESPADA', 'HACHA', 'BACULO'),
	PRIMARY KEY (Id_forja, Nombre_ciudad),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

##################### EDITO ########################
CREATE TABLE Compra(
	ID_daga INTEGER NOT NULL,
	Nombre_tienda VARCHAR(50) NOT NULL,
    Nombre_personaje VARCHAR(50) NOT NULL,
    Codigo_transaccion INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (Codigo_transaccion),
	CONSTRAINT FOREIGN KEY (ID_daga) REFERENCES Daga(ID_daga)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Nombre_tienda) REFERENCES Tienda(Nombre_tienda)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
    CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Visita(
	Nombre_ciudad VARCHAR(50) NOT NULL,
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_ciudad, Nombre_personaje),
	CONSTRAINT FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Arma(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	Peso INTEGER NOT NULL,
    Nombre VARCHAR(30) NOT NULL,
	PRIMARY KEY (Tipo_arma, Nombre_personaje),
    CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Posee(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Nombre_personaje VARCHAR(50) UNIQUE NOT NULL,
	PRIMARY KEY (Nombre_personaje, Tipo_arma),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Fabrica(
	Tipo_arma ENUM('ESPADA', 'HACHA', 'BACULO'),
	Id_forja INTEGER NOT NULL,
	Nombre_personaje VARCHAR(50) NOT NULL,
	Fecha_fabricacion DATETIME,
	Nombre VARCHAR(50) NOT NULL,
	Daño INTEGER NOT NULL,
	#PRIMARY KEY (Tipo_arma, Id_forja, Nombre_personaje),
	CONSTRAINT FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Id_forja) REFERENCES Forja(Id_forja)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Mision_indi(
	Cod_misionindi INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
	Nombre_personaje VARCHAR(50) NOT NULL,
	PRIMARY KEY (Cod_misionindi),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE Tipo_enemigo(
Nombre_tipoene ENUM ('ESPECTRO', 'GOBLIN', 'TROLL'),
PRIMARY KEY (Nombre_tipoene)
);

################	 edito	################
CREATE TABLE Enemigo(
	Cod_enemigo INTEGER NOT NULL AUTO_INCREMENT,
	Cod_misionindi INTEGER NOT NULL,
	Nombre_enemigo VARCHAR(50) NOT NULL,
	Oro INTEGER NOT NULL,
	Vida_enemigo INTEGER NOT NULL,
    Nombre_tipoene ENUM('ESPECTRO', 'GOBLIN', 'TROLL'),
    PRIMARY KEY (Cod_enemigo, Cod_misionindi),
	CONSTRAINT FOREIGN KEY (Cod_misionindi) REFERENCES Mision_indi(Cod_misionindi)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_Nombre_tipoene_Enemigo FOREIGN KEY (Nombre_tipoene) REFERENCES Tipo_enemigo(Nombre_tipoene)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);



CREATE TABLE Habilidad(
	Nombre_habilidad VARCHAR(50) NOT NULL,
	Nivel_desbloq INTEGER NOT NULL,
	Descripcion VARCHAR(50) NOT NULL,
	Tipo_rol ENUM('MAGO', 'GUERRERO', 'TANQUE'),
	PRIMARY KEY (Nombre_habilidad),
	CONSTRAINT FOREIGN KEY (Tipo_rol) REFERENCES Personaje(Tipo_rol)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Escuadron( #Meter trigger para que el personaje en si no sea distinto a la casilla que le corresponde.
	Nombre_personaje_tanque VARCHAR(50)  NOT NULL, 
    Nombre_personaje_mago VARCHAR(50)  NOT NULL,
    Nombre_personaje_guerrero VARCHAR(50)  NOT NULL,
	Nivel_escuadron INTEGER NOT NULL, #<----- DEBE DE CREARSE CON LA MEDIA DE LOS 3 PERSONAJES. Otro trigger.
	Cod_escuadron INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (Cod_escuadron),
    CONSTRAINT FOREIGN KEY (Nombre_personaje_tanque) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (Nombre_personaje_mago) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (Nombre_personaje_guerrero) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Dragon(
	Num_dragon INTEGER NOT NULL AUTO_INCREMENT,
	Nombre_dragon VARCHAR(50) NOT NULL,
	Vida_dragon INTEGER NOT NULL,
	
	PRIMARY KEY (Num_Dragon)
);

CREATE TABLE Mision_escuadron(
	Cod_mision INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
    Num_dragon INTEGER NOT NULL ,
    PRIMARY KEY (Cod_mision, Num_dragon),
    CONSTRAINT FOREIGN KEY (Num_dragon) REFERENCES Dragon(Num_dragon)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Participa_escuadron( #Junta escuadrones con misiones.
	Cod_mision INTEGER UNIQUE NOT NULL,
    Cod_escuadron INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (Cod_mision, Cod_escuadron),
    CONSTRAINT FOREIGN KEY (Cod_mision) REFERENCES Mision_escuadron(Cod_mision)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (Cod_escuadron) REFERENCES Escuadron(Cod_escuadron)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Desbloquea( # Esta tabla se puede llegar a borrar dado a que los niveles minimos asociados al dragon ya pueden hacer esta relacion.
	Num_dragon INTEGER NOT NULL AUTO_INCREMENT,
    Siguiente_dragon INTEGER NOT NULL, # Dragon que desbloqueas
    PRIMARY KEY (Num_dragon, Siguiente_dragon),
    CONSTRAINT FK_ID_Dragon FOREIGN KEY (Num_dragon) REFERENCES Dragon(Num_dragon)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_Nombre_Siguiente_Dragon FOREIGN KEY (Siguiente_dragon) REFERENCES Dragon(Num_dragon)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Pocion(
	Codigo_pocion INTEGER NOT NULL,
	Vida_restaurada INTEGER NOT NULL,
	Mana_restaurada INTEGER NOT NULL,
    PRIMARY KEY (Codigo_pocion)
);

CREATE TABLE Druida(
	ID_NPC INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (ID_NPC)
);

CREATE TABLE NPC_regala(
	Nombre_personaje VARCHAR(50) NOT NULL,
	Codigo_pocion INTEGER NOT NULL,
	ID_NPC INTEGER NOT NULL,
	Fecha_regalo DATETIME,
    Codigo_Transferencia INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (Codigo_Transferencia),
	CONSTRAINT FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (Codigo_pocion) REFERENCES Pocion(Codigo_pocion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY (ID_NPC) REFERENCES Druida(ID_NPC)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);