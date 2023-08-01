const app = require("express").Router();
const authController = require("../controller/authController");
const userController = require("../controller/userController");
const { verifyAndAuthorization } = require("../middleware/verifyToken");

app.post("/register", authController.createUser)
app.post("/login", authController.loginUser)

app.put("/user/:id", verifyAndAuthorization, userController.updateUser)
app.get("/user/getInfor/:id", verifyAndAuthorization, userController.getUser);

app.post("/");
module.exports = app