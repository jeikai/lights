const mongoose = require('mongoose');

const levelDepressionSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  level: { type: Number, enum: [0, 1, 2, 3, 4], default: 0 },
});

const Level_depression = mongoose.model('Level_depression', levelDepressionSchema);
