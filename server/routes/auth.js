const app = require("express").Router();
const authController = require("../controller/authController");

app.post("/register", authController.createUser)

module.exports = app