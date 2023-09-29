const User = require("../models/User");
const cryptoJS = require("crypto-js");
const UserData = require("../models/UserData");

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
  checkExistedEmail: async (req, res) => {
    try {
      const email = req.body.email;
      const existingUser = await User.findOne({ email });

      if (existingUser) {
        return res.json({ exists: true });
      } else {
        return res.json({ exists: false });
      }
    } catch (error) {
      res.status(500).json(error)
    }
  },
  getUser: async (req, res) => {
    try {
      const userData = await User.findById(req.params.id).select('-password');
      res.status(200).json(userData);
    } catch (error) {
      res.status(500).json(error);
    }
  },
  createUser: async (req, res) => {
    const dateString = req.body.DOB;
    const parts = dateString.split("/");
    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10);
    const year = parseInt(parts[2], 10);
    const dob = new Date(year, month - 1, day);
    const newUser = new User({
      name: req.body.name,
      email: req.body.email,
      phoneNumber: req.body.phoneNumber,
      address: req.body.address,
      DOB: dob,
      password: cryptoJS.AES.encrypt(req.body.password, process.env.SECRET_KEY).toString(),
    });
    console.log(newUser)
    try {
      const savedUser = await newUser.save();
      res.status(200).json(savedUser);
    } catch (error) {
      res.status(400).json(error)
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
  },
  getUserDataById: async (req, res) => {
    try {
      console.log(req.params.id);
      const userData = await UserData.findById(req.params.id);
      if (!userData) {
        let newUserData = await UserData({
          _id: req.params.id,
          bio: "Whaly's bio",
          socialConnections: [],
        });
        const savedUserData = await newUserData.save();
        res.status(200).json({ userData: newUserData, message: true });
      }
    } catch (error) {
      console.log(error);
      res.status(500).json(error)
    }
  },
  updateSocialConnection: async (req, res) => {
    const userDataId = req.params.id;
    const { socialConnections } = req.body.s;

    try {
      const userData = await UserData.findByIdAndUpdate(userDataId, { $set: { socialConnections } }, { new: true }).select('-password');
      res.json(userData);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
  updateBio: async (req, res) => {
    const userDataId = req.params.id;
    const { bio } = req.body;

    try {
      const userData = await UserData.findByIdAndUpdate(userDataId, { $set: { bio } }, { new: true }).select('-password');
      res.json(userData);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
  updateAddress: async (req, res) => {
    const userId = req.params.id;
    const { address } = req.body;

    try {
      const user = await User.findByIdAndUpdate(userId, { $set: { address } }, { new: true }).select('-password');
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
  updateName: async (req, res) => {
    const userId = req.params.id;
    const { name } = req.body;

    try {
      const user = await User.findByIdAndUpdate(userId, { $set: { name } }, { new: true }).select('-password');
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
  updatePhoneNo: async (req, res) => {
    const userId = req.params.id;
    const { phoneNumber } = req.body;

    try {
      const user = await User.findByIdAndUpdate(userId, { $set: { phoneNumber } }, { new: true }).select('-password');
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
  updateDOB: async (req, res) => {
    const userId = req.params.id;
    const { DOB } = req.body;

    try {
      const user = await User.findByIdAndUpdate(userId, { $set: { DOB } }, { new: true }).select('-password');
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};
