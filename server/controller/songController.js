const Song = require('../models/Song');

module.exports = {
    getSong: async (req, res) => {
        try {
            const songs = await Song.find();
            res.status(200).json(songs);
        } catch (e) {
            console.error(e);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    },

}
