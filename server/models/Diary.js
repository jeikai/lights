const mongoose = require('mongoose');

const diarySchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  time: { type: Date, default: Date.now },
  content: { type: String },
});

const Diary = mongoose.model('Diary', diarySchema);
