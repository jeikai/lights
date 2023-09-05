const Gift = require("../models/Gift");

module.exports = {
  createGift: async (req, res) => {
    try {
      const { check } = req.body;

      // Tạo một bản ghi mới cho Gift
      const newGift = new Gift({ check });

      // Lưu bản ghi Gift vào cơ sở dữ liệu
      const savedGift = await newGift.save();

      res.status(201).json(savedGift);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getGifts: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Gift
      const gifts = await Gift.find();

      res.status(200).json(gifts);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getGiftById: async (req, res) => {
    try {
      // Truy vấn Gift bằng ID
      const gift = await Gift.findById(req.params.id);

      if (!gift) {
        return res.status(404).json({ message: "Gift không tồn tại" });
      }

      res.status(200).json(gift);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateGift: async (req, res) => {
    try {
      // Cập nhật Gift bằng ID
      const updatedGift = await Gift.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedGift) {
        return res.status(404).json({ message: "Gift không tồn tại" });
      }

      res.status(200).json(updatedGift);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteGift: async (req, res) => {
    try {
      // Xóa Gift bằng ID
      const deletedGift = await Gift.findByIdAndRemove(req.params.id);

      if (!deletedGift) {
        return res.status(404).json({ message: "Gift không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
