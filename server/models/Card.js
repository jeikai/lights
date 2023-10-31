const mongoose = require('mongoose');

const cardSchema = new mongoose.Schema({    
    number: {type: Number},
    description: { type: String },
});

const Card = mongoose.model('Card', cardSchema);

module.exports = Card;