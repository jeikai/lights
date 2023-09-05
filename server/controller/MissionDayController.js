const MissionDay = require("../models/MissionDay");

module.exports = {
  createMissionDay: async (req, res) => {
    try {
      const { emotionId, missionId, checkCompleted } = req.body;

      // Tạo một bản ghi mới cho MissionDay
      const newMissionDay = new MissionDay({ emotionId, missionId, checkCompleted });

      // Lưu bản ghi MissionDay vào cơ sở dữ liệu
      const savedMissionDay = await newMissionDay.save();

      res.status(201).json(savedMissionDay);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getMissionDays: async (req, res) => {
    try {
      // Truy vấn tất cả các bản ghi trong MissionDay
      const missionDays = await MissionDay.find();

      res.status(200).json(missionDays);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  getMissionDayById: async (req, res) => {
    try {
      // Truy vấn MissionDay bằng ID
      const missionDay = await MissionDay.findById(req.params.id);

      if (!missionDay) {
        return res.status(404).json({ message: "MissionDay không tồn tại" });
      }

      res.status(200).json(missionDay);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  updateMissionDay: async (req, res) => {
    try {
      // Cập nhật MissionDay bằng ID
      const updatedMissionDay = await MissionDay.findByIdAndUpdate(
        req.params.id,
        { $set: req.body },
        { new: true }
      );

      if (!updatedMissionDay) {
        return res.status(404).json({ message: "MissionDay không tồn tại" });
      }

      res.status(200).json(updatedMissionDay);
    } catch (error) {
      res.status(500).json(error);
    }
  },

  deleteMissionDay: async (req, res) => {
    try {
      // Xóa MissionDay bằng ID
      const deletedMissionDay = await MissionDay.findByIdAndRemove(req.params.id);

      if (!deletedMissionDay) {
        return res.status(404).json({ message: "MissionDay không tồn tại" });
      }

      res.status(204).json();
    } catch (error) {
      res.status(500).json(error);
    }
  },
};
