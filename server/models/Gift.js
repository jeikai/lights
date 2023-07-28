const mongoose = require('mongoose');

const giftSchema = new mongoose.Schema({
  check: { type: Boolean, default: false },
});

const Gift = mongoose.model('Gift', giftSchema);
