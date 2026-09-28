# Consultas SQL — PostgreSQL DVD Rental

Material de apoio para aulas práticas de SQL utilizando o banco de dados **DVD Rental**.

> **Importante:** as saídas apresentadas neste material são **dados fictícios (fake)**, criados apenas para demonstrar visualmente o possível resultado de cada consulta. Elas não representam necessariamente os registros existentes no banco real.

---

## 1. Consultas `SELECT`

### 1.1 Selecionando todos os dados de uma tabela

**Descrição:** retorna todas as colunas e todos os registros da tabela `customer`.

```sql
SELECT * FROM customer;
```

**Possível saída (dados fictícios):**

| customer_id | first_name | last_name | email |
|---:|---|---|---|
| 1 | Maria | Silva | maria.silva@email.com |
| 2 | João | Souza | joao.souza@email.com |
| 3 | Ana | Costa | ana.costa@email.com |

---

### 1.2 Selecionando uma única coluna

**Descrição:** retorna somente o primeiro nome dos clientes.

```sql
SELECT first_name FROM customer;
```

**Possível saída:**

| first_name |
|---|
| Maria |
| João |
| Ana |

---

### 1.3 Selecionando várias colunas

**Descrição:** retorna o nome, sobrenome e e-mail dos clientes.

```sql
SELECT
   first_name,
   last_name,
   email
FROM
   customer;
```

**Possível saída:**

| first_name | last_name | email |
|---|---|---|
| Maria | Silva | maria.silva@email.com |
| João | Souza | joao.souza@email.com |
| Ana | Costa | ana.costa@email.com |

---

### 1.4 Concatenando nome e sobrenome

**Descrição:** usa `||` para juntar o primeiro nome e o sobrenome em uma única coluna.

```sql
SELECT
   first_name || ' ' || last_name,
   email
FROM
   customer;
```

**Possível saída:**

| ?column? | email |
|---|---|
| Maria Silva | maria.silva@email.com |
| João Souza | joao.souza@email.com |
| Ana Costa | ana.costa@email.com |

---

### 1.5 Criando um apelido para uma coluna com `AS`

**Descrição:** cria o alias `full_name` para o resultado da concatenação do nome e sobrenome.

```sql
SELECT
   first_name || ' ' || last_name full_name,
   email
FROM
   customer;
```

**Possível saída:**

| full_name | email |
|---|---|
| Maria Silva | maria.silva@email.com |
| João Souza | joao.souza@email.com |
| Ana Costa | ana.costa@email.com |

---

### 1.6 Criando alias com espaço no nome

**Descrição:** demonstra como utilizar aspas duplas para criar um alias que contém espaço.

```sql
SELECT
   first_name || ' ' || last_name "full name"
FROM
   customer;
```

**Possível saída:**

| full name |
|---|
| Maria Silva |
| João Souza |
| Ana Costa |

---

# 2. Consultas `ORDER BY`

O `ORDER BY` é utilizado para ordenar os registros retornados pela consulta.

### 2.1 Ordenação crescente

**Descrição:** organiza os clientes pelo primeiro nome em ordem alfabética crescente.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Ana | Costa |
| João | Souza |
| Maria | Silva |

---

### 2.2 Ordenação decrescente

**Descrição:** organiza os clientes pelo sobrenome em ordem alfabética decrescente.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  last_name DESC;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| João | Souza |
| Maria | Silva |
| Ana | Costa |

---

### 2.3 Ordenando por duas colunas

**Descrição:** primeiro ordena pelo primeiro nome de forma crescente. Em caso de empate, ordena o sobrenome de forma decrescente.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC,
  last_name DESC;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Ana | Costa |
| João | Souza |
| Maria | Silva |

---

### 2.4 Ordenando pelo tamanho do nome

**Descrição:** utiliza a função `LENGTH()` para calcular o tamanho do primeiro nome e ordena do maior para o menor.

```sql
SELECT
  first_name,
  LENGTH(first_name) len
FROM
  customer
ORDER BY
  len DESC;
```

**Possível saída:**

| first_name | len |
|---|---:|
| Mariana | 7 |
| Carlos | 6 |
| Ana | 3 |

---

# 3. Consultas `SELECT DISTINCT`

### 3.1 Eliminando valores repetidos

**Descrição:** retorna apenas os valores diferentes de `rental_rate` encontrados na tabela `film`.

```sql
SELECT DISTINCT
  rental_rate
FROM
  film
ORDER BY
  rental_rate;
```

**Possível saída:**

| rental_rate |
|---:|
| 0.99 |
| 2.99 |
| 4.99 |

---

# 4. Consultas `WHERE`

O `WHERE` permite filtrar os registros de acordo com uma condição.

### 4.1 Filtrando por nome

**Descrição:** retorna clientes cujo primeiro nome seja exatamente `Jamie`.

```sql
SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie';
```

**Possível saída:**

| last_name | first_name |
|---|---|
| Rice | Jamie |
| Brown | Jamie |

---

### 4.2 Utilizando `AND`

**Descrição:** retorna somente o cliente que possui simultaneamente o primeiro nome `Jamie` e o sobrenome `Rice`.

```sql
SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie'
  AND last_name = 'Rice';
```

**Possível saída:**

| last_name | first_name |
|---|---|
| Rice | Jamie |

---

### 4.3 Utilizando `OR`

**Descrição:** retorna clientes cujo sobrenome seja `Rodriguez` **ou** cujo primeiro nome seja `Adam`.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  last_name = 'Rodriguez'
  OR first_name = 'Adam';
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Adam | Smith |
| Carlos | Rodriguez |
| Adam | Rodriguez |

---

### 4.4 Utilizando `IN`

**Descrição:** verifica se o primeiro nome está entre os valores informados.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name IN ('Ann', 'Anne', 'Annie');
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Ann | Miller |
| Anne | Brown |
| Annie | Davis |

---

### 4.5 Utilizando `LIKE` com `%`

**Descrição:** procura nomes que começam com `Ann`. O `%` representa qualquer sequência de caracteres.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Ann%';
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Ann | Miller |
| Anne | Brown |
| Annie | Davis |

---

### 4.6 Combinando `LIKE`, `LENGTH()` e `BETWEEN`

**Descrição:** procura nomes que começam com `A` e possuem entre 3 e 5 caracteres. O resultado é ordenado pelo tamanho do nome.

```sql
SELECT
  first_name,
  LENGTH(first_name) name_length
FROM
  customer
WHERE
  first_name LIKE 'A%'
  AND LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
  name_length;
```

**Possível saída:**

| first_name | name_length |
|---|---:|
| Ana | 3 |
| Alex | 4 |
| Alice | 5 |

---

### 4.7 Utilizando `<>`

**Descrição:** procura nomes que começam com `Bra`, mas exclui clientes cujo sobrenome seja `Motley`.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Bra%'
  AND last_name <> 'Motley';
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Brad | Smith |
| Brandon | Davis |

---

### 4.8 Comparando números com `>` e `<`

**Descrição:** retorna filmes com duração superior a 180 minutos e preço de locação inferior a 1.

```sql
SELECT
  title,
  length,
  rental_rate
FROM
  film
WHERE
  length > 180
  AND rental_rate < 1;
```

**Possível saída:**

| title | length | rental_rate |
|---|---:|---:|
| Long Adventure | 185 | 0.99 |
| Great Mystery | 190 | 0.99 |

---

### 4.9 Utilizando `OR` com valores numéricos

**Descrição:** retorna filmes cujo preço de locação seja `0.99` ou `2.99`.

```sql
SELECT
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate = 0.99 OR
  rental_rate = 2.99;
```

**Possível saída:**

| title | rental_rate |
|---|---:|
| The Adventure | 0.99 |
| City Lights | 2.99 |
| Ocean Story | 0.99 |

---

# 5. Consultas com `LIMIT` e `OFFSET`

### 5.1 Limitando a quantidade de registros

**Descrição:** ordena os filmes pelo `film_id` e retorna somente os cinco primeiros registros.

```sql
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT 5;
```

**Possível saída:**

| film_id | title | release_year |
|---:|---|---:|
| 1 | Academy Dinosaur | 2006 |
| 2 | Ace Goldfinger | 2006 |
| 3 | Adaptation Holes | 2006 |
| 4 | Affair Prejudice | 2006 |
| 5 | African Egg | 2006 |

---

### 5.2 Paginação com `LIMIT` e `OFFSET`

**Descrição:** ignora os três primeiros registros (`OFFSET 3`) e retorna os quatro seguintes.

```sql
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT 4 OFFSET 3;
```

**Possível saída:**

| film_id | title | release_year |
|---:|---|---:|
| 4 | Affair Prejudice | 2006 |
| 5 | African Egg | 2006 |
| 6 | Agent Truman | 2006 |
| 7 | Airplane Sierra | 2006 |

---

### 5.3 Os 10 filmes com maior preço de locação

**Descrição:** ordena o preço de locação de forma decrescente e retorna os dez primeiros filmes.

```sql
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT 10;
```

**Possível saída:**

| film_id | title | rental_rate |
|---:|---|---:|
| 15 | Film Alpha | 4.99 |
| 28 | Film Bravo | 4.99 |
| 42 | Film Charlie | 4.99 |
| 7 | Film Delta | 2.99 |
| 18 | Film Echo | 2.99 |

---

# 6. Consultas com `IN` e `NOT IN`

### 6.1 Filtrando IDs com `IN`

**Descrição:** retorna somente os filmes cujos IDs estão na lista `1, 2, 3`.

```sql
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id IN (1, 2, 3);
```

**Possível saída:**

| film_id | title |
|---:|---|
| 1 | Academy Dinosaur |
| 2 | Ace Goldfinger |
| 3 | Adaptation Holes |

---

### 6.2 Filtrando atores com `IN`

**Descrição:** retorna atores cujo sobrenome seja `Allen`, `Chase` ou `Davis`, ordenando pelo sobrenome.

```sql
SELECT
  first_name,
  last_name
FROM
  actor
WHERE
  last_name IN ('Allen', 'Chase', 'Davis')
ORDER BY
  last_name;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| John | Allen |
| Mary | Chase |
| Robert | Davis |

---

### 6.3 Filtrando datas com `IN`

**Descrição:** retorna pagamentos realizados nas datas especificadas. O `::date` converte o valor para o tipo `date`.

```sql
SELECT
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date::date IN ('2007-02-15', '2007-02-16');
```

**Possível saída:**

| payment_id | amount | payment_date |
|---:|---:|---|
| 101 | 4.99 | 2007-02-15 10:25:30 |
| 102 | 8.99 | 2007-02-15 14:10:00 |
| 103 | 2.99 | 2007-02-16 09:45:12 |

---

### 6.4 Utilizando `NOT IN`

**Descrição:** retorna todos os filmes, exceto aqueles cujos IDs sejam `1`, `2` ou `3`.

```sql
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id NOT IN (1, 2, 3)
ORDER BY
  film_id;
```

**Possível saída:**

| film_id | title |
|---:|---|
| 4 | Affair Prejudice |
| 5 | African Egg |
| 6 | Agent Truman |

---

# 7. Consultas com `BETWEEN`

### 7.1 Filtrando pagamentos por período e valor

**Descrição:** retorna pagamentos realizados entre as datas informadas e cujo valor seja superior a 10.

```sql
SELECT
  customer_id,
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date BETWEEN '2007-02-15' AND '2007-02-20'
  AND amount > 10
ORDER BY
  payment_date;
```

**Possível saída:**

| customer_id | payment_id | amount | payment_date |
|---:|---:|---:|---|
| 8 | 201 | 12.99 | 2007-02-15 11:20:00 |
| 14 | 202 | 15.99 | 2007-02-17 16:30:00 |
| 21 | 203 | 10.99 | 2007-02-19 09:15:00 |

> **Atenção:** a consulta acima foi mantida conforme o arquivo original. Como `payment_date` é um campo de data/hora, vale discutir em aula o comportamento do limite superior `'2007-02-20'`.

---

# 8. Consultas com `LIKE`

### 8.1 Nomes que começam com `Jen`

**Descrição:** retorna clientes cujo primeiro nome começa com `Jen`.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Jen%';
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Jennifer | Smith |
| Jenny | Brown |
| Jenna | Davis |

---

### 8.2 Nomes que contêm `er`

**Descrição:** retorna nomes que possuem a sequência de caracteres `er` em qualquer posição.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '%er%'
ORDER BY
  first_name;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Jennifer | Smith |
| Robert | Jones |
| Teresa | Brown |

---

### 8.3 Utilizando `_` no `LIKE`

**Descrição:** o caractere `_` representa exatamente um caractere. A consulta procura nomes cujo segundo caractere seja `h` e que continuem com qualquer sequência de caracteres.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '_her%'
ORDER BY
  first_name;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Cheryl | Brown |
| Sheri | Davis |
| Theresa | Smith |

---

### 8.4 Utilizando `NOT LIKE`

**Descrição:** retorna clientes cujo primeiro nome **não** começa com `Jen`.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%'
ORDER BY
  first_name;
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Ana | Costa |
| Carlos | Silva |
| Maria | Souza |

---

### 8.5 Utilizando `ILIKE`

**Descrição:** `ILIKE` realiza uma comparação sem diferenciar letras maiúsculas e minúsculas. Assim, `BAR%` pode encontrar nomes como `Barbara` ou `Bart`.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ILIKE 'BAR%';
```

**Possível saída:**

| first_name | last_name |
|---|---|
| Barbara | Jones |
| Bart | Miller |
| Barry | Smith |

---

### 8.6 Comparando `LIKE` e `ILIKE`

**Descrição:** esta consulta utiliza `LIKE`, que no PostgreSQL normalmente diferencia maiúsculas de minúsculas.

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'BAR%';
```

**Possível saída (dados fictícios):**

| first_name | last_name |
|---|---|
| BARBARA | Jones |
| BARRY | Smith |

> **Para discussão em aula:** compare esta consulta com a anterior que utiliza `ILIKE`.

---

# 9. Consultas com `IS NOT NULL`

### 9.1 Encontrando endereços que possuem `address2`

**Descrição:** retorna endereços nos quais a coluna `address2` possui algum valor.

```sql
SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NOT NULL;
```

**Possível saída:**

| address | address2 |
|---|---|
| Rua das Flores, 100 | Apto 201 |
| Avenida Brasil, 250 | Sala 4 |
| Rua Central, 55 | Casa B |

---

# 10. Consultas com `INNER JOIN`

### 10.1 Relacionando clientes e pagamentos

**Descrição:** utiliza `INNER JOIN` para relacionar a tabela `customer` com `payment` por meio de `customer_id`. Retorna os pagamentos, ordenando do mais recente para o mais antigo.

```sql
SELECT
  c.customer_id,
  c.first_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p ON p.customer_id = c.customer_id
ORDER BY
  p.payment_date DESC;
```

**Possível saída:**

| customer_id | first_name | amount | payment_date |
|---:|---|---:|---|
| 15 | Maria | 7.99 | 2007-02-20 15:30:00 |
| 8 | João | 4.99 | 2007-02-20 13:20:00 |
| 21 | Ana | 9.99 | 2007-02-20 10:05:00 |

---

### 10.2 Relacionando clientes, pagamentos e funcionários

**Descrição:** utiliza dois `INNER JOIN` e `USING()` para relacionar clientes, pagamentos e funcionários. A consulta monta também o nome completo do cliente e do funcionário.

```sql
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name customer_name,
  s.first_name || ' ' || s.last_name staff_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p USING(customer_id)
  INNER JOIN staff s USING(staff_id)
ORDER BY
  payment_date;
```

**Possível saída:**

| customer_id | customer_name | staff_name | amount | payment_date |
|---:|---|---|---:|---|
| 1 | Maria Silva | Carlos Souza | 4.99 | 2007-02-15 10:20:00 |
| 2 | João Costa | Ana Santos | 7.99 | 2007-02-15 11:40:00 |
| 3 | Pedro Lima | Carlos Souza | 2.99 | 2007-02-15 14:15:00 |

---

# 11. Consultas com `GROUP BY` e `SUM`

### 11.1 Somando pagamentos por cliente

**Descrição:** agrupa os pagamentos pelo `customer_id` e calcula o total pago por cada cliente.

```sql
SELECT
  customer_id,
  SUM(amount)
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  customer_id;
```

**Possível saída:**

| customer_id | sum |
|---:|---:|
| 1 | 35.96 |
| 2 | 28.97 |
| 3 | 42.94 |

---

### 11.2 Somando pagamentos por nome do cliente

**Descrição:** relaciona `payment` e `customer`, agrupa pelo nome completo e calcula o total pago por cada cliente. Depois, ordena do maior total para o menor.

```sql
SELECT
  first_name || ' ' || last_name full_name,
  SUM(amount) amount
FROM
  payment
  INNER JOIN customer USING (customer_id)
GROUP BY
  full_name
ORDER BY
  amount DESC;
```

**Possível saída:**

| full_name | amount |
|---|---:|
| Ana Costa | 58.91 |
| Maria Silva | 45.92 |
| João Souza | 32.94 |

---

### 11.3 Somando pagamentos por dia

**Descrição:** converte `payment_date` para `date`, agrupa os pagamentos por dia e calcula a soma dos valores pagos em cada data.

```sql
SELECT
  payment_date::date payment_date,
  SUM(amount) sum
FROM
  payment
GROUP BY
  payment_date::date
ORDER BY
  payment_date DESC;
```

**Possível saída:**

| payment_date | sum |
|---|---:|
| 2007-02-20 | 125.84 |
| 2007-02-19 | 98.73 |
| 2007-02-18 | 143.62 |

---

# Resumo dos principais conceitos trabalhados

| Conceito | O que a consulta demonstra |
|---|---|
| `SELECT` | Seleção de dados |
| `*` | Seleção de todas as colunas |
| `||` | Concatenação de textos |
| `AS` / alias | Criação de nomes alternativos para colunas |
| `ORDER BY` | Ordenação dos resultados |
| `ASC` | Ordem crescente |
| `DESC` | Ordem decrescente |
| `DISTINCT` | Remoção de valores duplicados |
| `WHERE` | Filtragem de registros |
| `AND` | Exige que duas ou mais condições sejam verdadeiras |
| `OR` | Permite que uma das condições seja verdadeira |
| `IN` | Compara com uma lista de valores |
| `NOT IN` | Exclui uma lista de valores |
| `LIKE` | Pesquisa utilizando padrões |
| `ILIKE` | Pesquisa sem diferenciar maiúsculas/minúsculas |
| `%` | Representa uma sequência de caracteres |
| `_` | Representa um único caractere |
| `<>` | Diferente de |
| `BETWEEN` | Verifica se um valor está dentro de um intervalo |
| `LIMIT` | Limita a quantidade de registros retornados |
| `OFFSET` | Ignora uma quantidade de registros antes de retornar resultados |
| `IS NOT NULL` | Localiza valores que não são nulos |
| `INNER JOIN` | Combina registros relacionados entre tabelas |
| `USING()` | Simplifica o `JOIN` quando a coluna possui o mesmo nome |
| `GROUP BY` | Agrupa registros |
| `SUM()` | Calcula a soma dos valores |
| `LENGTH()` | Retorna a quantidade de caracteres de um texto |
| `::date` | Converte um valor para o tipo `date` |

---

## Sugestão de dinâmica para a aula

Para cada consulta, os alunos podem seguir esta sequência:

1. **Ler a consulta** e identificar a tabela utilizada.
2. **Identificar as colunas** que serão exibidas.
3. **Identificar os filtros** (`WHERE`).
4. **Identificar a ordenação** (`ORDER BY`).
5. **Prever o resultado** antes de executar.
6. **Executar a consulta** no PostgreSQL.
7. **Comparar o resultado real** com a previsão.
8. **Modificar a consulta** para testar outras condições.

> **Observação:** as consultas SQL foram mantidas com base no arquivo original fornecido para a aula. As descrições e tabelas de saída foram acrescentadas como material didático; as saídas são exemplos fictícios.
