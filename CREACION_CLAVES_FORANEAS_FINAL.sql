ALTER TABLE Personaje
ADD CONSTRAINT FK_Tipo_rol_personaje FOREIGN KEY (Tipo_rol) REFERENCES Rol(Tipo_rol);

ALTER TABLE Tienda
ADD CONSTRAINT FK_Nombre_ciudad_tienda FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad);

ALTER TABLE Compra
ADD CONSTRAINT FK_ID_compra FOREIGN KEY (ID) REFERENCES Daga(ID),
ADD CONSTRAINT FK_Nombre_tienda_compra FOREIGN KEY (Nombre_tienda) REFERENCES Tienda(Nombre_tienda);

ALTER TABLE Forja
ADD CONSTRAINT FK_Nombre_ciudad_forja FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad);

ALTER TABLE Tienda
ADD CONSTRAINT FK_Nombre_ciudad_tienda1 FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad); ##		<----????

ALTER TABLE Daga
ADD CONSTRAINT FK_Nombre_personaje_daga FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Visita
ADD CONSTRAINT FK_Nombre_ciudad_Visita FOREIGN KEY (Nombre_ciudad) REFERENCES Ciudad(Nombre_ciudad),
ADD CONSTRAINT FK_Nombre_personaje_Visita FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Arma
ADD CONSTRAINT FK_Nombre_personaje_arma FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Posee
ADD CONSTRAINT FK_Nombre_personaje_posee FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje),
ADD CONSTRAINT FK_Tipo_arma_posee FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma);

ALTER TABLE Fabrica
ADD CONSTRAINT FK_Tipo_arma_fabrica FOREIGN KEY (Tipo_arma) REFERENCES Arma(Tipo_arma),
ADD CONSTRAINT FK_Nombre_forja_fabrica FOREIGN KEY (Nombre_forja) REFERENCES Forja(Nombre_forja),
ADD CONSTRAINT FK_Nombre_personaje_fabrica FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Enemigo
ADD CONSTRAINT FK_Cod_misionindi_enemigo FOREIGN KEY (Cod_misionindi) REFERENCES Mision_indi(Cod_misionindi);

ALTER TABLE Mision_indi
ADD CONSTRAINT FK_Nombre_personaje_misionindi FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Habilidad
ADD CONSTRAINT FK_Nombre_personaje_habilidad FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje);

ALTER TABLE Dragon
ADD CONSTRAINT FK_Nombre_dragonref_dragon FOREIGN KEY (Nombre_dragonref) REFERENCES Dragon(Nombre_dragon),
ADD CONSTRAINT FK_Cod_misionesc_dragon FOREIGN KEY (Cod_misionesc) REFERENCES Mision_escuadron(Cod_misionesc);

ALTER TABLE NPC_regala
ADD CONSTRAINT FK_Nombre_personaje_NPC_regala FOREIGN KEY (Nombre_personaje) REFERENCES Personaje(Nombre_personaje),
ADD CONSTRAINT FK_Codigo_pocion_NPC_regala FOREIGN KEY (Codigo_pocion) REFERENCES Pocion(Codigo_pocion),
ADD CONSTRAINT FK_ID_NPC_NPC_regala FOREIGN KEY (ID_NPC) REFERENCES Druida(ID_NPC);

ALTER TABLE Participa_escuadron
ADD CONSTRAINT FK_Nivel_escuadron_participa_escuadron FOREIGN KEY (Nivel_escuadron) REFERENCES Escuadron(Nivel_escuadron);
