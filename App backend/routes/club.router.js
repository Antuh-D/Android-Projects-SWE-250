const express = require('express');

const {
     createClub,
     getAllClubs,
     deleteClub,
    } = require('../controllers/club.controller');


const router = express.Router();

router.post("/club", createClub);
router.get("/club", getAllClubs);
router.delete("/club/:id", deleteClub);

module.exports = router;