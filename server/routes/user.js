const app = require("express").Router();
// const authController = require("../controller/authController");
const userController = require("../controller/userController");
// const { verifyAndAuthorization } = require("../middleware/verifyToken");

app.post("/register", userController.createUser)
app.post("/login", userController.loginUser)

// app.put("/user/:id", verifyAndAuthorization, userController.updateUser)
app.get("/user/getInfor/:id", userController.getUser);

// app.post("/", verifyAndAuthorization);
module.exports = app