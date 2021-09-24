CREATE DATABASE IF NOT EXISTS Spotify
DEFAULT CHARSET = 'utf8mb4'
DEFAULT COLLATE = 'utf8mb4_general_ci';

USE Spotify;

CREATE TABLE IF NOT EXISTS Usuario
(
	nUsuarioID INT UNSIGNED AUTO_INCREMENT,
    strNomeDeUsuario VARCHAR(45) NULL,
    dtNascimento DATE NULL,
    strSexo CHAR(1),
    strEmail VARCHAR(150) NULL,
    strSenha VARCHAR(45),
    CONSTRAINT PK_Usuario_nUsuarioID PRIMARY KEY (nUsuarioID)
);

INSERT INTO Usuario
VALUES	(DEFAULT,'joao','1990-11-15','M','email@exemplo.com','suasenha'),
		(DEFAULT,'pedro','1992-08-14','M','email@exemplo.com','suasenha'),
		(DEFAULT,'Lelê','1997-07-22','M','email@exemplo.com','suasenha');


CREATE TABLE Artista
(
	nArtistaID INT UNSIGNED AUTO_INCREMENT,
    strNome VARCHAR(45) NULL,
    strSobrenome VARCHAR(100),
    CONSTRAINT PK_Artista_nArtistaID PRIMARY KEY (nArtistaID)
);

INSERT INTO Artista
VALUES (DEFAULT, 'Tom', 'Cat');

INSERT INTO Artista
VALUES (DEFAULT, 'Jerry', 'Mouse');

INSERT INTO Artista
VALUES (DEFAULT, 'Mary', 'Jane');

CREATE TABLE Genero
(
	nGeneroID INT UNSIGNED AUTO_INCREMENT,
    strGenero VARCHAR(45)
);

INSERT INTO Genero
VALUES	(DEFAULT, 'Pagode'),
		(DEFAULT, 'Funk'),
		(DEFAULT, 'Rap');

CREATE TABLE Playlist
(
	nPlaylistID INT UNSIGNED AUTO_INCREMENT,
    strTitulo VARCHAR(45) NULL,
    nQtdeCancoes MEDIUMINT,
    dtCriacao DATETIME,
    CONSTRAINT PK_Playlist_nPlaylistID PRIMARY KEY (nPlaylistID)
);

#Inserindo as relações, FK's
ALTER TABLE Playlist ADD COLUMN nUsuarioID INT NULL;
ALTER TABLE Playlist MODIFY COLUMN nUsuarioID INT UNSIGNED;
ALTER TABLE Playlist ADD CONSTRAINT FK_nUsuarioID_Usuario 
	FOREIGN KEY(nUsuarioID) REFERENCES Usuario (nUsuarioID);


CREATE TABLE PlaylistCancao
(
	nPlaylistCancao INT UNSIGNED AUTO_INCREMENT,
    nCancaoID INT UNSIGNED,
    nPlaylistID INT UNSIGNED,
    PRIMARY KEY (nPlaylistCancao),
    CONSTRAINT FK FOREIGN KEY (nPlaylistID)
		REFERENCES Playlist (nPlaylistID)
);

CREATE TABLE Cancao
(
	nCancaoID INT UNSIGNED AUTO_INCREMENT,
    strTitulo VARCHAR(45),
    nDuracao DOUBLE,
    nQtdeReproducao INT UNSIGNED,
    nQtdeLikes INT UNSIGNED,
    nAlbumID INT UNSIGNED,
    PRIMARY KEY (nCancaoID)
);

ALTER TABLE PlaylistCancao ADD CONSTRAINT FK_nCancaoID_Cancao FOREIGN KEY (nCancaoID)
	REFERENCES Cancao (nCancaoID);
    
CREATE TABLE Album
(
	nAlbumID INT UNSIGNED AUTO_INCREMENT,
    strTitulo VARCHAR(45),
    nArtistaID INT UNSIGNED,
    PRIMARY KEY (nAlbumID),
    CONSTRAINT FK_nArtistaID_Artista FOREIGN KEY (nArtistaID)
		REFERENCES Artista(nArtistaID)
);

ALTER TABLE Cancao 
ADD CONSTRAINT FK_nAlbumID_Cancao FOREIGN KEY (nAlbumID)
	REFERENCES Album (nAlbumID);
    
CREATE TABLE GeneroCancao
(
	nGeneroCancaoID INT UNSIGNED AUTO_INCREMENT,
    nCancaoID INT UNSIGNED,
    nGeneroID INT UNSIGNED,
    CONSTRAINT PK_nGeneroCancaoID PRIMARY KEY (nGeneroCancaoID),
    CONSTRAINT FK_nCancaoID_Cancao FOREIGN KEY (nCancaoID)
		REFERENCES Cancao (nCancaoID) ,
	FOREIGN KEY (nGeneroID)
		REFERENCES Genero (nGeneroID)
);