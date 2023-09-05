const Diary = require("../models/Diary");

module.exports = {
  insertDiary: async (req, res) => {
    try {
      const { userId, time, content } = req.body;

      // Tạo một bản ghi mới cho Diary
      const newDiary = new Diary({ userId, time, content });

      // Lưu bản ghi Diary vào cơ sở dữ liệu
      const savedDiary = await newDiary.save();

      res.status(201).json(savedDiary);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getDiaries: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Diary
      const diaries = await Diary.find();

      res.status(200).json(diaries);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getDiaryById: async (req, res) => {
    try {
      // Truy vấn Diary bằng ID
      const diary = await Diary.findById(req.params.id);

      if (!diary) {
        return res.status(404).json({ message: "Diary không tồn tại" });
      }

      res.status(200).json(diary);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateDiary: async (req, res) => {
    try {
      // Cập nhật Diary bằng ID
      const updatedDiary = await Diary.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedDiary) {
        return res.status(404).json({ message: "Diary không tồn tại" });
      }

      res.status(200).json(updatedDiary);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteDiary: async (req, res) => {
    try {
      // Xóa Diary bằng ID
      const deletedDiary = await Diary.findByIdAndRemove(req.params.id);

      if (!deletedDiary) {
        return res.status(404).json({ message: "Diary không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
