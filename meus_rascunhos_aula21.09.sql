# passa os parametros para a procedure
# o número de argumentos TEM QUE SER igual a quantidade de parametros
CALL sp_batata_teste_1(103,'Nantes',NULL,NULL);

DROP PROCEDURE sp_batata_teste_1;

DELIMITER $$
CREATE PROCEDURE sp_batata_teste_1 (
	p_customerNumber INT,
    p_city VARCHAR(50),
    p_limitCreditIni DECIMAL(10,2),
    p_limitCreditFin DECIMAL(10,2)

/*
	# De entrada, parametro de input 
    #É O PADRÃO
    IN p_param_1 VARCHAR(10),
    # De saída, parametro de output
    OUT p_param_2 INT,
    # Os dois
    INOUT p_param_3 DATE
*/
)
BEGIN 
/*COMANDOS*/
	IF(p_city IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Parâmetro obrigatório';
	END IF;
# EXEMPLO 1: Listagem de clientes
	SELECT *
    FROM Customers
    WHERE (p_customerNumber IS NULL OR customerNumber = p_customerNumber)
		AND (city = p_city);
    
END$$
#DELIMITER FAZ ENTENDER QUE O 'BEGIN/END' FAZ PARTE DE UM ESCOPO MAIOR
DELIMITER ;

DELIMITER $$
CREATE FUNCTION sp_limit_credit_cli(
# FUNÇÕES SÓ RECEBEM PARAMETROS 'IN'
	
)
RETURNS DECIMAL(10,2) DETERMINISTIC # ou NOT DETERMINISTIC (PADRAO)

BEGIN
	DECLARE v_limitCredit DECIMAL(10,2);
    DECLARE v_nomeCliente VARCHAR(30);
    
    SELECT
		creditLimit
	INTO p_limitCredit
    FROM Customers
    WHERE (customerNumber = p_customerNumber);
    
    RETURN v_limitCredit;
END$$

DELIMITER ;



