const mongoose = require('mongoose');

const FilmSchema = new mongoose.Schema({
    title: {type: String, default: ''},
    image: {type: String, default: ''},
    genre: {type: String, default: ''},
    duration: {type: String, default: ''},
    rating: {type: String, default: ''},
    description: {type: String, default: ''},
    path: {type: String, default: 'https://www.google.com/'},
});

const Film = mongoose.model('Film', FilmSchema);
