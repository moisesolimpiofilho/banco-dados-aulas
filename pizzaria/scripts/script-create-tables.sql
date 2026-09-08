CREATE TABLE clientes (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(20) NOT NULL
);

CREATE TABLE cardapio (
	id SERIAL PRIMARY KEY,
	descricao VARCHAR(100) NOT NULL,
	valor DECIMAL(10,2) NOT NULL
);

CREATE TYPE status_pedido_enum AS ENUM ('Pendente', 'Entregue', 'Cancelado');

CREATE TABLE pedidos (
	id SERIAL PRIMARY KEY,
	total DECIMAL(10,2) CHECK (total > 0),
	data TIMESTAMP DEFAULT NOW(),
	status status_pedido_enum DEFAULT 'Pendente',
    cliente_id INTEGER REFERENCES clientes(id)
);

CREATE TABLE itens (
	id SERIAL PRIMARY KEY,
	pedido_id INTEGER REFERENCES pedidos(id),
	cardapio_id INTEGER REFERENCES cardapio(id),
	quantidade INTEGER CHECK (quantidade > 0)
);
