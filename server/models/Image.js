const mongoose = require('mongoose');

const imageSchema = new mongoose.Schema({
    userId: {type: mongoose.Schema.Types.ObjectId, ref: 'User'},
    ImageUrl: {type: String, require: true}
});

const Image = mongoose.model('Image', imageSchema);
module.exports = Image;