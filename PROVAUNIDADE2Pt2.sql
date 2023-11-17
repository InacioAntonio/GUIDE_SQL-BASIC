--NOME:INÀCIO ANTONIO DE SOUZA GARCIA E FELLIPE PATRICK LIMA DE BRITO

Create table IF NOT EXISTS fazenda(
id_fazenda SERIAL PRIMARY KEY,
nome_fazenda text NOT NULL,
area_total float NOT NULL
);
CREATE TABLE IF NOT EXISTS cultura(
id_cultura SERIAL PRIMARY KEY,
nome_cultura text NOT NULL,
tipo text NOT NULL,
Estacao text NOT NULL	
);
CREATE TABLE IF NOT EXISTS colheita(
id_colheira SERIAL PRIMARY KEY,
data date NOT NULL,
quantidade int,
id_fazenda int,
id_cultura int,	
foreign KEY (id_fazenda ) references fazenda(id_fazenda),
foreign KEY (id_cultura) references cultura(id_cultura)
);
CREATE TABLE IF NOT EXISTS fazenda_cultura(
id_fazendaCultura SERIAL PRIMARY KEY,
id_fazenda int,
id_cultura int,	
foreign KEY (id_fazenda ) references fazenda(id_fazenda),
foreign KEY (id_cultura) references cultura(id_cultura)	
);

insert into fazenda(nome_fazenda,area_total)
VALUES
	('Fazenda Feliz',150),
	('Fazenda Triste',100),
	('Fazenda JV ',69),
	('Fazenda Vitinho',1000),
	('Fazenda Felipe',1000),
	('Fazenda Inacio',1000);

insert into cultura(nome_cultura,tipo,estacao)
VALUES
	('Banana','Fruta','Verão'),
	('Laranja','Fruta','Verão'),
	('Melancia','Fruta','Verão'),
	('Caju','Fruta','Verão'),
	('Alface','Hortaliça','Inverno'),
	('Espinafre','Hortaliça','Inverno'),
	('Couve','Hortaliça','Inverno'),
	('Chuchu','Hortaliça','Inverno');

insert into colheita(data,quantidade,id_fazenda,id_cultura)
VALUES
		('2023-11-17',10,1,2),
		('2023-11-17',10,1,3),
		('2023-11-17',10,2,4),
		('2023-11-17',10,2,5),
		('2023-11-17',10,3,6),
		('2023-11-17',10,3,2);
UPDATE colheita
SET data = '2023-11-18'
WHERE id_fazenda = (
    SELECT id_fazenda
    FROM fazenda
    WHERE nome_fazenda = 'Fazenda Feliz'
    ORDER BY id_colheira DESC
    LIMIT 1
);

UPDATE colheita
SET data = '2023-12-25'
WHERE id_fazenda = (
    SELECT id_fazenda
    FROM fazenda
    WHERE nome_fazenda = 'Fazenda Feliz'
    ORDER BY id_colheira DESC
    LIMIT 1
);

SELECT fazenda.fazenda_nome, colheita.data, colheita.quantidade
FROM colheita
JOIN fazenda ON colheita.id_fazenda = fazenda.id_fazenda;

SELECT fazenda.nome_fazenda AS nome_fazenda, Colheita.data, Colheita.quantidade, cultura.nome_cultura AS nome_cultura
FROM colheita
JOIN fazenda ON colheita.id_fazenda = fazenda.id_fazenda
JOIN cultura ON colheita.id_cultura = cultura.id_cultura;

SELECT fazenda.nome_fazenda AS nome_fazenda, cultura.tipo, colheita.data, colheita.quantidade
FROM colheita
JOIN fazenda ON colheita.id_fazenda = fazenda.id_fazenda
JOIN cultura ON colheita.id_cultura = cultura.id_cultura;

select * from colheita c
order by c.data; 

select max(quantidade ) from colheita;

select fazenda.nome_fazenda,  sum(quantidade) as somatorio  from fazenda
 join colheita ON colheita.id_fazenda = fazenda.id_fazenda
 group by fazenda.nome_fazenda
order by somatorio;

select * from fazenda
inner join colheita c ON fazenda.id_fazenda = c.id_fazenda
inner join cultura as cu ON c.id_cultura= cu.id_cultura
where nome_fazenda = 'Fazenda Feliz';

SELECT cultura.estacao, fazenda.nome_fazenda AS nome_fazenda, cultura.nome_cultura AS nome_cultura, SUM(colheita.quantidade) AS quantidade_total
FROM colheita
JOIN fazenda ON colheita.id_fazenda = fazenda.id_fazenda
JOIN cultura ON colheita.id_cultura = cultura.id_cultura
WHERE cultura.estacao = 'Verão'
GROUP BY cultura.estacao, fazenda.nome_fazenda, cultura.nome_cultura
ORDER BY fazenda.nome_fazenda, cultura.nome_cultura;

select fazenda.nome_fazenda, colheita.data,max(colheita.quantidade) as quantidade from fazenda
join colheita ON colheita.id_fazenda = fazenda.id_fazenda
join cultura ON colheita.id_cultura = cultura.id_cultura
Group by fazenda.nome_fazenda, colheita.data
order by quantidade
