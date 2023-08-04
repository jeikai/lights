const mongoose = require('mongoose');

const diemDanhSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  day: { type: Date, default: Date.now },
  check: { type: Number, default: 0 },
});

const DiemDanh = mongoose.model('DiemDanh', diemDanhSchema);
