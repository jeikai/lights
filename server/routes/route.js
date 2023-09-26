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
// Route cho user
app.post("/register", userController.createUser)
app.post("/login", userController.loginUser)
app.get("/user/getInfor/:id", userController.getUser);
app.post("/user/checkEmail", userController.checkExistedEmail);
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
app.post("/Chatbot", ChatbotController.Chatbot);

//Router cho Film
app.get("/Film", filmController.getFilm);
app.delete("/DeleteAllFilm", filmController.deleteAllFilms);
module.exports = app;