-- ---------------------------------------------------------------------------------------
-- Criando o banco de dados
-- ---------------------------------------------------------------------------------------

CREATE DATABASE oficinaDIO;

-- ---------------------------------------------------------------------------------------
-- Usando o banco de dados
-- ---------------------------------------------------------------------------------------

USE oficinaDIO;

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

-- Mecânicos
CREATE TABLE Mecanicos(
	pessoaId		int UNSIGNED	NOT NULL	PRIMARY KEY		REFERENCES	Pessoas(idPessoa),
	especialidade	varchar(30)		NOT NULL	
);

-- Veículos
CREATE TABLE Veiculos(
	idVeiculo	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	tipo		varchar(20)		NOT NULL,
	placa		varchar(10)		NOT NULL,
	clienteId	int				NOT NULL	REFERENCES Pessoas(idPessoa)
);

-- Ordens de Serviço
CREATE TABLE OrdensDeServico(
	idOS			int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	dataEmissao		date			NOT NULL,
	valor			decimal(10,2)	NOT NULL,
	dataConclusao	date			NOT NULL,
	status			enum('Finalizada', 'Em execução', 'Cancelada')	NOT NULL,
	mecanicoId 		int UNSIGNED 	NOT NULL	REFERENCES Mecanicos(pessoaId)
);

-- Peças
CREATE TABLE Pecas(
	idPeca	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	tipo	varchar(30)		NOT NULL
);

-- Serviços
CREATE TABLE Servicos(
	idServico	int UNSIGNED	NOT NULL	AUTO_INCREMENT		PRIMARY KEY,
	tipo		varchar(30)		NOT NULL
);

-- Relação Veículos_Mecânicos
CREATE TABLE Veiculos_Mecanicos(
	veiculoId	int UNSIGNED	NOT NULL	REFERENCES	Veiculos(idVeiculo),
	mecanicoId 	int	UNSIGNED	NOT NULL	REFERENCES	Mecanicos(pessoaId),
	PRIMARY KEY (veiculoId, mecanicoId)
);

-- Relação OS_Peças
CREATE TABLE OS_Pecas(
	osId		int UNSIGNED	NOT NULL	REFERENCES OrdensDeServico(idOS),
	pecaId		int UNSIGNED	NOT NULL	REFERENCES Pecas(idPeca),
	quantidade 	int UNSIGNED	NOT NULL,
	PRIMARY KEY (osId, pecaId)
);

-- Relação OS_Serviços
CREATE TABLE OS_Servicos(
	osId		int UNSIGNED	NOT NULL	REFERENCES OrdensDeServico(idOS),
	servicoId	int UNSIGNED	NOT NULL	REFERENCES Servicos(idServico),	
	PRIMARY KEY (osId, servicoId)
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
  								  ("João Assunção"),
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

-- ClientesPF
INSERT INTO ClientesPF (pessoaId, CPF, dataNascimento)
VALUES (1, '838.343.037-04', '1979-04-01'),
 	   (3, '519.911.488-36', NULL),
 	   (7, '615.330.676-43', NULL),
 	   (8, '137.584.621-34', '1976-05-06');
 	  
-- ClientesPJ
INSERT INTO ClientesPJ (pessoaId, CNPJ) VALUES (4, '08.770.516/0001-27'),
											   (6, '44.244.278/0001-80'),
											   (10, '33.999.745/0001-65');

-- Mecânicos
INSERT INTO Mecanicos (pessoaId, especialidade)	VALUES (2, 'Veículos de luxo'),
													   (5, 'Veículos antigos'),
													   (9, 'Veículos comuns');
	  
-- Veículos
INSERT INTO Veiculos (tipo, placa, clienteId) VALUES ('Luxo', 'GNL-1521', 3),
										  			 ('Comum', 'NDK-0929', 7),
										  			 ('Comum', 'HOU-0571', 4),
										 			 ('Antigo', 'LVW-1736', 8),
										 			 ('Comum', 'KAY-2442', 6),
										  			 ('Antigo', 'HQD-1083', 1),
										  			 ('Comum', 'NEZ-2011', 10);
	   
-- Ordens de Serviço
INSERT INTO OrdensDeServico (dataEmissao, valor, dataConclusao, status, mecanicoId)
VALUES ('2022-05-21', 157.00, '2022-05-29', 'Finalizada', 2),
	   ('2022-08-28', 440.50, '2022-09-08', 'Cancelada', 9),
	   ('2022-09-11', 186.00, '2022-09-20', 'Finalizada', 9),
	   ('2022-09-16', 614.80, '2022-09-25', 'Finalizada', 5),
	   ('2022-10-05', 350.00, '2022-10-20', 'Em execução', 9),
	   ('2022-10-15', 228.70, '2022-10-22', 'Em execução', 5),
	   ('2022-10-18', 97.60, '2022-10-23', 'Em execução', 9);
	  
-- Pecas
INSERT INTO Pecas (tipo) VALUES ('Pneu'),
								('Motor'),
								('Parabrisa'),
								('Vela de ignição'),
								('Radiador'),
								('Filtro de ar'),
								('Carburador'),
								('Filtro de óleo'),
								('Cabo de freio');

-- Serviços
INSERT INTO Servicos (tipo) VALUES ('Troca de óleo'),
								   ('Troca de pneus'),
								   ('Manutenção do parabrisa'),
								   ('Manutenção no motor'),
								   ('Manutenção geral');
							
-- Relação Veículos_Mecânicos
INSERT INTO Veiculos_Mecanicos (veiculoId, mecanicoId) VALUES (1, 2),
															  (2, 9),
															  (3, 9),
															  (4, 5),
															  (5, 9),
															  (6, 5),
															  (7, 9);
																
-- Relação OS_Peças
INSERT INTO OS_Pecas (osId, pecaId, quantidade) VALUES (1, 8, 1),
													   (2, 2, 1),
													   (2, 4, 1),
													   (2, 7, 1),
													   (3, 8, 1),
													   (4, 5, 1),
													   (4, 6, 1),
													   (4, 9, 1),
													   (5, 1, 2),
													   (6, 1, 3),
													   (7, 3, 2);

-- Relação OS_Servicos
INSERT INTO OS_Servicos (osId, servicoId) VALUES (1, 1),
											     (2, 4),
											     (3, 1),
											     (4, 5),
										 	     (5, 2),
											     (6, 2),
											     (7, 3);
											 
-- ---------------------------------------------------------------------------------------
-- Realizando Queries
-- ---------------------------------------------------------------------------------------

-- 1) Visualização do nome, CPF e placa do veículo de cada cliente pessoa física, em ordem 
--    alfabética de acordo com o nome:

SELECT p.nome 'Nome do Cliente', pf.CPF 'CPF', v.placa 'Placa do Veículo'
FROM Pessoas p, ClientesPF pf, Veiculos v
WHERE p.idPessoa = pf.pessoaId AND v.clienteId = pf.pessoaId
ORDER BY p.nome ASC;

-- 2) Visualização das informações de cada ordem de serviço e do mecânico responsável, em ordem
--    alfabética inversa de acordo com o nome do mecânico:

SELECT p.nome 'Nome do Mecânico', m.especialidade 'Especialidade', os.dataEmissao 'Data de Emissão da OS',
	   os.dataConclusao 'Data de Conclusão', os.valor 'Valor', os.status 'Status'
FROM OrdensDeServico os
JOIN Mecanicos m ON os.mecanicoId = m.pessoaId 
JOIN Pessoas p ON m.pessoaId = p.idPessoa;

-- 3) Visualização do ID, valor, peças (e suas respectivas quantidades) e serviço de cada ordem de serviço:

SELECT os.idOS 'Identificação da OS', os.valor 'Valor', p.tipo 'Peças', osp.quantidade 'Quantidade de peças',
	   s.tipo 'Serviço' 
FROM OrdensDeServico os, Pecas p, Servicos s, OS_Pecas osp, OS_Servicos oss
WHERE os.idOS = osp.osId    AND
	  os.idOS = oss.osId    AND
	  p.idPeca = osp.pecaId AND
	  s.idServico = oss.servicoId;

-- 4) Visualização das ordens de serviço finalizadas com valor abaixo de 200.00:

SELECT * FROM OrdensDeServico
WHERE status = 'Finalizada' AND
	  valor < 200.00;
	 
-- 5) Visualização da média dos valores das ordens de serviço com 2 casas decimais:
	 
SELECT round(avg(valor), 2) 'Média dos valores das OS' FROM OrdensDeServico;

-- 6) Visualização do nome de cada mecânico que teve 2 ou mais ordens de serviços 
--    suas respectivas quantidades ordenadas de maneira decrescente:

SELECT p.nome 'Mecânico', count(os.mecanicoId) 'Quantidade de OS'
FROM OrdensDeServico os 
JOIN Pessoas p ON os.mecanicoId = p.idPessoa 
GROUP BY p.idPessoa, p.nome
HAVING count(os.mecanicoId) >= 2
ORDER BY count(os.mecanicoId) DESC;
	  