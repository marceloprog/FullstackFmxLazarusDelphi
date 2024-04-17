create table reserva(
    id integer default 0 not null,
    data timestamp,
    nome varchar(250),
    cpf varchar(20),
    email varchar(250),
    telefone varchar(20)
);
create table livro(
    id integer default 0 not null,
    nome varchar(250),
    descrIcao varchar(2000),
    autor varchar(250),
    status smallint default 0 not null
    );
create table reserva_livro(
    id integer default 0 not null ,
    id_livro integer default 0 not null ,
    id_reserva integer default 0 not null
);
CREATE SEQUENCE IDRESERVA;
CREATE SEQUENCE IDLIVRO;
CREATE SEQUENCE IDRESERVA_LIVRO;

CREATE OR ALTER TRIGGER RESERVA_BI FOR RESERVA
ACTIVE BEFORE INSERT POSITION 0
AS
begin
   new.id=gen_id(IDRESERVA, 1);
end;

CREATE OR ALTER TRIGGER LIVRO_BI FOR LIVRO
ACTIVE BEFORE INSERT POSITION 0
AS
begin
   new.id=gen_id(IDLIVRO, 1);
end;

CREATE OR ALTER TRIGGER RESERVA_LIVRO_BI FOR RESERVA_LIVRO
ACTIVE BEFORE INSERT POSITION 0
AS
begin
   new.id=gen_id(IDRESERVA_LIVRO, 1);
end;


