const Favorite_User = require("../models/Favorite_User");

module.exports = {
  createFavoriteUser: async (req, res) => {
    try {
      const { userId, favoriteId } = req.body;

      // Tạo một bản ghi mới cho Favorite_User
      const newFavoriteUser = new Favorite_User({ userId, favoriteId });

      // Lưu bản ghi Favorite_User vào cơ sở dữ liệu
      const savedFavoriteUser = await newFavoriteUser.save();

      res.status(201).json(savedFavoriteUser);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getFavoriteUsers: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Favorite_User
      const favoriteUsers = await Favorite_User.find();

      res.status(200).json(favoriteUsers);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getFavoriteUserById: async (req, res) => {
    try {
      // Truy vấn Favorite_User bằng ID
      const favoriteUser = await Favorite_User.findById(req.params.id);

      if (!favoriteUser) {
        return res.status(404).json({ message: "Favorite_User không tồn tại" });
      }

      res.status(200).json(favoriteUser);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateFavoriteUser: async (req, res) => {
    try {
      // Cập nhật Favorite_User bằng ID
      const updatedFavoriteUser = await Favorite_User.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedFavoriteUser) {
        return res.status(404).json({ message: "Favorite_User không tồn tại" });
      }

      res.status(200).json(updatedFavoriteUser);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteFavoriteUser: async (req, res) => {
    try {
      // Xóa Favorite_User bằng ID
      const deletedFavoriteUser = await Favorite_User.findByIdAndRemove(req.params.id);

      if (!deletedFavoriteUser) {
        return res.status(404).json({ message: "Favorite_User không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
