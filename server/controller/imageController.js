const { Storage } = require('@google-cloud/storage');
const User = require("../models/User");
const Image = require("../models/Image");

let projectId = 'lights-397915';
let keyFilename = './myKey.json';
const storage = new Storage({
    projectId,
    keyFilename,
});
const bucket = storage.bucket('lightskn');
module.exports = {
    Upload: async (req, res) => {
        try {
            if (req.file) {
                const userId = req.body.userId;
                const originalname = req.file.originalname;
                const userExists = await User.findById(userId);

                if (!userExists) {
                    throw "User not found";
                }
                const newFilename = userId + "_" + originalname;
                const blob = bucket.file(newFilename);

                const blobStream = blob.createWriteStream();

                blobStream.on('finish', async () => {
                    const signedUrls = await blob.getSignedUrl({
                        action: 'read',
                        expires: '01-01-2030',
                    });
                    // Kiểm tra xem signedUrls có phải là mảng không
                    if (Array.isArray(signedUrls) && signedUrls.length > 0) {
                        // Lấy URL đầu tiên từ mảng và chuyển nó thành chuỗi
                        const publicUrl = signedUrls[0];

                        const newImage = new Image({ userId: userId, ImageUrl: publicUrl });
                        await newImage.save();

                        res.status(200).json({ status: true, url: publicUrl });
                    } else {
                        throw "Failed to get a valid signed URL.";
                    }
                });
                blobStream.end(req.file.buffer);
            } else {
                throw "error image";
            }
        } catch (error) {
            console.log(error)
            res.status(500).json({success: false, error});
        }
    },
    getImage: async (req, res) => {

    }
}
