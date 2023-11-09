const mongoose = require('mongoose');

const missionCardSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    cardId: { type: mongoose.Schema.Types.ObjectId, ref: 'Card' },
    isCompleted: {type: Number, enum: [0, 1], default: 0},
    isScanned: {type: Number, enum: [0, 1], default: 0},
    answer: {type: String, default: ''}
});

const MissionCard = mongoose.model('MissionCard', missionCardSchema);

module.exports = MissionCard;