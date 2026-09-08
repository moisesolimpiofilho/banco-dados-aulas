# 🔍 Consultas SQL para Exploração do Banco de Dados

Este guia contém uma coleção de consultas SQL projetadas para explorar os dados da pizzaria. Elas variam do nível básico ao intermediário, abordando desde agregações simples até junções de tabelas e funções de formatação.

---

## 📋 Sumário de Consultas

1. [Faturamento Total](#1-faturamento-total)
2. [Distribuição por Status do Pedido](#2-distribuição-por-status-do-pedido)
3. [Evolução do Faturamento Mensal](#3-evolução-do-faturamento-mensal)
4. [Top 5 Produtos Mais Vendidos](#4-top-5-produtos-mais-vendidos)
5. [Top 5 Clientes Mais Frequentes](#5-top-5-clientes-mais-frequentes)
6. [Ticket Médio por Pedido](#6-ticket-médio-por-pedido)
7. [Desempenho por Categoria do Cardápio](#7-desempenho-por-categoria-do-cardápio)
8. [Taxa de Cancelamento de Pedidos](#8-taxa-de-cancelamento-de-pedidos)

---

### 1. Faturamento Total
**Objetivo:** Descobrir a receita bruta acumulada considerando apenas os pedidos que foram efetivamente concluídos e entregues.  
**Conceitos:** Função de agregação `SUM()`, filtro com `WHERE` e formatação monetária brasileira via `TRANSLATE()`.

```sql
SELECT 
    'R$ ' || TRANSLATE(TO_CHAR(SUM(total), 'FM999,999,990.00'), '.,', ',.') AS faturamento_total
FROM pedidos
WHERE status = 'Entregue';
```
### 2. Distribuição por Status do Pedido
**Objetivo**: Analisar a eficiência operacional verificando quantos pedidos foram entregues, cancelados ou continuam pendentes.
**Conceitos**: Agrupamento de dados com GROUP BY, contagem com COUNT() e ordenação com ORDER BY.

```sql
SELECT 
    status, 
    COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY status
ORDER BY total_pedidos DESC;
```

### 3. Evolução do Faturamento Mensal
**Objetivo**: Acompanhar o crescimento das vendas ao longo dos meses para identificar sazonalidade e tendências de faturamento.
**Conceitos**: Formatação de datas com TO_CHAR(), agregação temporal e agrupamento de resultados.

```sql
SELECT 
    TO_CHAR(data, 'YYYY-MM') AS mes,
    COUNT(id) AS total_pedidos,
    'R$ ' || TRANSLATE(TO_CHAR(SUM(total), 'FM999,999,990.00'), '.,', ',.') AS faturamento
FROM pedidos
WHERE status = 'Entregue'
GROUP BY TO_CHAR(data, 'YYYY-MM')
ORDER BY mes ASC;
```

### 4. Top 5 Produtos Mais Vendidos
**Objetivo**: Identificar os "carros-chefe" do cardápio em quantidade total de itens vendidos.
**Conceitos**: Relacionamento entre tabelas com JOIN, somatório por item e limitação de resultados com LIMIT.

```sql
SELECT 
    c.descricao AS produto,
    SUM(i.quantidade) AS quantidade_vendida
FROM itens i
JOIN cardapio c ON c.id = i.cardapio_id
JOIN pedidos p ON p.id = i.pedido_id
WHERE p.status = 'Entregue'
GROUP BY c.descricao
ORDER BY quantidade_vendida DESC
LIMIT 5;
```

### 5. Top 5 Clientes Mais Frequentes
**Objetivo**: Descobrir quais clientes mais realizam pedidos na pizzaria para ações de fidelização.
**Conceitos**: Junção entre tabela de fatos (pedidos) e dimensão (clientes), contagem de registros e ordenação.

```sql
SELECT 
    cli.nome,
    cli.telefone,
    COUNT(p.id) AS total_compras
FROM pedidos p
JOIN clientes cli ON cli.id = p.cliente_id
WHERE p.status = 'Entregue'
GROUP BY cli.id, cli.nome, cli.telefone
ORDER BY total_compras DESC
LIMIT 5;
```

### 6. Ticket Médio por Pedido
**Objetivo**: Calcular o valor médio gasto pelos clientes em cada compra finalizada.
**Conceitos**: Função de média AVG(), arredondamento ROUND() e formatação de moeda.
```sql
SELECT 
    'R$ ' || TRANSLATE(TO_CHAR(ROUND(AVG(total), 2), 'FM999,990.00'), '.,', ',.') AS ticket_medio
FROM pedidos
WHERE status = 'Entregue';
```

### 7. Desempenho por Categoria do Cardápio
**Objetivo**: Avaliar a participação de cada categoria (ex: Pizzas, Bebidas, Sobremesas) no faturamento total.
**Conceitos**: Junção de 3 tabelas (pedidos, itens e cardapio), cálculo de valor total (quantidade * valor) e agrupamento.
```sql
SELECT 
    c.descricao AS item_cardapio,
    SUM(i.quantidade) AS qtd_itens_vendidos,
    'R$ ' || TRANSLATE(TO_CHAR(SUM(i.quantidade * c.valor), 'FM999,999,990.00'), '.,', ',.') AS faturamento_total
FROM itens i
JOIN cardapio c ON c.id = i.cardapio_id
JOIN pedidos p ON p.id = i.pedido_id
WHERE p.status = 'Entregue'
GROUP BY c.id, c.descricao
ORDER BY SUM(i.quantidade * c.valor) DESC;
```

### 8. Taxa de Cancelamento de Pedidos
**Objetivo**: Calcular a porcentagem de pedidos cancelados em relação ao total geral de pedidos efetuados.
**Conceitos**: Contagem condicional com CASE WHEN, conversão de tipo (::NUMERIC) e cálculo percentual com ROUND().
```sql
SELECT 
    COUNT(*) AS total_geral,
    COUNT(CASE WHEN status = 'Cancelado' THEN 1 END) AS total_cancelados,
    ROUND(
        (COUNT(CASE WHEN status = 'Cancelado' THEN 1 END)::NUMERIC / COUNT(*)) * 100, 2
    ) || '%' AS taxa_cancelamento
FROM pedidos;
```