const DiemDanh = require("../models/DiemDanh");

module.exports = {
  createDiemDanh: async (req, res) => {
    try {
      const { userId, day, check } = req.body;

      // Tạo một bản ghi mới cho DiemDanh
      const newDiemDanh = new DiemDanh({ userId, day, check });

      // Lưu bản ghi DiemDanh vào cơ sở dữ liệu
      const savedDiemDanh = await newDiemDanh.save();

      res.status(201).json(savedDiemDanh);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getDiemDanhs: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong DiemDanh
      const diemDanhs = await DiemDanh.find();

      res.status(200).json(diemDanhs);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getDiemDanhById: async (req, res) => {
    try {
      // Truy vấn DiemDanh bằng ID
      const diemDanh = await DiemDanh.findById(req.params.id);

      if (!diemDanh) {
        return res.status(404).json({ message: "DiemDanh không tồn tại" });
      }

      res.status(200).json(diemDanh);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateDiemDanh: async (req, res) => {
    try {
      // Cập nhật DiemDanh bằng ID
      const updatedDiemDanh = await DiemDanh.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedDiemDanh) {
        return res.status(404).json({ message: "DiemDanh không tồn tại" });
      }

      res.status(200).json(updatedDiemDanh);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteDiemDanh: async (req, res) => {
    try {
      // Xóa DiemDanh bằng ID
      const deletedDiemDanh = await DiemDanh.findByIdAndRemove(req.params.id);

      if (!deletedDiemDanh) {
        return res.status(404).json({ message: "DiemDanh không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
