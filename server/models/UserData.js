const mongoose = require('mongoose');

const userDataSchema = new mongoose.Schema({
    _id: mongoose.Schema.Types.ObjectId,
    bio: String,
    socialConnections: [String],
    notifications: [Map]
});

const UserData = mongoose.model('UserData', userDataSchema);

module.exports = UserData;