const Favorite = require("../models/Favorite");

module.exports = {
  createFavorite: async (req, res) => {
    try {
      const { description } = req.body;

      // Tạo một bản ghi mới cho Favorite
      const newFavorite = new Favorite({ description });

      // Lưu bản ghi Favorite vào cơ sở dữ liệu
      const savedFavorite = await newFavorite.save();

      res.status(201).json(savedFavorite);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getFavorites: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Favorite
      const favorites = await Favorite.find();

      res.status(200).json(favorites);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getFavoriteById: async (req, res) => {
    try {
      // Truy vấn Favorite bằng ID
      const favorite = await Favorite.findById(req.params.id);

      if (!favorite) {
        return res.status(404).json({ message: "Favorite không tồn tại" });
      }

      res.status(200).json(favorite);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateFavorite: async (req, res) => {
    try {
      // Cập nhật Favorite bằng ID
      const updatedFavorite = await Favorite.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedFavorite) {
        return res.status(404).json({ message: "Favorite không tồn tại" });
      }

      res.status(200).json(updatedFavorite);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteFavorite: async (req, res) => {
    try {
      const deletedFavorite = await Favorite.findByIdAndRemove(req.params.id);

      if (!deletedFavorite) {
        return res.status(404).json({ message: "Favorite không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
