const mongoose = require('mongoose');

const missionDaySchema = new mongoose.Schema({
  emotionId: { type: mongoose.Schema.Types.ObjectId, ref: 'Emotion' },
  missionId: { type: mongoose.Schema.Types.ObjectId, ref: 'Mission' },
  checkCompleted: { type: Boolean, default: false },
});

const MissionDay = mongoose.model('MissionDay', missionDaySchema);
