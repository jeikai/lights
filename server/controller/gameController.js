const Game = require('../models/Game');

module.exports = {
    getGame: async (req, res) => {
        try {
            const game = await Game.find();
            res.status(200).json(game);
        } catch (e) {
            console.error(e);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    },

    deleteAllGames: async (req, res) => {
        try {
            await Film.deleteMany({}); // Xóa tất cả các bản ghi
            res.status(204).json(); // Trả về status code 204 để cho biết thành công và không có nội dung
        } catch (e) {
            console.error(e);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }
}
