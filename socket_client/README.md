# Chat - Connect Elixir Socket with JS
Real time chat application with Elixir, Phoenix and Express as client

Start app:

  * Install dependencies with `npm install`
  * Run server with `npm run start`


## Client endpoints to test

***Join channel:***
```javascript
curl --location --request POST 'http://localhost:3000/join-channel' \
--header 'Content-Type: application/json' \
--data-raw '{
    "meta": {
        "userId": 1235,
        "roomId": "1"
    }
}'
```

***Send message:***
```javascript
curl --location --request POST 'http://localhost:3000/send-message' \
--header 'Content-Type: application/json' \
--data-raw '{
    "meta": {
        "userId": 1235,
        "roomId": "1"
    },
    "payload": {
        "content": "este es otro mensaje"
    }
}'
```


## Learn more
  * https://www.npmjs.com/package/phoenix-channels
  * https://www.npmjs.com/package/phoenix
  * https://hexdocs.pm/phoenix/js/index.htm

