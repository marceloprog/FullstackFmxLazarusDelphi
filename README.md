# FullstackFmxLazarusDelphi
Api desenvolvida e Lazarus e Delphi com Aplicativo de consumo para Firemonkey


API Horse com firebird em 2 versões
Rad Studio 10.2 Tokio
Lazarus 2.2.0

Aplicativo para acesso a api desenvolvida em Firemonkey

A api tem a função de fazer o cadastro e reserva de livros.

Configurar BD.INI que fica na pasta do Executavel

Script e Base (Books.fdb) na pasta BD.


Enpoints
LIVRO

GET
http://localhost:9000/books
http://localhost:9000/books/3

POST
http://localhost:9000/books
{"nome":"projeto gof avancado",
"descricao":"gof avancado",
"autor":"marcelo ",
"status":0
}

PUT
{"nome":"projetoput",
"descricao":"gof put",
"autor":"marcelo ",
"status":1
}

DELETE
http://localhost:9000/books/3

RESERVA DE LIVRO

GET
http://localhost:9000/reservations
http://localhost:9000/reservations/12

POST

{
    "nome": "marcelo",
    "cpf": "44444444444",
    "email": "marcelo@email.com",
    "telefone": "31996180000",
    "data":"2024-04-15",
    "itens": [
        {
            "idLivro": 1
        },
        {
            "idLivro": 2
        },
        {
            "idLivro": 15
        }
    ]
}



