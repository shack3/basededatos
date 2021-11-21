
ALTER TABLE Ciudad
ADD CONSTRAINT PRIMARY KEY (Nombre_ciudad);

ALTER TABLE Tienda
ADD CONSTRAINT PRIMARY KEY (Nombre_tienda, Nombre_ciudad);

ALTER TABLE Forja
ADD CONSTRAINT PRIMARY KEY (Nombre_forja, Nombre_ciudad);

ALTER TABLE Compra
ADD CONSTRAINT PRIMARY KEY (ID, Nombre_tienda);

ALTER TABLE Visita
ADD CONSTRAINT PRIMARY KEY (Nombre_ciudad, Nombre_personaje);

ALTER TABLE Arma
ADD CONSTRAINT PRIMARY KEY (Tipo_arma, Nombre_personaje);

ALTER TABLE Posee
ADD CONSTRAINT PRIMARY KEY (Nombre_personaje, Tipo_arma);

ALTER TABLE Fabrica
ADD CONSTRAINT PRIMARY KEY (Tipo_arma, Nombre_forja, Nombre_personaje, Fecha_fabricacion);

ALTER TABLE Enemigo
ADD CONSTRAINT PRIMARY KEY (Cod_enemigo, Cod_misionindi);

ALTER TABLE Mision_indi
ADD CONSTRAINT PRIMARY KEY (Cod_misionindi);


ALTER TABLE Escuadron
ADD CONSTRAINT PRIMARY KEY (Nombre_personaje, Nivel_escuadron);

ALTER TABLE Participa_escuadron
ADD CONSTRAINT PRIMARY KEY (Nivel_escuadron); ####

ALTER TABLE Mision_escuadron
ADD CONSTRAINT PRIMARY KEY (Cod_misionesc);

ALTER TABLE Dragon
ADD CONSTRAINT PRIMARY KEY (Nombre_dragon, Cod_misionesc);

ALTER TABLE NPC_regala
ADD CONSTRAINT PRIMARY KEY (Nombre_personaje, Codigo_pocion, ID_NPC, Fecha_regalo);

ALTER TABLE Pocion
ADD CONSTRAINT PRIMARY KEY (Codigo_pocion);

ALTER TABLE Druida
ADD CONSTRAINT PRIMARY KEY (ID_NPC);

