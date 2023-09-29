const mongoose = require('mongoose');

const testSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  level: { type: Number, enum: [0, 1, 2, 3, 4], default: 0 },
});

const Test = mongoose.model('Test', testSchema);
