-- ---------------------------------------------------------------------------------------
-- Criando o banco de dados
-- ---------------------------------------------------------------------------------------

CREATE DATABASE e_commerceDIO;

-- ---------------------------------------------------------------------------------------
-- Usando o banco de dados
-- ---------------------------------------------------------------------------------------

USE e_commerceDIO;

-- ---------------------------------------------------------------------------------------
-- Criando as tabelas
-- ---------------------------------------------------------------------------------------

-- Pessoa
CREATE TABLE Pessoas(
	idPessoa	int	UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	nome		varchar(50)		NOT NULL
);

-- Endereços
CREATE TABLE Enderecos(
	idEndereco	int				UNSIGNED	AUTO_INCREMENT		PRIMARY KEY,
	estado		char(2)			NOT NULL,
	CEP			varchar(9)		NOT NULL,
	cidade		varchar(40)		NOT NULL,
	bairro		varchar(30) 	NOT NULL,
	rua         varchar(40) 	NOT NULL,
	numero      varchar(10) 	NOT NULL,
	pessoaId    int UNSIGNED	NOT NULL	REFERENCES	Pessoas(idPessoa)
);

-- Telefones
CREATE TABLE Telefones(
	numeroTelefone	varchar(16)		NOT NULL	PRIMARY KEY,
	pessoaId 		int UNSIGNED 	REFERENCES 	Pessoas(idPessoa)
);

-- ClientesPF
CREATE TABLE ClientesPF(
	pessoaId		int UNSIGNED	NOT NULL	PRIMARY KEY		REFERENCES	Pessoas(idPessoa),
	CPF				varchar(14)		NOT NULL	UNIQUE,
	dataNascimento	date			NULL		
);

-- ClientesPJ
CREATE TABLE ClientesPJ(
	pessoaId		int UNSIGNED	NOT NULL	PRIMARY KEY		REFERENCES	Pessoas(idPessoa),
	CNPJ			varchar(20)		NOT NULL	UNIQUE		
);

-- Produtos
CREATE TABLE Produtos(
	idProduto	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	categoria 	enum
		('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimento', 'Outros')		NOT NULL,
	descricao	varchar(100)	NOT NULL,
	preco		decimal(10,2)	NOT NULL
);

-- Entregas
CREATE TABLE Entregas(
	idEntrega	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	status		enum('Enviado', 'Entregue', 'Cancelado', 'Aguardando pagamento')	NOT NULL
);

-- Pagamentos
CREATE TABLE Pagamentos(
	idPagamento		int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	formaPagamento	enum('Dinheiro', 'Cartão', 'PIX')	NOT NULL,
	dataVencimento	date			NULL,
	status 			enum('Pago', 'Em pagamento', 'Não pago')	NOT NULL,
	clienteId 		int UNSIGNED 	NOT NULL	REFERENCES Pessoas(idPessoa)
);

-- Pedidos
CREATE TABLE Pedidos(
	idPedido	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	valorTotal	decimal(10,2)	NOT NULL,
	descricao   varchar(100) 	NULL,
	pagamentoId	int UNSIGNED	NOT NULL	REFERENCES Pagamentos(idPagamento),
	clienteId	int UNSIGNED	NOT NULL	REFERENCES Pessoas(idPessoa),	
	entregaId	int UNSIGNED	NOT NULL	REFERENCES Entregas(idEntrega)
);

-- Fornecedores
CREATE TABLE Fornecedores(
	idFornecedor	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	razaoSocial		varchar(50)		NOT NULL,
	CNPJ			varchar(20)		NOT NULL 	UNIQUE
);

-- Estoques
CREATE TABLE Estoques(
	idEstoque		int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	localizacao 	varchar(150)	NOT NULL  
);

-- Vendedores(Terceiros)
CREATE TABLE VendedoresTerceiros(
	idVendedor		int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	razaoSocial		varchar(50)		NOT NULL,
	localizacao 	varchar(150)	NOT NULL 
);

-- Relação Pedidos_Produtos
CREATE TABLE Pedidos_Produtos(
	pedidoId	int UNSIGNED	NOT NULL	REFERENCES	Pedidos(idPedido),
	produtoId 	int	UNSIGNED	NOT NULL	REFERENCES	Produtos(idProduto),
	quantidade 	int UNSIGNED	NOT NULL,	
	PRIMARY KEY (pedidoId, produtoId)
);

-- Relação Fornecedores_Produtos
CREATE TABLE Fornecedores_Produtos(
	fornecedorId	int UNSIGNED	NOT NULL	REFERENCES Fornecedores(idFornecedor),
	produtoId		int UNSIGNED	NOT NULL	REFERENCES Produtos(idProduto),
	PRIMARY KEY (fornecedorId, produtoId)
);

-- Relação VendedoresTerceiros_Produtos
CREATE TABLE VendedoresTerceiros_Produtos(
	vendedorId		int UNSIGNED	NOT NULL	REFERENCES Vendedores(idVendedor),
	produtoId		int UNSIGNED	NOT NULL	REFERENCES Produtos(idProduto),
	quantidade 		int UNSIGNED	NOT NULL,	
	PRIMARY KEY (vendedorId, produtoId)
);

-- Relação Estoques_Produtos
CREATE TABLE Estoques_Produtos(
	estoqueId		int UNSIGNED	NOT NULL	REFERENCES Estoques(idEstoque),
	produtoId		int UNSIGNED	NOT NULL	REFERENCES Produtos(idProduto),
	quantidade 		int UNSIGNED	NOT NULL,	
	PRIMARY KEY (estoqueId, produtoId)
);

-- ---------------------------------------------------------------------------------------
-- Inserindo registros
-- ---------------------------------------------------------------------------------------

-- Pessoas
INSERT INTO Pessoas (nome) VALUES ("Luiza Figueiredo"),
  								  ("Analu Bernardes"),
  								  ("Enrico Costa"),
  								  ("Mais Atacadão"),
  								  ("Luiz Rezende"),
  								  ("Papelaria Silva's"),
  								  ("Ester Pires"),
  								  ("Bernardo Porto"),
  								  ("Fátima Assunção"),
  								  ("Brazuca's Restaurante");
  								 
-- Endereços
INSERT INTO Enderecos (estado, CEP, cidade, bairro, rua, numero, pessoaId)
VALUES ('AM', '69017-324', 'Manaus', 'Nova Cidade', 'Rua 26', '506', 1),
	   ('ES', '29175-751', 'Serra', 'Lagoa de Jacaraípe', 'Rua Bauru', '160', 2),
	   ('PB', '58037-670', 'João Pessoa', 'Jardim Oceania', 'Rua Tenente Rivaldo Antônio Araújo', '581', 3),
	   ('PR', '86085-290', 'Londrina', 'Maria Cecília Serrano', 'Rua Manoel Joaquim Martins', '237', 4),
	   ('BA', '44009-066', 'Feira de Santana', 'Calumbi', 'Passeio 9', '131', 5),
	   ('ES', '29933-045', 'São Mateus', 'Carapina', 'Rua Chiquito Bongosto', '193', 6),
	   ('RN', '59010-082', 'Natal', 'Praia do Meio', 'Vila Petriz', '355', 7),
	   ('PI', '64082-588', 'Teresina', 'Renascença', 'Quadra 55', '383', 8),
	   ('PR', '86185-670', 'Cambé', 'Parque Maracanã', 'Rua do Sol', '976', 9),
	   ('BA', '41385-030', 'Salvador', 'Sete de Abril', 'Travessa Cláudio Miranda Reis', '517', 10);
	  
-- Telefones
INSERT INTO Telefones (numeroTelefone, pessoaId) VALUES ('92 99441-9054', 1),
														('27 98238-0285', 2),
														('83 99326-7281', 3),
														('43 2537-5381', 4),
														('75 98213-3251', 5),
														('27 2943-3981', 6),
														('84 98713-3873', 7),
														('86 98574-3675', 8),
														('43 99941-8288', 9),
														('71 3696-8109', 10);

-- ClientesPF
INSERT INTO ClientesPF (pessoaId, CPF, dataNascimento)
VALUES (1, '838.343.037-04', '1979-04-01'),
 	   (2, '672.579.138-70', '1976-01-13'),
 	   (3, '519.911.488-36', NULL),
 	   (5, '138.364.646-59', '1992-05-19'),
 	   (7, '615.330.676-43', NULL),
 	   (8, '137.584.621-34', '1976-05-06'),
 	   (9, '144.799.855-30', '1988-10-12');
 	  
-- ClientesPJ
INSERT INTO ClientesPJ (pessoaId, CNPJ) VALUES (4, '08.770.516/0001-27'),
											   (6, '44.244.278/0001-80'),
											   (10, '33.999.745/0001-65');

-- Produtos
INSERT INTO Produtos (categoria, descricao, preco)
VALUES ('Eletrônico', 'Processador INTEL CORE I9-10900K', 2699.99),
	   ('Eletrônico', 'Placa de Vídeo Zotac Gaming NVIDIA GeForce RTX 2060', 1599.99),
	   ('Vestimenta', 'Camisa do Corinthians - Torcedor - 22/23', 249.90),
	   ('Vestimenta', 'Vestido Florido Azul-claro', 79.90),
	   ('Brinquedo', 'Carrinho Hot Wheels', 8.90),
	   ('Brinquedo', 'Casinha da Barbie', 234.90),
	   ('Alimento', 'Massa de Pastel 600g', 6.69),
	   ('Alimento', 'Carne moída 1Kg', 35.99),
	   ('Outros', 'Papel sulfite A4 - Caixa com 10 resmas', 270.00),
	   ('Outros', 'Lápis preto CIS - Caixa com 144 unidades', 54.90);
	  
-- Entregas
INSERT INTO Entregas (status) VALUES ('Enviado'),
									 ('Entregue'),
									 ('Cancelado'),
									 ('Enviado'), 
									 ('Entregue'),
								 	 ('Entregue'),
									 ('Aguardando pagamento'),
									 ('Cancelado'),
									 ('Enviado'),
									 ('Aguardando pagamento');
	   
-- Pagamentos
INSERT INTO Pagamentos (formaPagamento, dataVencimento, status, clienteId)
VALUES ('Dinheiro', NULL, 'Pago', 1),
	   ('Cartão', '2022-11-16', 'Em pagamento', 2),
	   ('Cartão', NULL, 'Pago', 3),
	   ('Dinheiro', NULL, 'Pago', 4),
	   ('PIX', NULL, 'Pago', 5),
	   ('PIX', NULL, 'Pago', 6),
	   ('Dinheiro', NULL, 'Não pago', 7),
	   ('Cartão', NULL, 'Não pago', 8),
	   ('Cartão', '2022-12-07', 'Em pagamento', 9),
	   ('Dinheiro', NULL, 'Não pago', 10);
	  
-- Pedidos
INSERT INTO Pedidos (valorTotal, descricao, pagamentoId, clienteId, entregaId)
VALUES (1599.99, NULL, 1, 1, 1),
	   (159.80, NULL, 2, 2, 2),
	   (2699.99, NULL, 3, 3, 3),
	   (356.00, NULL, 4, 4, 4),
	   (499.80, NULL, 5, 5, 5),
	   (439.20, NULL, 6, 6, 6),
	   (234.90, NULL, 7, 7, 7),
	   (17.80, NULL, 8, 8, 8),
	   (999.60, NULL, 9, 9, 9),
	   (234.15, NULL, 10, 10, 10);	  

-- Fornecedores
INSERT INTO Fornecedores (razaoSocial, CNPJ) VALUES ('Xangai Products', '70.183.080/0001-43'),
													('Variedade Mania', '73.896.316/0001-87'),
													('Tem D Tudo', '03.762.340/0001-48');

-- Estoques
INSERT INTO Estoques (localizacao) VALUES ('Rua João Dias Teixeira, 328 - São Paulo, SP'),
										  ('Rua Matias Ruben, 120 - Guarulho, SP'),
										  ('Rua Francisco José de Barros, 425 - São Paulo, SP'),
										  ('Rua Miguel Ribas, 746 - São Paulo, SP'),
										  ('Rua Sabino Gonçalves da Cruz, 160 - Osasco, SP');

-- Vendedores(Terceiros)
INSERT INTO VendedoresTerceiros (razaoSocial, localizacao)
VALUES ('Vem que Tem', 'Rua Goulart de Faria, 986 - São Paulo, SP'),
	   ('Atacado de Montão', 'Rua Charles Meryon, 537 - Guarulhos, SP'),
	   ('John Variedades', 'Praça Fausto Amaro Gonçalves, 775 - Osasco, SP');
										  
-- Relação Pedidos_Produtos
INSERT INTO Pedidos_Produtos (pedidoId, produtoId, quantidade)
VALUES (1, 2, 1),
       (2, 4, 2),
       (3, 1, 1),
       (4, 5, 40),
       (5, 3, 2),
       (6, 10, 8),
       (7, 6, 1),
       (8, 5, 2),
       (9, 3, 4),
       (10, 7, 35);

-- Relação Fornecedores_Produtos
INSERT INTO Fornecedores_Produtos (fornecedorId, produtoId) VALUES (1, 1),
																   (1, 2),
																   (1, 3),
																   (1, 5),
																   (2, 4),
																   (2, 7),
																   (2, 9),
																   (3, 6),
																   (3, 8),
																   (3, 10);

-- Relação VendedoresTerceiros_Produtos
INSERT INTO VendedoresTerceiros_Produtos (vendedorId, produtoId, quantidade)
VALUES (1, 1, 8),
	   (2, 3, 50),
	   (3, 9, 85);																  
																  
-- Relação Estoques_Produtos
INSERT INTO Estoques_Produtos (estoqueId, produtoId, quantidade) VALUES (1, 1, 30),
																		(1, 2, 40),
																		(2, 3, 150),
																		(2, 4, 250),
																		(3, 5, 600),
																		(3, 6, 200),
																		(4, 7, 900),
																		(4, 8, 450),
																		(5, 9, 300),
																		(5, 10, 550);																  
 
-- ---------------------------------------------------------------------------------------
-- Realizando Queries
-- ---------------------------------------------------------------------------------------

-- 1) Visualização dos nomes dos clientes (em ordem alfabética) e seus respectivos CPF/CNPJ,
--    telefones, suas cidades e seus estados:																	

SELECT p.nome 'Nome do Cliente', t.numeroTelefone 'Número de Telefone', e.cidade 'Cidade', e.estado 'Estado',
	(CASE WHEN p.idPessoa = pf.pessoaId THEN concat('CPF: ', pf.CPF)
		  WHEN p.idPessoa = pj.pessoaId THEN concat('CNPJ: ', pj.CNPJ)
	      ELSE 'Erro ao encontrar identificação'
	 END) 'Identificação'
FROM Pessoas p, ClientesPF pf, ClientesPJ pj, Telefones t, Enderecos e
WHERE p.idPessoa = t.pessoaId AND p.idPessoa = e.pessoaId AND (p.idPessoa = pf.pessoaId OR p.idPessoa = pj.pessoaId)
GROUP BY p.idPessoa
ORDER BY p.nome ASC;

-- 2) Visualização do código de rastreio, valor total, forma de pagamento e status de cada pedido e seu respectivo cliente, ordenados de
--    maneira decrescente em relação ao valor total:

SELECT e.idEntrega 'Código de Rastreio', pd.valorTotal 'Valor Total', e.status 'Status', 
	   pg.formaPagamento 'Forma de Pagamento', p.nome 'Nome do Cliente'
FROM Entregas e, Pedidos pd, Pagamentos pg, Pessoas p
WHERE pd.entregaId = e.idEntrega AND pd.pagamentoId = pg.idPagamento AND pd.clienteId = p.idPessoa
ORDER BY pd.valorTotal DESC;

-- 3) Visualização da média dos valores dos produtos com 2 casas decimais:

SELECT round(avg(pr.preco), 2) 'Média dos preços dos Produtos'
FROM Produtos pr;

-- 4) Visualização de cada estoque com quantidade de produtos maior que 400 e seus respectivos endereços:

SELECT sum(ep.quantidade) 'Quantidade de Produtos', e.localizacao 'Localização'
FROM Estoques_Produtos ep, Estoques e
WHERE ep.estoqueId = e.idEstoque
GROUP BY e.idEstoque
HAVING sum(ep.quantidade) > 400;

-- 5) Visualização da razão social e CNPJ dos fornecedores e seus respectivos produtos fornecidos, 
--    ordenados em ordem alfabética em relação aos produtos:

SELECT f.razaoSocial 'Razão Social do Fornecedor', p.descricao 'Descrição do Produto'
FROM Fornecedores f, Produtos p, Fornecedores_Produtos fp
WHERE f.idFornecedor = fp.fornecedorId AND p.idProduto = fp.produtoId
ORDER BY p.descricao ASC;

-- 6) Visualização da descrição, categoria, valor e quantidade de cada produto que possua 400 ou
--    mais unidades estocadas, ordenados de maneira crescente em relação à quantidade:

SELECT p.descricao 'Descrição', p.categoria 'Categoria', p.preco 'Preço', ep.quantidade 'Quantidade'
FROM Produtos p, Estoques_Produtos ep
WHERE p.idProduto = ep.produtoId AND ep.quantidade >= 400
ORDER BY ep.quantidade ASC;

-- 7) Visualização da descrição e quantidade de produtos, dos códigos de rastreio e dos nomes dos clientes
--    de acordo com cada pedido, ordenados de maneira decrescente em relação à quantidade e em ordem alfabética
--    em relação ao nome:

SELECT pr.descricao 'Descrição do Produto', pp.quantidade 'Quantidade', e.idEntrega 'Código de Rastreio', p.nome 'Nome do Cliente'
FROM Pedidos_Produtos pp
JOIN Produtos pr ON pp.produtoId = pr.idProduto
JOIN Pedidos pd ON pd.idPedido = pp.pedidoId
JOIN Entregas e ON e.idEntrega = pd.entregaId 
JOIN Pessoas p ON p.idPessoa = pd.clienteId
ORDER BY pp.quantidade DESC, p.nome ASC;