# 📝 Exercícios de Manipulação e Consulta SQL

Este documento contém os scripts SQL para inserção, atualização, exclusão e consultas de exploração do banco de dados da pizzaria, atendendo à estrutura das tabelas `clientes`, `cardapio`, `pedidos` e `itens`.

---

## 📌 Sumário

- [1. Inserção de Registros (INSERT)](#1-inserção-de-registros-insert)
- [2. Atualização de Registros (UPDATE)](#2-atualização-de-registros-update)
- [3. Exclusão de Registros (DELETE)](#3-exclusão-de-registros-delete)
- [4. Consultas com Filtro (WHERE)](#4-consultas-com-filtro-where)
- [5. Consultas com Agrupamento (GROUP BY)](#5-consultas-com-agrupamento-group-by)
- [6. Consultas com Busca por Padrão (LIKE)](#6-consultas-com-busca-por-padrão-like)
- [7. Consultas com Junção de Tabelas (INNER JOIN)](#7-consultas-com-junção-de-tabelas-inner-join)

---

## 1. Inserção de Registros (INSERT)

Exemplo de inserção de 5 registros em cada uma das tabelas do banco de dados.

### 1.1. Inserir 5 Clientes
```sql
INSERT INTO clientes (nome, telefone) VALUES
('Carlos Eduardo', '(19) 99876-5432'),
('Mariana Silva', '(19) 98765-4321'),
('Fernanda Lima', '(19) 97654-3210'),
('Ricardo Alves', '(19) 96543-2109'),
('Beatriz Costa', '(19) 95432-1098');
```

### 1.2. Inserir 5 Itens no Cardápio
```sql
INSERT INTO cardapio (descricao, valor) VALUES
('Pizza Calabresa Grande', 45.00),
('Pizza Quatro Queijos Grande', 52.50),
('Pizza Frango com Catupiry', 48.00),
('Refrigerante Guaraná 2L', 12.00),
('Petit Gateau', 18.00);
```

### 1.3. Inserir 5 Pedidos
```sql
INSERT INTO pedidos (cliente_id, status, total, data) VALUES
(1, 'Entregue', 57.00, '2026-09-01 19:30:00'),
(2, 'Entregue', 52.50, '2026-09-01 20:00:00'),
(3, 'Cancelado', 48.00, '2026-09-02 18:45:00'),
(4, 'Pendente', 30.00, '2026-09-02 21:15:00'),
(5, 'Entregue', 63.00, '2026-09-03 19:10:00');
```

### 1.4. Inserir 5 Itens nos Pedidos
```sql
INSERT INTO itens (pedido_id, cardapio_id, quantidade) VALUES
(1, 1, 1), -- Pedido 1: Pizza Calabresa
(1, 4, 1), -- Pedido 1: Refrigerante Guaraná
(2, 2, 1), -- Pedido 2: Pizza Quatro Queijos
(3, 3, 1), -- Pedido 3: Pizza Frango com Catupiry
(4, 4, 1); -- Pedido 4: Refrigerante Guaraná
```

## 2. Atualização de Registros (UPDATE)
Exemplos de atualização de dados cadastrais e operacionais.

### 2.1. Atualizar o telefone de um cliente
```sql
UPDATE clientes
SET telefone = '(19) 99999-8888'
WHERE id = 1;
```

### 2.2. Atualizar o valor de um produto no cardápio
```sql
UPDATE cardapio
SET valor = 49.90
WHERE id = 1;
```

### 2.3. Atualizar o status de um pedido de 'Pendente' para 'Entregue'
```sql
UPDATE pedidos
SET status = 'Entregue'
WHERE id = 4;
```

## 3. Exclusão de Registros (DELETE)
Exemplos de remoção de dados respeitando ou limpando restrições de chave estrangeira.

### 3.1. Excluir um item de pedido específico
```sql
DELETE FROM itens
WHERE id = 5;
```

### 3.2. Excluir um produto do cardápio que não possui vínculos com pedidos
```sql
DELETE FROM cardapio
WHERE id = 5;
```

## 4. Consultas com Filtro (WHERE)
### 4.1. Listar apenas os pedidos com status 'Entregue'
```sql
SELECT id, cliente_id, total, data, status
FROM pedidos
WHERE status = 'Entregue';
```

### 4.2. Listar produtos do cardápio com valor superior a R$ 45,00
```sql
SELECT id, descricao, valor
FROM cardapio
WHERE valor > 45.00;
```

## 5. Consultas com Agrupamento (GROUP BY)
### 5.1. Contar a quantidade total de pedidos por status
```sql
5. Consultas com Agrupamento (GROUP BY)
5.1. Contar a quantidade total de pedidos por status
```

### 5.2. Somar o valor total faturado agrupado por dia
```sql
SELECT 
    DATE(data) AS dia,
    SUM(total) AS faturamento_diario
FROM pedidos
WHERE status = 'Entregue'
GROUP BY DATE(data)
ORDER BY dia ASC;
```

## 6. Consultas com Busca por Padrão (LIKE)
### 6.1. Buscar clientes cujo nome começa com 'M' ou contém 'Silva'
```sql
SELECT id, nome, telefone
FROM clientes
WHERE nome ILIKE '%Silva%' OR nome ILIKE 'M%';
```

### 6.2. Buscar produtos no cardápio que contêm a palavra 'Pizza'
```sql
SELECT id, descricao, valor
FROM cardapio
WHERE descricao ILIKE '%Pizza%';
```

## 7. Consultas com Junção de Tabelas (INNER JOIN)
### 7.1. Listar pedidos exibindo o nome e telefone do cliente associado
```sql
SELECT 
    p.id AS pedido_id,
    c.nome AS cliente,
    c.telefone,
    p.data,
    p.status,
    p.total
FROM pedidos p
INNER JOIN clientes c ON c.id = p.cliente_id;
```

## 7.2. Listar o detalhamento dos itens de cada pedido (Pedido, Produto e Quantidade)
```sql
SELECT 
    p.id AS pedido_id,
    c.descricao AS produto,
    i.quantidade,
    c.valor AS valor_unitario,
    (i.quantidade * c.valor) AS subtotal
FROM itens i
INNER JOIN pedidos p ON p.id = i.pedido_id
INNER JOIN cardapio c ON c.id = i.cardapio_id
ORDER BY p.id ASC;
```
