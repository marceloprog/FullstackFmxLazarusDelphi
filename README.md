# FullstackFmxLazarusDelphi
Api desenvolvida e Lazarus e Delphi com Aplicativo de consumo para Firemonkey

API Horse com firebird em 2 versões
Rad Studio 10.2 Tokio
Lazarus 2.2.0

Aplicativo para acesso a api desenvolvida em Firemonkey

A api tem a função de fazer o cadastro e reserva de livros.

Configurar BD.INI que fica na pasta do Executavel

Script e Base (Books.fdb) na pasta BD.


POST
http://localhost:9000/v1/tarefas
{"nometarefa":"desenvolvimento",
"responsavel":"marcelo",
"status":"A",
"prioridade":1
}

PUT
http://localhost:9000/v1/tarefas
{"id":2,
"status":"F"
}


DELETE
http://localhost:9000/v1/tarefas/2

GET
http://localhost:9000/v1/tarefas

GET para estatistica
http://localhost:9000/v1/tarefas/estatistica

