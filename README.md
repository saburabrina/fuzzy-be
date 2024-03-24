# Aplicação Ruby on Rails

Uma Aplicação em Ruby on Rails que dispõe de funcionalidades de cadastro, recuperação e submissão de pontuação a filmes, além de autenticação e criação de novos usuários.

Existem rotas especificas de criação de filmes e submissão de pontuações em massa executadas de forma assíncrona, utilizando o `sidekiq`.

Essa API foi criada para alimentar a aplicação no repositório: [FrontEnd](https://github.com/saburabrina/fuzzy-fe).

## Requisitos

- `ruby-3.1.4`
- `sqlite3`
- `redis`

Requisitos Opcionais:

- `docker`
- `foreman`

## Instalar Dependências

Vá na pasta root do projeto e rode no terminal:

- `bundle install`

Opcional:

- `gem install foreman`

## Inicializar Banco de Dados

Ao executar:

```ruby
rails db:migrate
rails db:seed
```

Será inicializado o banco de dados e configurado um usuário admin com credenciais:

- email: admin@rotten
- senha: admin

## Rodar Projeto

O projeto faz uso do `sidekiq` para rodar jobs em background, o `sidekiq` depende do `redis`. Esses dois precisam estar rodando para que as rotas de `POST /movies/many` e `POST /user_movies/many` do servidor rails funcionem.

```ruby
### Se tiver o foreman e o Docker instalado, para rodar o servidor basta:
foreman start

### Caso contrário:
# É preciso ter um redis rodando na porta 6379
# Caso possua Docker instalado, para rodar o redis basta rodar:
docker-compose up

# Para rodar o sidekiq, em outro terminal:
bundle exec sidekiq

# Para rodar o servidor rails, em outro terminal:
rails server
```

## Rodar testes

- `bundle exec rspec`
