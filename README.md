# Valbernielson's Hamburgueria

Este projeto foi realiziado em uma entrevista

## Instalação

Foi utilizado ruby 2.3.3 e rails 5 para criação do projeto.
E banco de dados postresql.
Para auxiliar na instalção foi adicionado docker.

Para instalar os containers basta rodar na pasta do projeto(pode ser necessário sudo):

```bash
docker-compose build
```

## Uso
Com os containers baixados basta executar:
```
docker compose up
```

O container será inicializado na URL padrão do rails:
```
localhost:3000
```

Também será necessário criar o banco de dados, executar as migrações e popular o banco:
```
docker-compose run dsin rails db:create
docker-compose run dsin rails db:migrate
docker-compose run dsin rails db:seed
```


## Atividades obrigatórias

### Introdução
O sistema se baseia na necessidade de um dono de restaurante que precisa que seus clientes possam realizar pedidos online. Mesmo que não tenha sido requisitados conclui que haviar a necessidade de um sistema de login.
Logo para acessar as funcionalidades de cliente será necessário criar uma conta em: 
```
localhost:3000/client/sign_up
```
O sistema também pode ser acessado com um cliente criado para testes
Para isso basta acessar 
```
localhost:3000/client/sign_in
```
e utilizar 
```
email: teste@teste.com
senha: 123456
```

### Criação de pedidos
Ao realizar o login o usuário será redirecionado automáticamente para a tela de pedido. 
Aqui podemos ver primeiramente as abas, as quais incluem diferentes tipos de produtos.
Ao selecionar uma das abas os produtos são mostrados e podem ser adicionados ao clicar nas mesmas.
Para adicionar o produto basta clicar no "+" vermelho.

Você será redirecionado para um tela para escolher a quantidade e poderá confirmar no "✓" verde.

Ao confirmar você retornará para a tela de pedido onde encontramos agora um aviso que nos leva ao nosso pedido aberto.
Você pode selecionar mais produtos ou clicar no aviso vermelho para concluir seu pedido.

Nessa tela podemos remover algum produto caso tenha colocado algum a mais.
Caso não haja alterações clique em confirmar para enviar seu pedido para o restaurante.

Como a mensagem nos informa você ainda pode adicionar ou remover itens do seu pedido, porém depois que o restaurante confirmar isso não será mais possivel pelo sistemas, apenas ligando no restaurante.

### Histórico de pedidos
Na tela de pedido se reparmos no topo tem um aviso azul que permite visualizar os pedido realizados.

### Detalhes do Pedido
Na tela de histórico é possível visualizar os detalhes do pedido.

## Opcionais
**Antes de realizar estes passos, deslogar da área do cliente ao clicar em "Sair" em qualquer tela.**
Para a parte opcional foi criado um segundo login de administrador.
Que pode ser acessado em:
```
localhost:3000/admins/sign_in
```
e utilizar 
```
email: admin@admin.com
senha: 123456
```
### Alterar Pedidos e Status
```
localhost:3000/admin/orders
```
Possui todos os pedidos separados por status, onde podem ser acessados e alterados.

O Status do pedido pode ser alterado para indicar que o pedido foi recebido pelo restaurante, está em preparo, está pronto, foi enviado e foi encerrado.

### Relatórios
Os relatórios pode ser acessados em 
```
localhost:3000/admins/report
```
aqui encotramos 2 opções:

A primeira requistada pela tarefa demonstra o desempenho do restaurante por semanas.

O segundo que foi realizado como um extra, exibe os ultimos 7 dias de forma mais reduzida.

# Sugestões
Foi implementado 2 sugestões;
## Pedir novamente
Sugestão para a área do Cliente
A sugestão foi de que apareça para o cliente os últimos pedidos realizados por ele e que ele possa pedir novamente.
Os pedidos aqui só são exibidos quando estão com o status "Encerrado".
Caso queria testar com um pedido criado é necessário entrar na área do administrador e deixar o pedido com status finalizado.


Aqui o pedido apara com a opção de ver detalhes ou com o botão "pedir". que ao ser clicado já cria automaticamente um pedido com esses itens. E fica aberto para que o cliente possa adicionar algo ou remover algo.

O pedido precisa ser confirmado pelo usuário. 

## Mais pedido do restaurante
O produto mais pedido aparecerá com uma estrela e um texto, incentivando o usuário a comprar.

A contagem só é realizada por pedidos "ENCERRADO", caso queira testar será necessário fazer um pedido com uma grande quantidade de um mesmo produto(20+) e encerrar o pedido pela area do administrador.

## PrintScreens

Os prints das telas foram adicionados na pasta rais do projeto: 

https://github.com/phazevedo/dsin/tree/master/PrintScreen/

Estrutura do banco de dados:

![alt BS](https://github.com/phazevedo/dsin/tree/master/PrintScreen/BDv2.png)

Online também em 

https://dsin-rails.herokuapp.com/ 