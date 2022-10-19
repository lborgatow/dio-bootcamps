# Projeto Conceitual de Banco de Dados - E-COMMERCE

## Narrativa 
### Produto
- Os produtos são vendidos por uma única plataforma online.
Contudo, estes podem ter vendedores distintos (terceiros)
- Cada produto possui um fornecedor
- Um ou mais produtos podem compor um pedido

### Cliente
- O cliente pode se cadastrar no site com seu CPF ou CNPJ
- O Endereço do cliente irá determinar o valor do frete
- Um cliente pode comprar mais de um pedido. Este tem um período
de carência para devolução do produto

### Pedido
- O pedidos são criados por clientes e possueminformações de
compra, endereço e status da entrega
- Um produto ou mais compoem o pedido
- O pedido pode ser cancelado

### Fornecedor & estoque
- Livre

## Refinando
- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não
pode ter as duas informações
- Pagamento – Pode ter cadastradomais de uma forma de
pagamento
- Entrega – Possui status e código de rastreio

# Projeto Lógico de Banco de Dados - E-COMMERCE
Mapeamento Lógico do Modelo Conceitual para auxiliar na construção do Modelo Físico.

# Projeto Físico de Banco de Dados - E-COMMERCE

## Objetivo
Criar um modelo físico baseado no modelo conceitual e lógico de E-COMMERCE e realizar algumas Queries utilizando:
- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- JOIN
- Funções de Agregação
