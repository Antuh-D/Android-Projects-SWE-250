const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");
const User = require('../models/user.model');
require('dotenv').config(); 



// Register user service
const registerUser = async (userData) => {
  const { username, email, registration, password } = userData;

  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw new Error("Email already exists");
  }

  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  const newUser = new User({
    username,
    email,
    registration,
    password: hashedPassword,
  });

  await newUser.save();

  return newUser;
};



// Login user service
const loginUser = async (email, password) => {
  const existingUser = await User.findOne({ email });
  if (!existingUser) {
    throw new Error('Invalid credentials');
  }

  const isMatch = await bcrypt.compare(password, existingUser.password);
  if (!isMatch) {
    throw new Error('Invalid credentials');
  }

   const token = jwt.sign({ userId: existingUser._id }, process.env.JWT_SECRET , { expiresIn: '1h' });
  
  return { user: existingUser ,token}; 
};



//search user by email
const findUserByEmail = async (email) => {
  try {
      const user = await User.findOne({ email });
      return user;
  } catch (error) {
      throw new Error(error.message);
  }
};




//update user info
const updateUserProfile = async (userId, updateData) => {
  try {
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      throw new Error('Invalid user ID');
    }

    const updatedUser = await User.findByIdAndUpdate(
      userId,
      updateData,
      { new: true, runValidators: true }
    );

    if (!updatedUser) {
      throw new Error('User not found');
    }

    return updatedUser;
  } catch (error) {
    throw new Error(`Error updating profile: ${error.message}`);
  }
};


const findUserById = async (userId) => {
return await User.findById(userId);
};



module.exports = {
  registerUser,
  loginUser,
  findUserByEmail,
  updateUserProfile,
  findUserById,
};
