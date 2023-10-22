const mongoose = require('mongoose');

const SongSchema = new mongoose.Schema({
    title: {type: String, default: ''},
    description: {type: String, default: ''},
    url: {type: String, default: 'https://storage.googleapis.com/lightskn/Cupid.mp3'},
    coverUrl: {type: String, default: ''},
});

const Song = mongoose.model('Song', SongSchema);

module.exports = Song;