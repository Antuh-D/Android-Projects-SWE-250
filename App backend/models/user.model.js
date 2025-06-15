const mongoose = require("mongoose");
const db = require("../config/db");

const { Schema } = mongoose;

const userSchema = new Schema({
  username: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: [true, "Email is required"],
    unique: true,
    lowercase: true,
    match: [/^\S+@\S+\.\S+$/, "Please enter a valid email"],
  },
  registration: {
    type: String,
    required: [true, "Registration number is required"],
    unique: true, 
  },
  password: {
    type: String,
    required: [true, "Password is required"],
    minlength: [6, "Password must be at least 6 characters long"],
  },
  role: {
    type: String,
    enum: ['user', 'admin','varsity'],
    default: 'varsity',
  },
  profilePicture: {
    type: String,
    default: "/assets/me.jpg", // Local default image path
  },
});

const UserModel = db.model('User', userSchema);

module.exports = UserModel;
