const Level_depression = require("../models/Level_Depression");

module.exports = {
  createLevelDepression: async (req, res) => {
    try {
      const { userId, level } = req.body;

      // Tạo một bản ghi mới cho Level_depression
      const newLevelDepression = new Level_depression({ userId, level });

      // Lưu bản ghi Level_depression vào cơ sở dữ liệu
      const savedLevelDepression = await newLevelDepression.save();

      res.status(201).json(savedLevelDepression);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getLevelDepressions: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Level_depression
      const levelDepressions = await Level_depression.find();

      res.status(200).json(levelDepressions);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getLevelDepressionById: async (req, res) => {
    try {
      // Truy vấn Level_depression bằng ID
      const levelDepression = await Level_depression.findById(req.params.id);

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
      // Cập nhật Level_depression bằng ID
      const updatedLevelDepression = await Level_depression.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
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
