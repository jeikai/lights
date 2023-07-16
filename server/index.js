const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const port = process.env.PORT || 5000;
dotenv.config();

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log("Connected");
  })
  .catch((err) => {
    console.log(err);
  });

app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.get("/", (req, res) => {
  res.send("Hello");
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
