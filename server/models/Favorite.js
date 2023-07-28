const mongoose = require('mongoose');

const favoriteSchema = new mongoose.Schema({
  description: { type: String },
});

const Favorite = mongoose.model('Favorite', favoriteSchema);
