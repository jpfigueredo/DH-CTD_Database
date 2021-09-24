DROP DATABASE IF EXISTS DH_Check_Point_II;
CREATE SCHEMA IF NOT EXISTS DH_Check_Point_II DEFAULT CHARACTER SET utf8;
USE DH_Check_Point_II;

CREATE TABLE tipo(
	id_tipo INT AUTO_INCREMENT UNIQUE NOT NULL,
    tipo_nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_tipo)
);
CREATE TABLE autor(
	id_autor INT AUTO_INCREMENT UNIQUE NOT NULL,
    autor_nome VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_autor)
);
CREATE TABLE editora(
	id_editora INT AUTO_INCREMENT UNIQUE NOT NULL,
    editora_nome VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_editora)
);

CREATE TABLE cliente(
	id_cliente INT AUTO_INCREMENT UNIQUE NOT NULL,
    cliente_nome VARCHAR(150) NOT NULL,
    cliente_email VARCHAR(50),
    cliente_telefone VARCHAR(50),
	cliente_CPF INT(11),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE livro(
	id_livro INT AUTO_INCREMENT UNIQUE NOT NULL,
    livro_titulo VARCHAR(40) NOT NULL,
    livro_edicao INT NOT NULL,
    isbn INT NOT NULL,
    CDD INT NOT NULL,
    id_livro_editora INT(11),
	id_livro_cliente INT(11),
    PRIMARY KEY (id_livro),
    FOREIGN KEY (id_livro_editora) REFERENCES editora(id_editora),
	FOREIGN KEY (id_livro_cliente) REFERENCES cliente(id_cliente)
);
CREATE TABLE livro_autor(
	id_livro_autor INT AUTO_INCREMENT UNIQUE NOT NULL,
    livro INT NOT NULL,
    autor INT NOT NULL,
    PRIMARY KEY (id_livro_autor),
	FOREIGN KEY(livro) REFERENCES livro(id_livro),
    FOREIGN KEY(autor) REFERENCES autor(id_autor)
);
CREATE TABLE livro_tipo(

	id_livro_tipo INT AUTO_INCREMENT UNIQUE NOT NULL,
    livro INT NOT NULL,
    tipo INT NOT NULL,
	PRIMARY KEY (id_livro_tipo),
	FOREIGN KEY(livro) REFERENCES livro(id_livro),
    FOREIGN KEY(tipo) REFERENCES tipo(id_tipo)
);

-- Inserção de dados em uma das tabelas.
-- dumping data for cliente
INSERT INTO cliente (id_cliente, cliente_nome, cliente_email, cliente_telefone, cliente_CPF) VALUES 
	(1,'Leticia','batatinha@yeahmail.com', '9 123456789', NULL),
	(2,'Felipe','felipe@feli.pe', '9 22334455', NULL),
	(3,'Bernardo','nardin@nardao.com',NULL,NULL),
	(4,'Patricia',NULL,'192',NULL),
	(5,'Julio','chatonildo@verne.com.br','01010101',NULL),
	(6,'Mao','ticétinho@gmail.com',NULL, NULL),
	(7,'Guilherme','guibazuka123@lulmail.com','11540530',NULL),
	(8,'Nelson','nelsin@email.com','9 30103814',NULL),
    (9,'Leticia','batatinha@yeahmail.com', '9 123456789', NULL),
	(10,'Felipe','felipe@feli.pe', '9 22334455', NULL),
	(11,'Bernardo','nardin@nardao.com',NULL,NULL),
	(12,'Patricia',NULL,'192',NULL),
	(13,'Julio','chatonildo@verne.com.br','01010101',NULL),
	(14,'Mao','ticétinho@gmail.com',NULL, NULL),
	(15,'Guilherme','guibazuka123@lulmail.com','11540530',NULL),
	(16,'Nelson','nelsin@email.com','9 30103814',NULL);
    
INSERT INTO livro (id_livro, livro_titulo, livro_edicao, isbn, CDD) VALUES 
	(1,'Leticia - O amor da minha vida','1', 0123456789, 123),
	(2,'Harry Potter','8', 9876543210, 125),
	(3,'Jogos Vorazes','3', 1237894560, 777),
	(4,'5 Minutos','5', 3214598701, 263),
    (5,'A volta dos que não foram','7', 3214569870, 764),
	(6,'Game of Thrones','10', 1236547897, 156),
	(7,'Game on','4', 7778889994, 565),
	(8,'Studying saves your life','2', 7418502369, 131);

INSERT INTO tipo (id_tipo, tipo_nome) VALUES 
	(1,'Romance'),
	(2,'Drama'),
	(3,'Suspense'),
	(4,'Ação'),
	(5,'Terror');

INSERT INTO autor (id_autor, autor_nome) VALUES 
	(1,'Leticia'),
	(2,'Frank'),
	(3,'Smith'),
	(4,'Hariel'),
	(5,'Baco');
INSERT INTO editora (id_editora, editora_nome) VALUES 
	(1,'Roco'),
	(2,'Intrinsicu'),
	(3,'Lado Negro'),
	(4,'Lanterna'),
	(5,'Maio');

-- Atualização de dados em uma das tabelas.
UPDATE autor
SET autor_nome = 'Larissa'
WHERE id_autor = 2;

UPDATE editora
SET editora_nome = 'Soma'
WHERE id_editora = 4;
/*
UPDATE cliente
SET cliente_CPF = 21234567891
WHERE cliente_CPF <> 0;
*/

-- Exclusão de dados em uma das tabelas.
DELETE FROM cliente
WHERE length(cliente_telefone) < 8;

DELETE FROM cliente
WHERE id_cliente = 5;

-- Seleção de dados de uma das tabelas.
SELECT * FROM livro
WHERE livro_edicao <= 10 
ORDER BY id_livro ASC
LIMIT 5;

SELECT COUNT(*)
FROM livro
WHERE id_livro > 0;

SELECT id_livro AS 'Livro ID', livro_titulo AS 'Titulo'
FROM livro
WHERE id_livro BETWEEN 1 AND 10;