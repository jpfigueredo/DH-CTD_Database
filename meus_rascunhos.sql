/*
CREATE
	SCHEMA ['NOME DO BANCO (BANCO = SCHEMA)'] DEFAULT CHARACTER SET ['utf8'];
	TABLE ['NOME DA TABELA'];
DROP
	DATABASE [Nome do Banco de Dados];
	TABLE [Nome da Tabela];
ALTER
	DATABASE [Nome do Banco de Dados];
	TABLE [Nome da Tabela];
*/

/*
ALTER TABLE Cliente
RENAME TO cliente;

	ADD [novaColuna] [VARCHAR(50), ou whatever]
	MODIFY [novaColuna] [VARCHAR(50), ou whatever]
    DROP [novaColuna]
    
*/

CREATE SCHEMA banco_teste DEFAULT CHARACTER SET utf8;
DROP DATABASE IF EXISTS banco_teste;
USE banco_teste;

CREATE TABLE cliente(
	idCliente INT NOT NULL UNIQUE AUTO_INCREMENT,
    nomeCliente VARCHAR(100) NOT NULL,
    emailCliente VARCHAR(50) NOT NULL UNIQUE,
    telefoneCliente INT(11),
    CPF INT(11) NOT NULL UNIQUE,
    PRIMARY KEY (idCliente)
);

/*
INSERT = inserir
DELETE = excluir
	DELETE FROM nome_tabela WHERE condicao;
UPDATE = modificar
SELECT = consulta a tabela 
	# Se quiser trazer informações específicas tens que selecioná-las
	Ex:
		SELECT [Colunas da Tabela] FROM [tabela]
		SELECT nome, preco, produto FROM produto;
        
        

*/

INSERT INTO banco_teste.cliente (nomeCliente, emailCliente, telefoneCliente, CPF) # NA ORDEM
VALUES('Letícia Vasconcellos', 'lelezinhaMeuAmor@email.com', 21988887777, 12365478900);

UPDATE 
	banco_teste.cliente 
SET 
	telefoneCliente = 21988887777, 
	CPF = 12365478900
WHERE 
	idCliente = 1 ;

DELETE FROM banco_teste.cliente WHERE id = 1;

SELECT * FROM cliente;

/*
CREATE TABLE ordens(
	ordem_id INT NOT NULL,
    ordem_numero INT NOT NULL,
    cliente_id INT,
    PRIMARY KEY (ordem_id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
*/

SELECT * FROM cliente
WHERE
	idCliente >= 1 AND CPF <> 12345678901
#ASC = Do A ao Z
ORDER BY nomeCliente ASC;

/*
SELECT * FROM movies 
WHERE 
	rating > 5 
ORDER BY 
	rating
*/

/*
OPERADORES
	=    >    >=    <    <=    <>    !=    IS NULL    BETWEEN    IN    LIKE
*/

/* exemplos
SELECT nome, sobrenome
FROM clientes
WHERE pais <> 'Brasil'
AND id != 15
OR id = 6
ORDER BY nome DESC
;
*/

CREATE TABLE pacientes(
	pacienteID INT(11) AUTO_INCREMENT UNIQUE NOT NULL,
    paciente_ID_Saude INT(11),
    paciente_nome VARCHAR(50),
    paciente_sobrenome VARCHAR(50),
	consultaPaciente DATETIME,
    PRIMARY KEY (pacienteID)
);

CREATE  TABLE especialidade(
	especialidadeID INT AUTO_INCREMENT UNIQUE NOT NULL,
	especialidade_nome VARCHAR(100),
    PRIMARY KEY (especialidadeID)
);

CREATE TABLE medico(
	medicoID INT AUTO_INCREMENT UNIQUE NOT NULL,
    medico_nome VARCHAR(40),
    medico_sobrenome VARCHAR(100),
    medico_especialidade INT(11),
    PRIMARY KEY (medicoID),
    FOREIGN KEY (medico_especialidade) REFERENCES especialidadeID
);

CREATE TABLE agendamentoConsulta(
	consultaID INT(11) AUTO_INCREMENT UNIQUE NOT NULL,
    paciente INT(11),
    medico INT(11),
    data_consulta DATE,
    hora_consulta TIME,
    PRIMARY KEY (consultaID),
    FOREIGN KEY(pacienteID) REFERENCES paciente,
    FOREIGN KEY(medicoID) REFERENCES medico
);

/*
DROP DATABASE IF EXISTS DH_Consultorio_Medico;
CREATE SCHEMA IF NOT EXISTS DH_Consultorio_Medico DEFAULT CHARACTER SET utf8;
USE DH_Consultorio_Medico;

CREATE TABLE paciente(
	pacienteID INT(11) AUTO_INCREMENT UNIQUE NOT NULL,
    paciente_ID_Saude INT(11),
    paciente_nome VARCHAR(50),
    paciente_sobrenome VARCHAR(50),
	consultaPaciente DATETIME,
    PRIMARY KEY (pacienteID)
);

CREATE  TABLE especialidade(
	especialidadeID INT AUTO_INCREMENT UNIQUE NOT NULL,
	especialidade_nome VARCHAR(100),
    PRIMARY KEY (especialidadeID)
);

CREATE TABLE medico(
	medicoID INT AUTO_INCREMENT UNIQUE NOT NULL,
    medico_nome VARCHAR(40),
    medico_sobrenome VARCHAR(100),
    medico_especialidade INT(11),
    PRIMARY KEY (medicoID),
    FOREIGN KEY (medico_especialidade) REFERENCES especialidade(especialidadeID)
);

CREATE TABLE agendamentoConsulta(
	consultaID INT(11) AUTO_INCREMENT UNIQUE NOT NULL,
    paciente INT(11),
    medico INT(11),
    data_consulta DATE,
    hora_consulta TIME,
    PRIMARY KEY (consultaID),
    FOREIGN KEY(paciente) REFERENCES paciente(pacienteID),
    FOREIGN KEY(medico) REFERENCES medico(medicoID)
);

ALTER TABLE pacientes
RENAME TO paciente;

# insert blablabla

*/
/*
# variavel do SQL
SET @receita = 'receitaFilial';
*/






