const mongoose = require('mongoose');

const emotionSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  emotion: { type: Number, enum: [0, 1, 2, 3, 4] },
  time: { type: Date, default: Date.now },
});

const Emotion = mongoose.model('Emotion', emotionSchema);

module.exports = Emotion;