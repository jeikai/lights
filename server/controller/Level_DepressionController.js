const Level_depression = require("../models/Level_Depression");
const Emotion = require("../models/Emotion");
const Test = require("../models/Test");
module.exports = {
  createLevelDepression: async (req, res) => {
    try {
      const { userId, level } = req.body;

      const newLevelDepression = new Level_depression({ userId, level });
      const savedLevelDepression = await newLevelDepression.save();

      res.status(201).json(savedLevelDepression);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getLevelDepressionById: async (req, res) => {
    try {
      // Truy vấn Level_depression bằng ID
      const levelDepression = await Level_depression.find(req.params.id);

      if (!levelDepression) {
        return res.status(404).json({ message: "Level_depression không tồn tại" });
      }

      res.status(200).json(levelDepression);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateLevelDepression: async (req, res) => {
    try {
      const { userId } = req.body;
      const tests = await Test.findOne({ userId });
      let testAverage = tests.level;
      const emotion = await Emotion.find({ userId });
      let emotionAverage = 0;
      for (let i = 0; i < emotion.length; i++) {
        emotionAverage += emotion[i].emotion / emotion.length;
      }
      let result = (testAverage + emotionAverage) / 2;
      let roundedResult = Math.ceil(result);

      const updatedLevelDepression = await Level_depression.findOneAndUpdate(
        { userId: userId },
        { $set: { level: roundedResult } },
        { new: true }
      );

      if (!updatedLevelDepression) {
        return res.status(404).json({ message: "Level_depression không tồn tại" });
      }

      res.status(200).json(updatedLevelDepression);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteLevelDepression: async (req, res) => {
    try {
      // Xóa Level_depression bằng ID
      const deletedLevelDepression = await Level_depression.findByIdAndRemove(req.params.id);

      if (!deletedLevelDepression) {
        return res.status(404).json({ message: "Level_depression không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
