select * from faturas;
-- 1
select 
	max(valor_total) as maior_fatura
from faturas
where cidade_cobranca = 'Oslo';

-- 2
select 
	min(valor_total) as menor_fatura
from faturas;

-- 3
select 
	avg(valor_total) as media,
    count(*) as qt_faturas # questão 4
from faturas
where pais_cobranca = 'Canada';

-- 4
select
    count(*) as qt_faturas
from faturas
where pais_cobranca = 'Canada';

-- 5
select
    sum(valor_total) as qt_faturas
from faturas;

-- 6
select
	id,
    data_fatura,
    valor_total
from faturas
where valor_total < (select avg(valor_total) from faturas)
order by valor_total desc;

-- 7
select
	max(data_nascimento) as mais_jovem
from empregados;

-- 8
select
	min(data_nascimento) as mais_jovem
from empregados;

-- 9
select
	id,
    nome,
    sobrenome,
    DATE_FORMAT(data_nascimento, '%d %M %Y') as data_formatada
from empregados;

-- 10
select
	count(*) as qt_cancoes
from cancoes
where compositor = 'AC/DC';

-- 11
select
	avg(duracao_milisegundos) as duracao_media_ms
from cancoes;

-- 12
select
	avg(bytes) as tam_medio
from cancoes
where compositor = 'AC/DC';

#13 - Quantidade de clientes que moram na cidade de “São Paulo”(COUNT)
select
	count(*) as qtd_paulistano
from clientes
where cidade = 'São Paulo';

#14 - Quantidade de clientes que moram na cidade “Paris” (COUNT)
select
	count(*) as qtd_paris
from clientes
where cidade = 'Paris';

#15 - Quantidade de clientes que tenham email do “yahoo” (COUNT e LIKE)
select
	count(*) as qt_yahoorianos
from clientes
where email like '%@yahoo%';