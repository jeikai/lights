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
const User = require("../models/User");
const UserData = require("../models/UserData");
const {
    createUserDateActivity,
    getUserDateActivitiesByUserId,
    getUserDateActivityById,
    deleteUserDateActivityById,
    updateUserDateActivity,
    getUserDateActivity
} = require('../controller/dateDataController'); // Replace with the actual controller file

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
app.post("/user/checkEmailAndPhone", userController.checkExistedEmailAndPhoneNumber);
app.post("/user/updatePassword", userController.updatePassword);
app.get("/user/getAllUser/:id", userController.getAllUser);
// Route cho Diary
app.post("/newDiary", diaryController.insertDiary);
app.get("/getDiaryById", diaryController.getDiaryById); 
app.post("/deleteDiary", diaryController.deleteDiary);

// Router cho Emotion
app.post("/emotion", EmotionController.createEmotion); // Điểm danh - truyền xuống userId và emotion là INT 0, 1, 2, 3 , 4
app.get("/getEmotionById/:id", EmotionController.getEmotionById); // Get dữ liệu ra cho phần lịch - param userId
app.get("/emotionChart/:id", EmotionController.emotionChart)

//Router cho Favorite cua User
app.post("/favoriteUser", favorite_userController.createFavoriteUser);
app.get("/getFavoriteUserById", favorite_userController.getFavoriteUserById);
app.post("/deleteFavoriteUser", favorite_userController.deleteFavoriteUser);

// Router cho Favorite
app.get("/favorite", favoriteController.getFavorites);

//Router cho Mức độ trầm cảm
app.get("/levelDepressionById/:id", Level_DepressionController.getLevelDepressionById); // cái này lấy ra kết quả mức độ trầm cảm theo userId - param userId ( cái này bạn không cần động đến đâu vì nó phục vụ cho mission và tớ mission rồi)
app.post("/levelDepression", Level_DepressionController.createLevelDepression); // Cái này lưu lại kết quả bài Test lúc đầu đăng ký thôi. - cái này truyền vào userId và level
app.post("/updateLevelDepression", Level_DepressionController.updateLevelDepression); // Cái này update lại Depression: chỉ cần truyền xuống userId - truyền xuống userId

//Router cho Mission trong Ngày
app.post("/MissionDay", MissionDayController.createMissionDay); // cái này để tạo ra MissionDay mới - random 4 cái: chỉ cần truyền xuống userId
app.get("/getMissionDayById/:id", MissionDayController.getMissionDayById); // Lấy kết ra 4 nhiệm vụ trong ngày - param là userId
app.put("/updateMissionDayById/:id", MissionDayController.updateMissionDayById); // Dùng để xoá 1 Mission khi người dùng nhất nút hoàn thành - truyền vào missionId

// Router cho Test
app.post("/Test", testController.createTest); // Ghi lại kết quả của bài Test
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

// Define your routes and use the controller functions as handlers
app.post('/user-date-activity', createUserDateActivity);
app.get('/user-date-activity/:userId', getUserDateActivitiesByUserId);
app.get('/user-date-activity/:id', getUserDateActivityById);
app.delete('/user-date-activity/:id', deleteUserDateActivityById);
app.put('/update-user-date-activity', updateUserDateActivity);
app.post('/get-or-create-user-date-activity', getUserDateActivity);

module.exports = app
