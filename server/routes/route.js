const app = require("express").Router();
const userController = require("../controller/userController");
const diaryController = require("../controller/diaryController");
const EmotionController = require("../controller/EmotionController");
const favorite_userController = require("../controller/favorite_userController");
const favoriteController = require("../controller/favoriteController");
const Level_DepressionController = require("../controller/Level_DepressionController");
const missionController = require("../controller/missionController");
const MissionDayController = require("../controller/MissionDayController");
const testController = require("../controller/testController");
const ChatbotController = require("../controller/chatbotController");
const filmController = require("../controller/filmController");
const imageController = require("../controller/imageController");

const Multer = require('multer');

const multer = Multer({
    storage: Multer.memoryStorage(),
    limits: {
        fileSize: 100 * 1024 * 1024,
    },
})

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

//Route de Update Name
app.put('/user/update-name/:id', userController.updateName);

// Cập nhật trường phoneNumber của User
app.put('/user/update-phone/:id', userController.updatePhoneNo);

// Cập nhật trường DOB của User
app.put('/user/update-dob/:id', userController.updateDOB);

// Cập nhật trường address của User
app.put('/user/update-address/:id', userController.updateAddress);

app.put('/userdata/update-bio/:id', userController.updateBio);

// Cập nhật trường socialConnections của UserData
app.put('/userdata/update-social/:id', userController.updateSocialConnection);

//Router cho Upload
app.post('/upload', multer.single('image'), imageController.Upload)
module.exports = app
