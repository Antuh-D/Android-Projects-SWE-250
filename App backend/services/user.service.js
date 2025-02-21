const bcrypt = require('bcryptjs');
const User = require('../models/user.model');

// Register user service
const registerUser = async (userData) => {
  const { username, email, registration, password } = userData;

  // Check if user already exists
  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw new Error("Email already exists");
  }

  // Hash password
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(password, salt);

  // Create new user with hashed password
  const newUser = new User({
    username,
    email,
    registration,
    password: hashedPassword,
  });

  // Save the new user to the database
  await newUser.save();

  return newUser;
};

// Login user service
const loginUser = async (email, password) => {
  const existingUser = await User.findOne({ email });
  if (!existingUser) {
    throw new Error('Invalid credentials');
  }

  // Compare the provided password with the stored hashed password
  const isMatch = await bcrypt.compare(password, existingUser.password);
  if (!isMatch) {
    throw new Error('Invalid credentials');
  }

  // Generate a token (you can implement JWT or any token mechanism here)
  // For example, with JWT (assuming JWT is installed):
  // const token = jwt.sign({ userId: existingUser._id }, 'yourSecretKey', { expiresIn: '1h' });
  
  return { user: existingUser }; // For simplicity, returning the user
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

module.exports = {
  registerUser,
  loginUser,
  findUserByEmail,
};
