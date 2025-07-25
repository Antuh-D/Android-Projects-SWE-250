const authService = require('../services/user.service');
const { updateImageService,updateUserRoleService } = require('../services/user.service');
const user = require('../models/user.model');
const bcrypt = require('bcrypt');


// Register user
const registerUser = async (req, res) => {
  try {
    const userData = req.body;
    const newUser = await authService.registerUser(userData);
    res.status(201).json({ message: "User registered successfully", user: newUser });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Login user
const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const { user, token } = await authService.loginUser(email, password);
    res.status(200).json({
      message: "Login successful",
      user,
      token, 
    });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// Find user by email
const findUserByEmail = async (req, res) => {
  try {
    const email = req.params.email;
    const user = await authService.findUserByEmail(email);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};



//Update user profile info
const updateUserProfile = async (req, res) => {
  try {
    const {
      _id: userId,
      username,
      email,
      registration,
      department,
      university,
      oldPassword,
      newPassword,
      role
    } = req.body;

    if (!userId) {
      return res.status(400).json({ error: 'User ID is missing' });
    }

    const updateData = {};

    // Add provided fields
    if (username) updateData.username = username;
    if (email) updateData.email = email;
    if (registration) updateData.registration = registration;
    if (department) updateData.department = department;
    if (university) updateData.university = university;
    if(role) updateData.role = role;

    // Handle password update
    if (oldPassword && newPassword) {
      const user = await authService.findUserById(userId);
      const isMatch = await bcrypt.compare(oldPassword, user.password);
      if (!isMatch) {
        return res.status(400).json({ error: 'Old password is incorrect' });
      }

      const salt = await bcrypt.genSalt(10);
      updateData.password = await bcrypt.hash(newPassword, salt);
    }

    // Prevent empty update
    if (Object.keys(updateData).length === 0) {
      return res.status(400).json({ error: 'No valid data to update' });
    }

    const updatedUser = await authService.updateUserProfile(userId, updateData);
    res.status(200).json({
      message: 'Profile updated successfully',
      user: updatedUser,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//update image
const updatePictureController = async (req, res) => {
  try {
    const userId = req.body._id;
    console.log("Updating user ID:", userId);

    const { profilePicture, coverPicture } = req.body;

    const result = await updateImageService(userId, profilePicture, coverPicture);

    res.status(200).json({
      message: result.message,
      user: result.user,
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

const updateUserRole = async (req, res) => {
  try {
    const { _id, role } = req.body;

    if (!_id || !role) {
      return res.status(400).json({ error: 'User ID and role are required' });
    }

    const updatedUser = await updateUserRoleService(_id, role);

    res.status(200).json({
      message: 'Role updated successfully',
      user: updatedUser,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  registerUser,
  loginUser,
  findUserByEmail,
  updateUserProfile,
  updatePictureController,
  updateUserRole,
};
