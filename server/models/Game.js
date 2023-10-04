const mongoose = require('mongoose');

const GameSchema = new mongoose.Schema({
    title: {type: String, default: ''},
    image: {type: String, default: ''},
    genre: {type: String, default: ''},
    path: {type: String, default: 'https://www.google.com/'},
});

const Game = mongoose.model('Game', GameSchema);

module.exports = Game;