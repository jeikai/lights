const app = require("express").Router();
const authController = require("../controller/authController");

app.post("/register", authController.createUser)
app.post("/login", authController.loginUser)

module.exports = app