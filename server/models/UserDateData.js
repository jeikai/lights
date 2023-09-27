const mongoose = require('mongoose');

const userDateActivitySchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Reference to the User model
        required: true,
    },
    date: {
        type: String,
        required: true,
    },
    emotion: {
        type: String,
        enum: ['CucBuon', 'Buon', 'BinhThuong', 'Vui', 'CucVui', 'Default'], // Define your activity types
    },
    title: {
        type: String,
    },
    story: {
        type: String,
    },
    image: {
        data: Buffer, // Store image data as binary
        contentType: String, // Store content type (e.g., 'image/jpeg', 'image/png')
    }
});

const UserDateActivity = mongoose.model('UserDateActivity', userDateActivitySchema);

module.exports = UserDateActivity;