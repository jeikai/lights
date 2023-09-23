const mongoose = require('mongoose');

const missionDaySchema = new mongoose.Schema({
  missionId: { type: mongoose.Schema.Types.ObjectId, ref: 'Mission' },
  day: { type: Date, default: Date.now },
  checkCompleted: { type: Boolean, default: false },
});

const MissionDay = mongoose.model('MissionDay', missionDaySchema);
