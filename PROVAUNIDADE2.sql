create table if not exists Fornecedores(
	id int NOT NULL,
	nome VARCHAR(255) NOT NULL,
	rua VARCHAR(255) NOT NULL,
	cidade VARCHAR(255) NOT NULL,
	estado char(2)
);
alter table Fornecedores
	ADD PRIMARY KEY (id);

create table if not exists Categorias(
	idCATEGORIA int NOT NULL,
	nome VARCHAR(255) NOT NULL
);
alter table Categorias
ADD PRIMARY KEY (idCATEGORIA);
create table if not exists Produtos(
	idPRODUTO int NOT NULL,
	nome VARCHAR(255) NOT NULL,
	quantidade int,
	preco FLOAT,
	idFORNECEDOR int,
	idCATEGORIA int,
	PRIMARY KEY (idPRODUTO),
	Foreign KEY (idFORNECEDOR) references Fornecedores(id),
	Foreign KEY (idCATEGORIA) references Categorias(idCATEGORIA)
);
insert into Categorias(idCATEGORIA,nome)
VALUES
	(1,'SuperLuxo'),
	(2,'Importado'),
	(3,'Tecnologia'),
	(4,'Vintage'),
	(5,'Supremo');
update Categorias
set nome ='Super Luxo'
where idCATEGORIA =1
insert into Fornecedores(id,nome,rua,cidade,estado)
VALUES
		(1,'Ajax SA','Rua Presidente Castelo Branco','Porto Alegre','RS'),
		(2,'Sansul SA','Av Brasil','Rio de Janeiro','RJ'),
		(3,'South Chairs','Rua do Moinho','Santa Maria','RS'),
		(4,'Elon Electro','Rua do Moinho','São Paulo','SP'),
		(5,'Mike electro','Rua Pedro da Cunha','Curitiba','PR');

insert into Produtos(idPRODUTO,nome,quantidade,preco,idFORNECEDOR,idCATEGORIA)
VALUES
		(1,'Cadeira azul',30,300.00,5,5),
		(2,'Cadeira vermelha',50,2150.00,2,1),
		(3,'Guarda-roupa Disney',400,829.50,4,1),
		(4,'Torradeira Azul',20,9.90,3,1),
		(5,'TV',30,3000.25,2,2);
insert into Produtos(idPRODUTO,nome,quantidade,preco,idFORNECEDOR,idCATEGORIA)
VALUES
		(6,'Iphone 15',100,15500.25,1,3),
		(7,'MACBOOK PRO',25,40000.99,3,3);
insert into Fornecedores(id,nome,rua,cidade,estado)
VALUES
		(6,'Armazém Rio Grande','Rua do Alecrim','Natal','RN'),
		(7,'COMERCIAL Paraíba','Rua Jardim Tavares','Campina Grande','PB');
insert into Categorias(idCATEGORIA,nome)
VALUES
		(6,'Nacional');
update Produtos
set preco=298.00
where idPRODUTO=4;

select Produtos. * from Produtos
JOIN Fornecedores ON produtos.idFORNECEDOR = Fornecedores.id
where Fornecedores.estado ='RJ'

select Produtos.* from Produtos
JOIN Fornecedores ON produtos.idFORNECEDOR = Fornecedores.id
where Fornecedores.estado = 'RS'

select Produtos. * from Produtos
JOIN Fornecedores ON produtos.idFORNECEDOR = Fornecedores.id
where Fornecedores.estado ='SP'

select Produtos.nome AS nome_produto,Fornecedores.nome AS nome_Fornecedor, produtos.preco  from Produtos 
JOIN Fornecedores ON produtos.idFORNECEDOR = Fornecedores.id
ORDER BY Produtos.preco DESC
LIMIT 1;

update Fornecedores
set cidade='Parnamirim', estado='RN', rua='Abel Cabral'
where nome='Elon Electro'

update Produtos
set preco = preco *1.10
where idFORNECEDOR = (SELECT id FROM Fornecedores WHERE nome ='Sansul SA');

update Produtos
set preco = preco * 0.90
where idFORNECEDOR = (SELECT id FROM Fornecedores WHERE nome ='Mike electro') AND idCATEGORIA =(SELECT idCATEGORIA FROM Categorias WHERE nome='Supremo');

select * from Produtos
where preco>=8 and preco<=2000
ORDER BY  preco desc;

select * from Produtos
where preco>2000
ORDER BY preco;

select * from Fornecedores
where nome LIKE 'A%'

select * from Fornecedores
where nome LIKE 'S%'

update Produtos
set quantidade = quantidade * 1.15
where preco<300;

delete from Produtos
where idCATEGORIA = 5;

select * from fornecedores 

select * from Produtos
where nome like 'T%' AND preco>400;

delete from Produtos



