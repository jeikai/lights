const User = require("../models/User");
const cryptoJS = require("crypto-js");

module.exports = {
  updateUser: async (req, res) => {
    if (req.body.password) {
      req.body.password = cryptoJS.AES.encrypt(
        req.body.password,
        process.env.SECRET_KEY
      ).toString();
    }

    try {
      const UpdateUser = await User.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );
      res.status.json("Update thanh cong")
    } catch (err) {}
  },
  getUser: async (req, res) => {
    try {
      const data = await User.findById(req.params.id);
      const {password, _v, createdAt, updatedAt, ...userData} = data._doc;

      res.status(200).json(userData)
    } catch (error) {
      res.status(500).json(error)
    }
  }
};
