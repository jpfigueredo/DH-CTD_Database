DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;


# Error Code: 1824.
/*
	Error Code: 1824. Failed to open the referenced table 'funcionario'
	
    Explicação:
    Esse erro acontece quando eu tento criar uma FK apontando para uma tabela ou campo que não existe
    
    Solução: 
    o campo a ser referenciado deve existir antes da FK que o referencia ser criada. No caso abaixo, basta inverter a ordem de criação das tabelas
*/
CREATE TABLE PLANO (
	nPlanoID INT PRIMARY KEY,
    nFuncionarioID INT,
    FOREIGN KEY (nFuncionarioID) REFERENCES Funcionario (nFuncionarioID)
);
CREATE TABLE FUNCIONARIO (
	nFuncionarioID INT PRIMARY KEY,
    strNome VARCHAR(20)
);

# Error Code: 1075
/*
	Error Code: 1075. Incorrect table definition; there can be only one auto column and it must be defined as a key
	
    Solução:
    criar um campo indexado (pk, fk ou unique)
    
    Explicação:
    O MYSQL não permite que um campo seja auto_increment sem que ele seja um campo indexado. Ou seja, deve ser um campo UNIQUE, PK ou FK.
    Além disso, cada tabela só pode ter um campo definido como auto_increment
    
    OBSERVAÇÃO IMPORTANTE:
    É importante destacar que não faz sentido (eu pelo menos não consegui pensar numa situação prática onde isso possa fazer sentido) criar uma FK como sendo auto_increment. 
    A razão é bem óbvia: facilmente a constraint de foreign key será violada. Veja o exemplo abaixo:
    
    EX.:
	create table t1 (codigo int primary key); 
	create table t2 (codigot2 int primary key, codigot1 int auto_increment, foreign key (codigot1) references t1 (codigo));
	insert into t1 values (1), (2), (3);
	insert into t2 (codigot2) values (20);
	insert into t2 (codigot2) values (21);
	insert into t2 (codigot2) values (22);
	insert into t2 (codigot2) values (23);  -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`errossql`.`t2`, CONSTRAINT `t2_ibfk_1` FOREIGN KEY (`codigot1`) REFERENCES `t1` (`codigo`))   
*/

DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	/* Não há PK definida */
	nFuncionarioID INT AUTO_INCREMENT,
    strNome VARCHAR(20)
);

#Error Code: 1822.
/*
	Error Code: 1822. Failed to add the foreign key constraint. Missing index for constraint 'plano_ibfk_1' in the referenced table 'funcionario'
    
    Explicação:
    Não é possível referenciar um campo que não seja indexado. Ou seja, não é permitido criar uma FK sem que esta aponte para um campo indexado, que deve ser PK ou UNIQUE.
        
    Solução:
    criar uma PK ou UNIQUE na tabela a ser referenciada pela FK.
*/
DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	/* Não há PK definida */
	nFuncionarioID INT,
    strNome VARCHAR(20)
);
CREATE TABLE PLANO (
	nPlanoID INT PRIMARY KEY,
    nFuncionarioID INT,
    FOREIGN KEY (nFuncionarioID) REFERENCES Funcionario (nFuncionarioID)
);


#Error Code: 1364.
/*
	Error Code: 1364. Field 'nFuncionarioID' doesn't have a default value
    
    Explicação:
    não é possível usar DEFAULT (veja a instrução INSERT) sendo que o campo não possui um valor default para ser usado.alter
    
    Solução:
    definir o campo como tendo um valor default, seja auto_increment ou não;
    
    Exemplo:
    CREATE TABLE T1 
    (
		nCodigo int primary key auto_increment, -- o default é o auto incremento que o próprio banco de dados gera
        strSexo char(1) default 'm'
	);
    insert into T1 values (default, default);
    select * from t1;
*/
DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	nFuncionarioID INT PRIMARY KEY,
    strNome VARCHAR(20)
);

INSERT INTO Funcionario (nFuncionarioID, strNome)
VALUES (DEFAULT, 'Daniel');


#Error Code: 3730.
/*
	Error Code: 3730. Cannot drop table 'funcionario' referenced by a foreign key constraint 'plano_ibfk_1' on table 'plano'.
    
    Explicação:
    não é possível excluir uma tabela sem que antes a tabela ou o campo ou a constraint que a referencia seja apagada. 
    No exemplo abaixo há quatro opções:
    1. Apagar a tabela plano (opção menos recomendada);
    2. Apagar a coluna nFuncionarioID da tabela plano (isso também apagaria a constraint)
    3. Apagar a constraint 'FK_PLANO'
    4. Desabilitar a verificação de constraints. Utilize o comando SET FOREIGN_KEY_CHECKS = 0 e apague a tabela funcionario. (também não recomendo essa opção).
*/
DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	/* Não há PK definida */
	nFuncionarioID INT PRIMARY KEY,
    strNome VARCHAR(20)
);

CREATE TABLE PLANO (
	nPlanoID INT PRIMARY KEY,
    nFuncionarioID INT,
    CONSTRAINT FK_PLANO FOREIGN KEY (nFuncionarioID) REFERENCES Funcionario (nFuncionarioID)
);

DROP TABLE FUNCIONARIO;


# Error Code: 1136.
/*
	Error Code: 1136. Column count doesn't match value count at row 1
	
    Explicação:
    estou informando na cláusula VALUES mais valores do que solicitado no INSERT INTO. No INSERT INTO eu "peço" apenas nFuncionarioID e strNome.
    Contudo, no VALUES eu informo default, um nome e uma string qualquer. A situação poderia ser ao contrário também:
    INSERT INTO Funcionario (strNome) VALUES (default, 'Daniel') -- "peço" um campo (strNome), mas informo dois (default e 'Daniel')
*/

DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	/* Não há PK definida */
	nFuncionarioID INT PRIMARY KEY,
    strNome VARCHAR(20)
);

INSERT INTO Funcionario (nFuncionarioID, strNome) VALUES (default, 'Daniel', 'nao_existe_coluna_pra_isso');


# Error Code: 1451.
/*
	Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`errossql`.`plano`, CONSTRAINT `plano_ibfk_1` FOREIGN KEY (`nFuncionarioID`) REFERENCES `funcionario` (`nFuncionarioID`))
	
    Explicação:
    Tentar excluir um registro 'pai' sem que os registros 'filhos' tenham sido removidos não é permitido.    
    
    Solução:
    primeiro deve-se deletar os registros filhos para só depois deletar o registro pai. Ou então, deve-se definir a constraint da tabela filha como sendo ON DELETE CASCADE.
    Assim, ao deletar o registro pai vai acontecer um efeito cascata, deletando, assim, todos os registros filhos.
    
    OBS.: É importante lembrar que a opção de DELETE CASCADE deve ser usada com moderação e cautela.
    
    Ex.: acrescente ON DELETE CASCADE ao final da criação da FK
    FOREIGN KEY (nFuncionarioID) REFERENCES Funcionario (nFuncionarioID) ON DELETE CASCADE
*/

DROP SCHEMA IF EXISTS ERROSSQL;
CREATE SCHEMA IF NOT EXISTS ERROSSQL;
USE ERROSSQL;

CREATE TABLE FUNCIONARIO (
	nFuncionarioID INT PRIMARY KEY AUTO_INCREMENT,
    strNome VARCHAR(20)
);
CREATE TABLE PLANO (
	nPlanoID INT PRIMARY KEY AUTO_INCREMENT,
    nFuncionarioID INT,
    FOREIGN KEY (nFuncionarioID) REFERENCES Funcionario (nFuncionarioID)
);

INSERT INTO Funcionario VALUES (default, 'daniel'), (default, 'sangelo'), (default, 'passos');
INSERT INTO Plano VALUES(default, 1), (default, 1), (default, 2), (default,3);

DELETE FROM Funcionario WHERE nFuncionarioID = 1;