const User = require("../models/User")
const jwt = require("jsonwebtoken")

const verifyToken = (req, res, next) => {
    const authHeader = req.headers.token;

    if (authHeader) {
        const token = authHeader.split(" ")[1]
        jwt.verify(token, process.env.JWT_KEY, async(err, user) => {
            if (err) {
                res.status(403).json('Token khong hop le')
            } else {
                req.user = user;
                console.log(user)

                next()
            }
        })
    } else {
        return res.status(401).json("Khong duoc cap quyen")
    }
}

const verifyAndAuthorization = (req, res, next) => {
    verifyToken(req, res, () => {
        if ( req.user.id === req.params.id) {
            next()
        } else {
            res.status(403).json("Ban ko du quyen truy cap")
        }
    })
}
module.exports = {verifyToken, verifyAndAuthorization}