# Exercícios SQL — PostgreSQL DVD Rental

## Lista de exercícios

Esta atividade foi elaborada com base nos comandos e conceitos trabalhados no arquivo de consultas SQL:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `DISTINCT`
- `AND` e `OR`
- `IN` e `NOT IN`
- `LIKE` e `ILIKE`
- `BETWEEN`
- `LIMIT` e `OFFSET`
- `IS NOT NULL`
- `INNER JOIN`
- `GROUP BY`
- `SUM()`
- `LENGTH()`
- conversão com `::date`

> **Observação:** as respostas abaixo são um **gabarito**. As tabelas de saída apresentam dados fictícios para representar o formato esperado do resultado. Os registros reais podem ser diferentes quando os alunos executarem as consultas no banco DVD Rental.

---

# Exercício 1 — Clientes em ordem alfabética

### Enunciado

Crie uma consulta que mostre o `first_name` e o `last_name` de todos os clientes da tabela `customer`, ordenando os resultados pelo primeiro nome em ordem crescente.

### Conceitos praticados

`SELECT` + `ORDER BY` + `ASC`

### Resposta

```sql

```

### Saída esperada

| first_name | last_name |
|---|---|
| Ana | Costa |
| Carlos | Silva |
| João | Souza |
| Maria | Oliveira |

---

# Exercício 2 — Filmes com determinado preço

### Enunciado

Na tabela `film`, mostre o `title` e o `rental_rate` dos filmes cujo preço de locação seja **0.99 ou 2.99**.

### Conceitos praticados

`WHERE` + `OR`

### Resposta

```sql

```

### Saída esperada

| title | rental_rate |
|---|---:|
| Academy Dinosaur | 0.99 |
| Ace Goldfinger | 2.99 |
| City Lights | 0.99 |
| Ocean Story | 2.99 |

---

# Exercício 3 — Clientes com nomes específicos

### Enunciado

Mostre o `first_name` e o `last_name` dos clientes cujo primeiro nome seja **Ann, Anne ou Annie**.

Utilize uma única condição para representar os três valores.

### Conceitos praticados

`WHERE` + `IN`

### Resposta

```sql

```

### Saída esperada

| first_name | last_name |
|---|---|
| Ann | Miller |
| Anne | Brown |
| Annie | Davis |

---

# Exercício 4 — Clientes cujo nome começa com "Jen"

### Enunciado

Na tabela `customer`, encontre todos os clientes cujo primeiro nome começa com **Jen**.

O resultado deve apresentar o primeiro nome e o sobrenome, ordenados pelo primeiro nome.

### Conceitos praticados

`LIKE` + `%` + `ORDER BY`

### Resposta

```sql

```

### Saída esperada

| first_name | last_name |
|---|---|
| Jenna | Costa |
| Jenifer | Silva |
| Jennifer | Souza |

---

# Exercício 5 — Filmes longos e baratos

### Enunciado

Na tabela `film`, encontre filmes que tenham:

- duração (`length`) maior que **180 minutos**; e
- preço de locação (`rental_rate`) menor que **1**.

Mostre o título, a duração e o preço.

### Conceitos praticados

`WHERE` + `AND` + operadores `>` e `<`

### Resposta

```sql

```

### Saída esperada

| title | length | rental_rate |
|---|---:|---:|
| Long Adventure | 185 | 0.99 |
| Great Mystery | 190 | 0.99 |
| Ocean Journey | 195 | 0.99 |

---

# Exercício 6 — Primeiros filmes da tabela

### Enunciado

Mostre o `film_id`, o `title` e o `release_year` dos **5 primeiros filmes**, considerando a ordem crescente de `film_id`.

### Conceitos praticados

`ORDER BY` + `LIMIT`

### Resposta

```sql

```

### Saída esperada

| film_id | title | release_year |
|---:|---|---:|
| 1 | Academy Dinosaur | 2006 |
| 2 | Ace Goldfinger | 2006 |
| 3 | Adaptation Holes | 2006 |
| 4 | Affair Prejudice | 2006 |
| 5 | African Egg | 2006 |

---

# Exercício 7 — Paginação de filmes

### Enunciado

Liste **4 filmes**, mas ignore os **3 primeiros registros** da tabela `film`.

Os resultados devem ser ordenados pelo `film_id`.

### Conceitos praticados

`LIMIT` + `OFFSET` + `ORDER BY`

### Resposta

```sql

```

### Saída esperada

| film_id | title | release_year |
|---:|---|---:|
| 4 | Affair Prejudice | 2006 |
| 5 | African Egg | 2006 |
| 6 | Agent Truman | 2006 |
| 7 | Airplane Sierra | 2006 |

---

# Exercício 8 — Clientes com endereço complementar

### Enunciado

Na tabela `address`, mostre `address` e `address2` somente dos registros que possuem algum valor preenchido em `address2`.

### Conceitos praticados

`WHERE` + `IS NOT NULL`

### Resposta

```sql

```

### Saída esperada

| address | address2 |
|---|---|
| Rua das Flores, 100 | Apto 201 |
| Avenida Brasil, 250 | Sala 4 |
| Rua Central, 55 | Casa B |

---

# Exercício 9 — Clientes e seus pagamentos

### Enunciado

Relacione as tabelas `customer` e `payment` utilizando `INNER JOIN`.

Mostre:

- `customer_id`
- `first_name`
- `amount`
- `payment_date`

Ordene os pagamentos do mais recente para o mais antigo.

### Conceitos praticados

`INNER JOIN` + alias + `ORDER BY DESC`

### Resposta

```sql

```

### Saída esperada

| customer_id | first_name | amount | payment_date |
|---:|---|---:|---|
| 15 | Maria | 7.99 | 2007-02-20 15:30:00 |
| 8 | João | 4.99 | 2007-02-20 13:20:00 |
| 21 | Ana | 9.99 | 2007-02-20 10:05:00 |
| 4 | Carlos | 2.99 | 2007-02-19 18:45:00 |

---

# Exercício 10 — Total pago por cliente

### Enunciado

Descubra quanto cada cliente pagou no total.

A consulta deve:

1. relacionar `payment` com `customer`;
2. montar o nome completo do cliente;
3. somar os valores de `amount`;
4. agrupar os resultados por cliente;
5. ordenar do maior total para o menor.

### Conceitos praticados

`INNER JOIN` + `SUM()` + `GROUP BY` + concatenação + `ORDER BY DESC`

### Resposta

```sql

```

### Saída esperada

| full_name | amount |
|---|---:|
| Ana Costa | 58.91 |
| Maria Silva | 45.92 |
| João Souza | 32.94 |
| Carlos Oliveira | 27.95 |

---

# Desafio extra — Modifique as consultas

Depois de resolver os 10 exercícios, tente modificar as consultas que você fez junto com o professor.

## Desafio A

Modifique o exercício 1 para ordenar o `last_name` em ordem **decrescente**.

## Desafio B

Modifique o exercício 4 para encontrar nomes que começam com **Ann**.

## Desafio C

Modifique o exercício 6 para retornar somente **3 filmes**.

## Desafio D

Modifique o exercício 7 para ignorar os **5 primeiros filmes** e mostrar os próximos **3**.

## Desafio E

Modifique o exercício 10 para ordenar o resultado pelo nome do cliente em ordem alfabética.

