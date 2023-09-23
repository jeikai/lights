const Mission = require("../models/Mission");

module.exports = {

  getMissions: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong Mission
      const missions = await Mission.find();

      res.status(200).json(missions);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getMissionById: async (req, res) => {
    try {
      // Truy vấn Mission bằng ID
      const mission = await Mission.findById(req.params.id);

      if (!mission) {
        return res.status(404).json({ message: "Mission không tồn tại" });
      }

      res.status(200).json(mission);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateMission: async (req, res) => {
    try {
      // Cập nhật Mission bằng ID
      const updatedMission = await Mission.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedMission) {
        return res.status(404).json({ message: "Mission không tồn tại" });
      }

      res.status(200).json(updatedMission);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteMission: async (req, res) => {
    try {
      // Xóa Mission bằng ID
      const deletedMission = await Mission.findByIdAndRemove(req.params.id);

      if (!deletedMission) {
        return res.status(404).json({ message: "Mission không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
