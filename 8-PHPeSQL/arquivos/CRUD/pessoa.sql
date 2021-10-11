create table pessoa (
	codigo integer not null,
	nome varchar(100) not null,
	genero char(1) not null default 'm' check (genero in ('m', 'f')),
	nascimento date not null check (date(nascimento) < current_date),
	primary key (codigo)
);

insert into pessoa (nome, genero, nascimento) values
('Mauricio Costa Quaresma', 'm', '1983-06-12'),
('Paulo Lopes Nunes', 'm', '1995-02-27'),
('Patricia Menezes Silva', 'f', '1987-11-20'),
('Cristiano Lopes Bezerra', 'm', '1985-09-02'),
('Michele Menezes Santos', 'f', '1999-10-07'),
('Cristiane Nunes Brandao', 'f', '1978-03-25'),
('Pedro Rosa Loureiro', 'm', '1981-12-01'),
('Jose Souza Martins', 'm', '1991-04-12'),
('Gabriel Albuquerque Menezes', 'm', '1998-07-17'),
('Mauricio Bezerra Lopes', 'm', '1987-08-13');

