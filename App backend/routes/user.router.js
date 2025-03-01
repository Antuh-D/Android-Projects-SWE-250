const express = require('express');
const upload = require('../middleware/upload');
const authenticateToken = require('../middleware/auth.middlewasre');
const {
     registerUser,
      loginUser,
      findUserByEmail,
      updateUserProfile,
    } = require('../controllers/user.controller');  


const router = express.Router();

// Signup & Login Route
router.post('/signup', registerUser);
router.post('/login',  loginUser);

//update user info
router.put('/updateprofile',authenticateToken, upload.single("profilePicture"), updateUserProfile);

//search user
router.get('/user/:email', findUserByEmail);


module.exports = router;
