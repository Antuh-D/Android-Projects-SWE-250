const mongoose = require("mongoose");

const clubSchema = new mongoose.Schema({
  name: String,
  subtitle: String,
  description: String,
  email: String,
  phone: String,
  category: String,
  facebookLink: String,
  president: String,
  vicePresident: String,
  createdAt: { type: Date, default: Date.now },
  isApproved: { type: Boolean, default: false },
  followers: { type: Number, default: 0 },
  members: { type: Number, default: 0 },
  image: String, // base64 or image path
});

module.exports = mongoose.model("Club", clubSchema);
