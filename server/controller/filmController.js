const Film = require('../models/Film');

module.exports = {
    getFilm: async (req, res) => {
        try {
            const films = await Film.find();
            res.status(200).json(films);
        } catch (e) {
            console.error(e);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    },

    deleteAllFilms: async (req, res) => {
        try {
            await Film.deleteMany({}); // Xóa tất cả các bản ghi
            res.status(204).json(); // Trả về status code 204 để cho biết thành công và không có nội dung
        } catch (e) {
            console.error(e);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }
}
