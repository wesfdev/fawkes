# Fawkes Chat
Real time chat application with Elixir, Phoenix and Express as client

It's recommended to use [docker-compose](https://docs.docker.com/compose/) to bring up the infrastructures.

```sh
docker-compose up -d postgres
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## Server endpoints to test

***Server ping:***
```javascript
curl --location --request GET 'http://localhost:4000/api/ping'
```

***Create rooms:***
```javascript
curl --location --request POST 'http://localhost:4000/api/rooms' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "global",
    "desc": "Test global room"
}'
```

***Room List:***
```javascript
curl --location --request GET 'http://localhost:4000/api/rooms'
```

***Message list:***
```javascript
curl --location --request GET 'http://localhost:4000/api/messages'
```

## Client
To connect a client you can go to the following route and all the instructions on how to connect and the payloads appear in the README.md
```sh
cd socket_client
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
