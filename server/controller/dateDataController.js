const UserDateActivity = require('../models/UserDateData'); // Assuming the model is in a separate file

// Create a new user date activity with an image
async function createUserDateActivity(req, res) {
    try {
        const {userId, date, activityType, description, image} = req.body;
        const newUserDateActivity = new UserDateActivity({
            userId,
            date,
            activityType,
            description,
            image,
        });

        const savedUserDateActivity = await newUserDateActivity.save();
        res.status(201).json(savedUserDateActivity);
    } catch (error) {
        res.status(500).json({error: 'Could not create user date activity'});
    }
}

// Retrieve user date activities by user ID
async function getUserDateActivitiesByUserId(req, res) {
    try {
        const userId = req.params.userId;
        const userDateActivities = await UserDateActivity.find({userId});
        res.status(200).json({userDates: userDateActivities});
    } catch (error) {
        res.status(500).json({error: 'Could not retrieve user date activities'});
    }
}

// Retrieve user date activity by ID
async function getUserDateActivityById(req, res) {
    try {
        const id = req.params.id;
        const userDateActivity = await UserDateActivity.findById(id);
        res.status(200).json(userDateActivity);
    } catch (error) {
        res.status(500).json({error: 'Could not retrieve user date activity'});
    }
}

async function getUserDateActivity(req, res) {
    try {
        const {userId, date} = req.body;
        let userDateActivity = await UserDateActivity.findOne({userId: userId, date: date});
        if (!userDateActivity) {
            userDateActivity = new UserDateActivity({
                userId,
                date,
            });
            await userDateActivity.save();
        }
        res.status(200).json({userDate: userDateActivity});
    } catch (error) {
        res.status(500).json({error: 'Could not retrieve user date activity'});
    }
}

// Delete a user date activity by ID
async function deleteUserDateActivityById(req, res) {
    try {
        const id = req.params.id;
        await UserDateActivity.findByIdAndRemove(id);
        res.status(204).end();
    } catch (error) {
        res.status(500).json({error: 'Could not delete user date activity'});
    }
}

// Update specific attributes of a user date activity by ID
async function updateUserDateActivity(req, res) {
    const body = req.body; // Fields you want to update
    const {updateFields, userId, date} = body;
    try {
        const updatedUserDateActivity = await UserDateActivity.findOneAndUpdate(
            {userId: userId, date: date},
            {$set: updateFields},
            {new: true} // This option returns the updated document
        );

        if (!updatedUserDateActivity) {
            return res.status(404).json({error: 'User date activity not found'});
        }

        res.status(200).json({updated: updatedUserDateActivity});
    } catch (error) {
        res.status(500).json({error: 'Could not update user date activity'});
    }
}

module.exports = {
    createUserDateActivity,
    getUserDateActivitiesByUserId,
    getUserDateActivityById,
    deleteUserDateActivityById,
    updateUserDateActivity,
    getUserDateActivity
};