USE emarket;
delimiter $$
CREATE FUNCTION retorna_data_ultima_fatura (
	p_codigo_vendedor INT
) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	
    DECLARE v_total_fatura_empregado DECIMAL(10,2);
    
    SELECT empregadoId
    FROM empregados
    WHERE empregadoId = p_codigo_vendedor;
    
    SELECT SUM(transporte) as total_empregado, DataNascimento
    
    # total_empregado = v_total_fatura_empregado
    # DataNascimento = v_dtNasc
    # O SQL joga tudo na ordem. 1° com 1°, 2° com 2°, e assim por diante...
    
    INTO v_total_fatura_empregado, v_dtNasc
    FROM faturas
    WHERE empregoId = p_codigo_vendedor;
    
    RETURN v_total_fatura_empregado;


END $$
delimiter ;

select * from empregados;
select * from faturas;

