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
    } catch (err) { }
  },
  getUser: async (req, res) => {
    try {
      const data = await User.findById(req.params.id);
      const { password, _v, createdAt, updatedAt, ...userData } = data._doc;

      res.status(200).json(userData)
    } catch (error) {
      res.status(500).json(error)
    }
  },
  createUser: async (req, res) => {
    const newUser = new User({
      name: req.body.name,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      address: req.body.address,
      age: req.body.age,
      password: cryptoJS.AES.encrypt(req.body.password, process.env.SECRET_KEY).toString(),
    });

    try {
      const savedUser = await newUser.save();
      res.status(201).json(savedUser);
    } catch (error) {
      res.status(500).json(error)
    }
  },
  loginUser: async (req, res) => {
    try {
      const user = await User.findOne({
        email: req.body.email
      })
      if (!user) {
        res.status(200).json({ message: false })
      } else {

        const de_pass = cryptoJS.AES.decrypt(user.password, process.env.SECRET_KEY);
        const depassword = de_pass.toString(cryptoJS.enc.Utf8);
        if (depassword != req.body.password) {
          res.status(400).json({ message: false })
        } else {
          res.status(200).json({ user: user, message: true })
        }

      }
    } catch (error) {
      res.status(500).json(error)
    }
  }
};
