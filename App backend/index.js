const express = require('express');
const connectDB = require('./config/db');
const Routes = require('./routes/user.router');
const cors = require('cors');

const app = express();


// Middleware
app.use(express.json()); 
app.use(cors());


app.use("/assets", express.static("assets"));


// Routes
app.use('/api', Routes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
