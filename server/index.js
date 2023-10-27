const express = require("express");
const app = express();
const cors = require('cors');
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const port = process.env.PORT || 5000;
const routers = require("./routes/route")
// const socket = require("socket.io");
const http = require('http');
const serverHttp = http.createServer(app);
const { Server } = require("socket.io");
const { Socket } = require("dgram");
const io = new Server(serverHttp);

dotenv.config();
app.use(express.json());
app.use(cors());
app.use(
  express.urlencoded({
    extended: true,
  })
);
mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log("Connected");
  })
  .catch((err) => {
    console.log(err);
  });

app.use("/api/", routers);

const server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});


// const io = socket(server, {
//   cors: {
//     origin: "*",
//     credentials: true,
//   },
// });
// //tất cả người dùng được lưu ở đây
// global.onlineUsers = new Map();
// io.on("connection", (socket) => {
//   console.log("connected")
//   global.chatSocket = socket;
//   socket.on("add-user", (userId) => {
//     onlineUsers.set(userId, socket.id);
//   });

//   socket.on("send-msg", (data) => {
//     const sendUserSocket = onlineUsers.get(data.to);
//     //Nếu người dùng online
//     if (sendUserSocket) {
//       socket.to(sendUserSocket).emit("msg-receive", {
//         "msg": data.msg,
//         "time": data.time
//       });
//     }
//   });
// });
io.on('connection', (socket) => {
  const userId = socket.handshake.query.userId;
  socket.on('message', (data) => {
    const message = {
      "msg": data.msg,
      "time": data.time,
      "from": userId
    }
    io.emit('message', message)
  })
})