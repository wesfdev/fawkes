const express = require('express')
const { Socket } = require('phoenix-channels')
const app = express()
const bodyParser = require("body-parser");

const port = 3000
const sockerServer = "ws://localhost:4000/socket"
let socket = null
let channels = []

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.post('/join-channel',(request, response) => {
  let body = request.body
  console.log("Body to join channel: ", body);
  joinChannel(body)
  response.send('Channel Joined!')
});

app.post('/send-message',(request, response) => {
  let body = request.body
  console.log("Body to send message: ", body);
  sendMessage(body)
  response.send('Message Received!')
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`)
    socketHandler()
})

function socketHandler(){
    console.log("Start socket handler")
    let socketConn = new Socket(sockerServer)
    socketConn.connect()
    socket = socketConn
    return socket
}

function search(array, channel_id){
  return array.find(channel => channel.id === channel_id)
}

function joinChannel(params){
    let meta = params.meta
    let found = search(channels, meta.roomId);
    
    if(found){
      console.log(`Channel ${meta.roomId} exist`)
      return found.channel
    }else{
      console.log(`Channel ${meta.roomId} not exist`)
      let channel = socket.channel(`room:${meta.roomId}`, {userId: meta.userId})   
      channel.join()
      .receive("ok", resp => { console.log(`Joined to room: ${meta.roomId} successfully`, resp) })
      .receive("error", resp => { console.log(`Unable to join to room: ${meta.roomId}`, resp) })
      console.log("----> CHANNEL", channel)   
      channel.on("new_msg", msg => console.log("Got message", msg) )
      channels.push({id: meta.roomId, channel: channel})
      return channel
    }
}

function sendMessage(params){
  let channel = joinChannel(params)

  channel.push("new_msg", {payload: params.payload}, 10000)
  .receive("ok", (msg) => console.log("created message", msg) )
  .receive("error", (reasons) => console.log("create failed", reasons) )
}

