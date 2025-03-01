const jwt = require('jsonwebtoken');
require('dotenv').config(); 

const authenticateToken = (req, res, next) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) {
      return res.status(401).json({ error: 'Authorization token is missing' });
    }
  
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET); 
      req.user = decoded; 
      next(); 
    } catch (error) {
      res.status(401).json({ error: 'Invalid or expired token' });
    }
};

module.exports = authenticateToken;
