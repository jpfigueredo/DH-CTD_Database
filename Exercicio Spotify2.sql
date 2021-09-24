USE projeto_spotify;

#2.Liste as cancao que possuem a letra "z" no título.
SELECT titulo
FROM cancao
WHERE titulo LIKE '%z%';

#3.Liste as cancao que têm a letra "a" como segundo caractere e a letra "s" como último caractere.
SELECT titulo
FROM cancao
WHERE titulo LIKE '_a%s';

#4.Mostre a lista de reprodução que contém mais cancoes, renomeando as colunas, colocando em maiúscula a primeira letra, os acentos correspondentes e adicionando os espaços entre as palavras.
SELECT qtdcancoes
FROM playlist
WHERE 
ORDER BY DESC;


SELECT 	titulo AS Título,
		idusuario AS `Id Usuário`,
        qtdCancoes AS `Qtd Canções`,
        Datacriacao AS `Data Criação`,
        Dataexclusao AS `Data Exclusão`
FROM playlist
ORDER BY qtdCancoes DESC
LIMIT 1;


#5.Em outro momento, obtenha uma lista com os 5 usuários mais jovens, a partir dos próximos 10 registros.
SELECT Nomeusuario
FROM usuario
ORDER BY Data_nac DESC
LIMIT 5
OFFSET 4;

#6.Liste as 5 músicas com mais reproduções, em ordem decrescente.
SELECT titulo
FROM cancao
ORDER BY qtdreproducao DESC
LIMIT 5;

#7.Gere um relatório de todos os álbuns em ordem alfabética.

#8.Liste todos os álbuns que não possuem imagem, organizados em ordem alfabética.

#9.Insira um novo usuário com os seguintes dados (leve em consideração os relacionamentos):
	#nomeusuario: novousuariodespotify@gmail.com
	#Nome e sobrenome: Elmer Santos 
	#password: S4321m
	#Data de nacimiento: 15/11/1991
	#Sexo: Masculino
	#Código Postal: B4129ATF
	#País: Brasil
    
#10.  Exclua todas as músicas do gênero "pop".

#11.   Edite todos os artistas que não possuem uma imagem carregada e carregue para eles o texto "Imagem em falta" na coluna de imagens.
