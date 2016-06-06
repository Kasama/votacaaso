Vota Caaso
==========

Objetivo
--------
O Objetivo dessa aplicação é servir como uma forma democrática de computar votos a favor e contra uma possível greve do Caaso.

Funcionamento
-------------
O app usa o [sistema de verificação de documentos da USP][1] para verificar a matrícula de cada aluno. Esse sistema devolve o Atestado de Matrícula (como PDF) que é lido para extrair as informações do aluno (Nome, Nº USP, RG e Curso). Essas informações são colocadas no banco de dados em conjunto com o voto de cada um. (vide [privacidade](#privacy))

Segurança
---------
O app foi testado contra os ataques web mais comuns, não foi possível invadir o sistema dessa forma.

O sistema é seguro também contra ataques do tipo __brute force__, pois é necessário preencher um campo __captcha__ para cada voto

Execução
--------
Para os clientes, apenas um navegador web (Como [Firefox][5] ou [Chrome][6])

Para o servidor, é necessário instalar [Ruby][2], [Bundler][3] e [PostgreSQL][4].

Clonar o repositório localmente:
```bash
git clone http://github.com/Kasama/votacaaso.git
cd votacaaso
```
Executar o Bundler
```bash
bundler install
```
Executar o app
```bash
rails server
```

## <a name="privacy"></a> Privacidade

O app não guarda o RG dos usuários por questões de privacidade. Apenas os 2 primeiros e 2 últimos dígitos são guardados, no formato 00\*\*\*\*\*00.

O número USP é guardado na íntegra, porém não é mostrado aos outros usuários, sendo mascarado de forma similar ao RG, deixando visíveis apenas os 2 primeiros e 2 últimos dígitos. Esse número é importante para garantir que um mesmo aluno não vote duas vezes e para permitir alteração do voto

[1]: uspdigital.usp.br/webdoc
[2]: https://www.ruby-lang.org/en/
[3]: https://rubygems.org/gems/bundler
[4]: https://www.postgresql.org/
[5]: https://www.mozilla.org/en-US/firefox/new/
[6]: https://www.google.com/chrome/
