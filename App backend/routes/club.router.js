const express = require('express');

const {
     createClub,
     getAllClubs,
    } = require('../controllers/club.controller');


const router = express.Router();

router.post("/club", createClub);
router.get("/club", getAllClubs);

module.exports = router;