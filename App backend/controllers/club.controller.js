const Club = require("../models/club.model");

const clubService = require("../services/club.service");

const createClub = async (req, res) => {
  try {
    const result = await clubService.createClub(req.body);
    res.status(result.status).json(result.data);
  } catch (err) {
    console.error("Create club error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

const getAllClubs = async (req, res) => {
  try {
    const clubs = await clubService.getAllClubs();
    res.status(200).json(clubs);
  } catch (err) {
    res.status(500).json({ message: "Failed to fetch clubs" });
  }
};

module.exports = { createClub, getAllClubs };

