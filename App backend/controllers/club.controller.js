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

const deleteClub = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await clubService.deleteClub(id);
    if (!deleted) {
      return res.status(404).json({ message: 'Club not found' });
    }
    res.status(200).json({ message: 'Club deleted successfully' });
  } catch (err) {
    res.status(500).json({ message: 'Error deleting club', error: err });
  }
};

module.exports = { createClub, getAllClubs,deleteClub };

