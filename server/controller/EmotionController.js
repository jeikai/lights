const Emotion = require("../models/Emotion");

module.exports = {
  createEmotion: async (req, res) => {
    try {
      const { userId, emotion } = req.body;

      const newEmotion = new Emotion({ userId, emotion });

      // Lưu bản ghi Emotion vào cơ sở dữ liệu
      const savedEmotion = await newEmotion.save();

      res.status(200).json(savedEmotion);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getEmotions: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Emotion
      const emotions = await Emotion.find();

      res.status(200).json(emotions);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getEmotionById: async (req, res) => {
    try {
      // Truy vấn Emotion bằng ID
      const emotion = await Emotion.find({ userId: req.params.id});

      if (!emotion) {
        return res.status(404).json({ message: "Emotion không tồn tại" });
      }

      res.status(200).json(emotion);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateEmotion: async (req, res) => {
    try {
      // Cập nhật Emotion bằng ID
      const updatedEmotion = await Emotion.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedEmotion) {
        return res.status(404).json({ message: "Emotion không tồn tại" });
      }

      res.status(200).json(updatedEmotion);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteEmotion: async (req, res) => {
    try {
      // Xóa Emotion bằng ID
      const deletedEmotion = await Emotion.findByIdAndRemove(req.params.id);

      if (!deletedEmotion) {
        return res.status(404).json({ message: "Emotion không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
