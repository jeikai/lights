const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const port = process.env.PORT || 5000;
const authRouter = require("./routes/auth")
const userRouter = require("./routes/user")
dotenv.config();
app.use(express.json());
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

app.use("/api/", userRouter)

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
