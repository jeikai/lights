const MissionDay = require("../models/MissionDay");
const Level_depression = require("../models/Level_Depression");
const Mission = require("../models/Mission");

function shuffleArray(array) {
  for (let i = array.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [array[i], array[j]] = [array[j], array[i]];
  }
  return array;
}

module.exports = {
  createMissionDay: async (req, res) => {
    try {
      const { userId } = req.body;

      const Level_Depression = await Level_depression.findOne({ userId });
      const Missions = await Mission.find({emotion: Level_Depression.level});
      shuffleArray(Missions);
      const randomMissions = Missions.slice(0, 4);
      const missionDayRecords = [];

      for (let i = 0; i < randomMissions.length; i++) {
        const missionId = randomMissions[i]._id;

        // Tạo một bản ghi mới trong bảng MissionDay
        const missionDayRecord = new MissionDay({
          userId: userId,
          missionId: missionId,
        });

        // Lưu bản ghi mới vào cơ sở dữ liệu
        await missionDayRecord.save();

        // Thêm bản ghi vào mảng missionDayRecords
        missionDayRecords.push(missionDayRecord);
      }
      res.status(201).json(missionDayRecords);
    } catch (error) { 
      res.status(500).json(error);
    }
  },

  getMissionDayById: async (req, res) => {
    try {
      const userId = req.params.id;
      const missionDays = await MissionDay.find({ userId })
        .populate({
          path: "missionId",
          model: "Mission",
          select: "description",
        });
  
      if (!missionDays) {
        return res.status(404).json({ message: "MissionDay không tồn tại" });
      }
  
      res.status(200).json(missionDays);
    } catch (error) {
      res.status(500).json(error);
    }
  },
  deleteMissionDayById: async (req, res) => {
    try {
      // Xóa MissionDay bằng ID
      const deletedMissionDay = await MissionDay.findByIdAndRemove(req.params.id);

      if (!deletedMissionDay) {
        return res.status(404).json({status: false});
      }

      res.status(204).json({ status: true });
    } catch (error) {
      res.status(500).json(error);
    }
  },
  deleteAllMissionDayByUserId: async (req, res) => {
    try {
      const userId = req.params.id;
  
      // Xóa tất cả các bản ghi có userId giống với giá trị trong tham số yêu cầu
      const result = await MissionDay.deleteMany({ userId });
  
      if (result.deletedCount === 0) {
        return res.status(404).json({ status: false });
      }
  
      res.status(204).json({ status: true });
    } catch (error) {
      res.status(500).json(error);
    }
  }  
};
