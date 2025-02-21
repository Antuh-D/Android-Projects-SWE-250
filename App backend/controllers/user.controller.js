const authService = require('../services/user.service');

const registerUser = async (req, res) => {
  try {
    const userData = req.body;
    const newUser = await authService.registerUser(userData);

    res.status(201).json({ message: "User registered successfully", user: newUser });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;
    const { user } = await authService.loginUser(email, password);

    res.status(200).json({
      message: "Login successful",
      user,
      // Add token if JWT or other tokens are used
    });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const findUserByEmail = async (req, res) =>{
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
}

module.exports = {
  registerUser,
  loginUser,
  findUserByEmail
};
