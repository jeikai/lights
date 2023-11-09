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

  emotionChart: async (req, res) => {
    try {
      const userId = req.params.id;

      // Truy vấn tất cả các bản ghi cảm xúc của người dùng theo userId
      const emotions = await Emotion.find({ userId });

      if (!emotions) {
        return res.status(404).json({ message: "Emotion không tồn tại" });
      }

      // Tạo một object để lưu trữ thống kê theo tháng
      const monthlyStats = {};

      // Lặp qua tất cả các bản ghi cảm xúc và tính trung bình theo tháng
      emotions.forEach((emotion) => {
        const monthYear = emotion.time.toISOString().substring(0, 7); // Lấy chuỗi năm-tháng (yyyy-MM)
        if (!monthlyStats[monthYear]) {
          monthlyStats[monthYear] = { totalEmotion: 0, count: 0 };
        }
        monthlyStats[monthYear].totalEmotion += emotion.emotion;
        monthlyStats[monthYear].count++;
      });

      // Tạo mảng kết quả chứa trung bình cảm xúc của từng tháng
      const result = [];

      // Lặp qua object thống kê và tính trung bình, sau đó thêm vào mảng kết quả
      for (const monthYear in monthlyStats) {
        const { totalEmotion, count } = monthlyStats[monthYear];
        const averageEmotion = totalEmotion / count;
        const roundedAverageEmotion = Math.round(averageEmotion); // Làm tròn kết quả
        result.push(roundedAverageEmotion); // Thêm trung bình cảm xúc đã được làm tròn vào mảng kết quả
      }
      res.status(200).json(result);
    } catch (error) {
      res.status(500).json(error);
    }
  },

};
 