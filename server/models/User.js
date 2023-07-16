const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema(
    {
        name: {
            type: String,
            required: true,
        },
        email: {
            type: String,
            required: true,
            unique: true,
        },
        phoneNumber: {
            type: String,
            required: false,
        },
        address: {
            type: String,
            required: true,
        },
        age: {
            type: Number,
            required: true,
            default: 0
        },
        password: {
            type: String,
            required: true,
        }
    }
);

module.exports = mongoose.model("User", UserSchema);