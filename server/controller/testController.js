const Test = require("../models/Test");
const mongoose = require("mongoose")
module.exports = {
  createTest: async (req, res) => {
    try {
      const { userId, level } = req.body;
      console.log(userId, "haha")
      console.log(mongoose.Types.ObjectId(userId));
      const newTest = new Test({ userId, level });
      console.log("haha")
      console.log(newTest);
      const savedTest = await newTest.save();
      res.status(201).json(savedTest);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getTests: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Test
      const tests = await Test.find();

      res.status(200).json(tests);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getTestById: async (req, res) => {
    try {
      // Truy vấn Test bằng ID
      const test = await Test.findById(req.params.id);

      if (!test) {
        return res.status(404).json({ message: "Test không tồn tại" });
      }

      res.status(200).json(test);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateTest: async (req, res) => {
    try {
      // Cập nhật Test bằng ID
      const updatedTest = await Test.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedTest) {
        return res.status(404).json({ message: "Test không tồn tại" });
      }

      res.status(200).json(updatedTest);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteTest: async (req, res) => {
    try {
      // Xóa Test bằng ID
      const deletedTest = await Test.findByIdAndRemove(req.params.id);

      if (!deletedTest) {
        return res.status(404).json({ message: "Test không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
