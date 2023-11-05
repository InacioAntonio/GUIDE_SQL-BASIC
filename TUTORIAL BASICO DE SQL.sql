--Criando um tipo regiao que so pode receber esses valores pré-definidos e estaticos
Create type IF NOT EXISTS regiao AS ENUM ('Norte','Nordeste','Centro-Oeste','Sul','Sudeste');

--Criando a tabela estados caso não exista
Create table IF NOT EXISTS estados(
	id Serial,
	nome VARCHAR(255) NOT NULL,
	sigla VARCHAR(2) NOT NULL UNIQUE,
	população DECIMAL(10,2),
	regioes regiao NOT NULL
);

--Inserindo Dados na tabela estado
INSERT INTO estados(nome,sigla,regioes,população)
VALUES ('Acre','AC','Norte',0.83);

-- Inserindo Dados na tabela Estado
INSERT INTO estados(nome,sigla,regioes,população)
VALUES 
	('Rondonia','RO','Norte',1.15),
	('Amazonas','AM','Norte',3.35),
	('Amapá','AP','Norte',0.88),
	('Ceará','CE','Nordeste',5.85);
	
--Inserindo Dados na Tabela estados.
INSERT INTO estados (nome,sigla,regioes,população)
VALUES
	('Distrito Federal','DF','Centro-Oeste',1.50),
	('Goias','GO','Centro-Oeste',4.50),
	('Mato Grosso','MT','Centro-Oeste',3.45),
	('Mato Grosso do Sul','MS','Centro-Oeste',5.55),
	('Alagoas','AL','Nordeste',3.35),
	('Bahia','BA','Nordeste',3.75),
	('Maranhão','MA','Nordeste',8.85),
	('Paraíba','PB','Nordeste',7.75),
	('Pernanbuco','PE','Nordeste',9.3),
	('Piauí','PI','Nordeste',4.56),
	('Rio Grande do Norte','RN','Nordeste',5.56),
	('Sergipe','SE','Nordeste',4.567),
	('Roraima','RM','Norte',3.67),
	('Tocantins','TO','Norte',7.85),
	('Pará','PA','Norte',8.67),
	('Espirito Santos','ES','Sudeste',9.8),
	('Minas Gerais','MG','Sudeste',12.8),
	('São Paulo','SP','Sudeste',25.8),
	('Rio de Janeiro','RJ','Sudeste',29.4),
	('Paraná','PR','Sul',15.6),
	('Rio Grande do Sul','RS','Sul',8.9),
	('Santa Catarina','SC','Sul',9.8);

-- Fazendo buscas na tabela estado levando em consideração so estados regiao sul.
select nome,sigla from estados
where regioes = 'Sul'

-- Fazendo busca na tabela estado levando em consideração apenas estados com a população maior igual a 10 milhoes de pessoas por estado e os ordenando de forma decrencente.
select nome,regioes from estados
where população >=10 
order by população desc

--Fazendos atualizaçoes na tabela estado para que ele coloque o nome maranhanhão na tupla em que a coluna sigla seja igual a MA
update estados
set nome = 'Maranhão'
where sigla = 'MA'

--Verificando se atualização foi bem sucedida
select * from estados

--Fazendo atualizações na tabela estado para que ele coloque o nome Paraná e a populção em 11.32 na tupla que na coluna sigla seja igual = PR;
update estados
set nome = 'Paraná', população = 11.32
where sigla ='PR'

--Conferindo se a atualização do nome e população foi bem sucedida
select estados.nome, população, sigla from estados where sigla ='PR'

--Inserindo novos valores na tabela estado.
insert into estados(id,nome,sigla,regioes,população)
Values (1000,'NOVO','NO','Sudeste',9.5);

insert into estados(nome,sigla,regioes,população)
Values ('MaisNOVO','MV','Sul',10);

--Apagando os Novos Valores na tabela estado;
delete from estados
where sigla = 'MV'

delete from estados
where id >= 1000

--Conferindo se os Deletes foram bem-sucedidos;
select * from estados
--Fazendo uma busca na tabela estados agropando em regioes e ordenando de forma descrencente o total de populações de cada regiao;
select
	regioes,
	sum(população) as Total
	from estados
group by regioes
order by Total desc

--Criando a tabela cidades caso não exista;
Create table IF NOT EXISTS cidades(
	id Serial,
	nome VARCHAR(255) NOT NULL,
	estado_id integer NOT NULL,
	area DECIMAL(10,2),
	PRIMARY KEY (id),
	Foreign KEY (estado_id) references estados(id)
);

--Inserindo Valores na tabela Cidade;
insert into cidades(nome,area,estado_id)
Values ('Campinas',795,22)

insert into cidades(nome,area,estado_id)
Values ('Caruaru',920.5,(select id from estados where sigla ='PE'))

insert into cidades(nome,area,estado_id)
Values ('Niterói',133.9,(select id from estados where sigla ='RJ'))

--Conferindos se os valores foi inseridos de maneira bem-sucedida;
select * from cidades

--Inserindo Mais Valores na tabela Cidade que tem relação 1-N com tabela estados;
insert into cidades(nome,area,estado_id)
Values ('Juazeiro do Norte',248.2,(select id from estados where sigla ='CE'))

--Fazendo uma busca que concatena corretamente o id do estado e estado id da tabela cidade;
select * from estados e , cidades c
where e.id = c.estado_id

--Fazendo outra busca que praticamente faz a mesma coisa da primeira;
select e.nome, c.nome, regioes from estados e ,cidades c
where e.id = c.estado_id

--Fazendo outra busca que junta os valores da tabela estado e cidade se baseando que o estado id e igual a estado_id da tabela cidade;
select 
c.nome as Cidades,
e.nome as Estados,
regioes as Regiões
from estados e 
inner join cidades c
on e.id = c.estado_id

-- Criando uma tabela de relação 1 pra 1 com cidades
Create table if not exists prefeitos(
	id serial,
	nome VARCHAR(200) NOT NULL,
	cidade_id int UNIQUE,
	primary key(id),
	FOREIGN KEY (cidade_id) references cidades(id)
);

--inserindo valores na tabela Prefeitos
insert into prefeitos(nome,cidade_id)
VALUES ('Rodrigo Neves',2),
	   ('Raquel Lyra',4),
		('Zenaldo Coutinho',NULL);

insert into prefeitos(nome,cidade_id)
Values ('Rafael Greca',NULL);

--Fazendo alguns selects com inner join e left join etc se baseando que o id da cidade precisa ser igual ao id da tabela cidade_id da tabela prefeitos;
select * from cidades c inner join prefeitos p on c.id = p.cidade_id

select * from cidades c left join prefeitos p on c.id = p.cidade_id
union
select * from cidades c right join prefeitos p on c.id = p.cidade_id

select * from cidades c full join prefeitos p on c.id = p.cidade_id

--Criando a tabela empresas
Create table IF NOT EXISTS empresas(
	id SERIAL,
	nome VARCHAR(255) NOT NULL,
	cnpj int UNIQUE,
	primary key (id)

);

--cidades_Empresas a terceira tabela criada pra relação N PARA N de CIDADE EMPRESA
Create table IF NOT EXISTS empresas_unidades(
	empresa_id int NOT NULL,
	cidade_id int NOT NULL,
	sede BOOLEAN NOT NULL,
	PRIMARY KEY (empresa_id,cidade_id)
);
--Corrigindo o tipo de dado da coluna CNPJ
ALter table empresas
	ALTER COLUMN cnpj  TYPE VARCHAR(20)

--Inserindo novos Valores a	para tabela empresas 
insert into empresas(nome,cnpj)
VALUES
	('Bradesco',99945632100),
	('Cielo',71795483000106),
	('Vale' ,84617568000146),
	('Petrobrás',63262542000152);

--Inserindo Valores na terceira tabela de cidade e empresas
insert into empresas_unidades(empresa_id,cidade_id,sede)
VALUES
	(1,1,'1'),
	(1,2,'0'),
	(2,1,'0'),
	(2,2,'1');
	
--Fazendo a Busca nas tabelas empresas e empresas_unidades e cidades imprimindo apenas aqueles valores que sao o id da empresa é igual ao id empresa da terceira tabela e que os ids da cidades sejam iguais aos ids de cidade_id da terceira tabela e que a coluna sede seja verdadeira;
select e.nome, c.nome from empresas e,empresas_unidades eu,cidades c
where e.id = eu.empresa_id
and c.id =eu.cidade_id
and sede
