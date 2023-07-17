const User = require('../models/User')

module.exports = {
    createUser: async (req, res) => {
        const newUser = new User({
            name: req.body.name,
            email: req.body.email,
            phoneNumber: req.body.phoneNumber,
            address: req.body.address,
            age: req.body.age,
            password: req.body.password
        });

        try {
            const savedUser = await newUser.save();
            res.status(201).json(savedUser);
        } catch (error) {
            res.status(500).json(error)
        }
    }
}