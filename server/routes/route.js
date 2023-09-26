const app = require("express").Router();
const userController = require("../controller/userController");
const diaryController = require("../controller/diaryController");
const DiemDanhController = require("../controller/DiemDanhController");
const EmotionController = require("../controller/EmotionController");
const favorite_userController = require("../controller/favorite_userController");
const favoriteController = require("../controller/favoriteController");
const Level_DepressionController = require("../controller/Level_DepressionController");
const missionController = require("../controller/missionController");
const MissionDayController = require("../controller/MissionDayController");
const testController = require("../controller/testController");
const ChatbotController = require("../controller/chatbotController");
const filmController = require("../controller/filmController");
const User = require("../models/User");
const UserData = require("../models/UserData");
// Route cho user
app.post("/register", userController.createUser);
app.post("/login", userController.loginUser);
app.get("/user/getInfor/:id", userController.getUser);
app.post("/user/checkEmail", userController.checkExistedEmail);
app.get("/user/getData/:id", userController.getUserDataById);

// Route cho Diary
app.post("/newDiary", diaryController.insertDiary);
app.get("/getDiaryById", diaryController.getDiaryById);
app.post("/deleteDiary", diaryController.deleteDiary);

//Router cho Diem danh
app.post("/DiemDanh", DiemDanhController.createDiemDanh);
app.get("/DiemDanhById", DiemDanhController.getDiemDanhById);

// Router cho Emotion
app.post("/emotion", EmotionController.createEmotion);
app.get("/getEmotionById", EmotionController.getEmotionById);
app.post("/updateEmotion", EmotionController.updateEmotion)

//Router cho Favorite cua User
app.post("/favoriteUser", favorite_userController.createFavoriteUser);
app.get("/getFavoriteUserById", favorite_userController.getFavoriteUserById);
app.post("/deleteFavoriteUser", favorite_userController.deleteFavoriteUser);

// Router cho Favorite
app.get("/favorite", favoriteController.getFavorites);

//Router cho Mức độ trầm cảm
app.get("/levelDepressionById", Level_DepressionController.getLevelDepressionById);
app.post("/levelDepression", Level_DepressionController.createLevelDepression);
app.post("/updateLevelDepression", Level_DepressionController.updateLevelDepression);

//Router cho Mission trong Ngày
app.post("/MissionDay", MissionDayController.createMissionDay);
app.get("/getMissionDayById", MissionDayController.getMissionDayById);
app.post("/updateMissionDay", MissionDayController.updateMissionDay);

// Router cho Test
app.post("/Test", testController.createTest);
app.get("/getTest", testController.getTests);

//Route cho Chatbot
app.post("/Chatbot", ChatbotController.Chatbot)

//Route cho Film
app.get("/Film", filmController.getFilm);

//Route de Update Data
app.put('/user/update-name/:id', async (req, res) => {
    const userId = req.params.id;
    const {name} = req.body;

    try {
        const user = await User.findByIdAndUpdate(userId, {$set: {name}}, {new: true}).select('-password');
        res.json(user);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Cập nhật trường phoneNumber của User
app.put('/user/update-phone/:id', async (req, res) => {
    const userId = req.params.id;
    const {phoneNumber} = req.body;

    try {
        const user = await User.findByIdAndUpdate(userId, {$set: {phoneNumber}}, {new: true}).select('-password');
        res.json(user);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Cập nhật trường DOB của User
app.put('/user/update-dob/:id', async (req, res) => {
    const userId = req.params.id;
    const {DOB} = req.body;

    try {
        const user = await User.findByIdAndUpdate(userId, {$set: {DOB}}, {new: true}).select('-password');
        res.json(user);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Cập nhật trường address của User
app.put('/user/update-address/:id', async (req, res) => {
    const userId = req.params.id;
    const {address} = req.body;

    try {
        const user = await User.findByIdAndUpdate(userId, {$set: {address}}, {new: true}).select('-password');
        res.json(user);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

app.put('/userdata/update-bio/:id', async (req, res) => {
    const userDataId = req.params.id;
    const {bio} = req.body;

    try {
        const userData = await UserData.findByIdAndUpdate(userDataId, {$set: {bio}}, {new: true}).select('-password');
        res.json(userData);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

// Cập nhật trường socialConnections của UserData
app.put('/userdata/update-social/:id', async (req, res) => {
    const userDataId = req.params.id;
    const {socialConnections} = req.body.s;

    try {
        const userData = await UserData.findByIdAndUpdate(userDataId, {$set: {socialConnections}}, {new: true}).select('-password');
        res.json(userData);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

module.exports = app
