const mongoose = require('mongoose');

const favoriteUserSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  favoriteId: { type: mongoose.Schema.Types.ObjectId, ref: 'Favorite' },
});

const Favorite_User = mongoose.model('Favorite_User', favoriteUserSchema);
