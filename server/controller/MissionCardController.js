const Card = require('../models/Card')
const MissionCard = require('../models/MissionCard')
module.exports = {
    createData: async (req, res) => {
        try {
            const cards = await Card.find({});
            for (const card of cards) {
                const newMissionCard = new MissionCard({
                    userId: req.body.userId,
                    cardId: card._id,
                });
                console.log(newMissionCard)
                await newMissionCard.save();
            }

            res.status(200).json({ message: 'Success' });
        } catch (error) {
            console.error('Lỗi khi tạo dữ liệu trong bảng MissionCard:', error);
            res.status(500).json({ message: 'Error' });
        }
    },
    scanCard: async (req, res) => {
        try {
            const cardNumber = req.params.id;
            const userId = req.body.userId;
            const card = await Card.findOne({ number: cardNumber });

            if (!card) {
                return res.status(404).json({ message: 'Error' });
            }
            const cardId = card._id;
            const updatedMissionCard = await MissionCard.findOneAndUpdate(
                { cardId, userId },
                { isScanned: 1 },
                { new: true }
            );

            if (updatedMissionCard) {
                res.status(200).json({ message: 'Success' });
            } else {
                res.status(404).json({ message: 'Error' });
            }
        } catch (error) {
            console.error('Lỗi khi quét thẻ:', error);
            res.status(500).json({ message: 'Error' });
        }
    },
    updateCard: async (req, res) => {
        try {
            const missionCardId = req.params.id;
            const answer = req.body.answer;
            const card = await MissionCard.findOne({ _id: missionCardId });
            if (!card) {
                return res.status(404).json({ message: 'Error' });
            }
            console.log(card)
            const updatedMissionCard = await MissionCard.findOneAndUpdate(
                { _id: missionCardId },
                {
                    isCompleted: 1,
                    answer: answer
                },
                { new: true }
            );

            if (updatedMissionCard) {
                res.status(200).json({ message: 'Success' });
            } else {
                res.status(404).json({ message: 'Error' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error' });
        }
    },
    getUserCard: async (req, res) => {
        try {
            const userId = req.params.id;

            const userCards = await MissionCard.find({ userId })
                .populate({
                    path: "cardId",
                    model: "Card",
                    select: "description",
                });

            if (userCards) {
                const formattedUserCards = userCards.map(card => ({
                    _id: card._id,
                    userId: card.userId,
                    cardId: card.cardId._id,
                    description: card.cardId.description,
                    isCompleted: card.isCompleted,
                    isScanned: card.isScanned,
                    answer: card.answer,
                }));

                res.status(200).json({ userCards: formattedUserCards, message: 'Success' });
            } else {
                res.status(404).json({ message: 'Error' });
            }
        } catch (error) {
            console.error('Lỗi khi lấy dữ liệu người dùng:', error);
            res.status(500).json({ message: 'Error' });
        }
    },
}