const express = require('express');
const {
     registerUser,
      loginUser,
      findUserByEmail,
    } = require('../controllers/user.controller');  

const router = express.Router();

// Signup Route
router.post('/signup', registerUser);

// Login Route
router.post('/login',  loginUser);

//search user
router.get('/user/:email', findUserByEmail);


module.exports = router;
