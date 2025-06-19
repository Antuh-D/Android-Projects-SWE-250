const Club = require("../models/club.model");

const createClub = async (clubData) => {
  const { name, email } = clubData;

  const existingClub = await Club.findOne({
    $or: [{ name }, { email }]
  });

  if (existingClub) {
    return {
      status: 409,
      data: { message: "A club with the same name or email already exists." }
    };
  }

  const newClub = new Club(clubData);
  await newClub.save();

  return {
    status: 201,
    data: { message: "Club created successfully", club: newClub }
  };
};

const getAllClubs = async () => {
  return await Club.find();
};

module.exports = { createClub, getAllClubs };
