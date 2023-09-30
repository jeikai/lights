const mongoose = require('mongoose');

const missionDaySchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  missionId: { type: mongoose.Schema.Types.ObjectId, ref: 'Mission' },
  day: { type: Date, default: Date.now },
  checkCompleted: { type: Boolean, default: false}
});

const MissionDay = mongoose.model('MissionDay', missionDaySchema);

module.exports = MissionDay;