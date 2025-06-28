const express = require('express');
const bodyParser = require('body-parser');
const connectDB = require('./config/db');
const Routes = require('./routes/user.router');
const clubRoutes = require('./routes/club.router')
const approvalRoutes = require('./routes/approval.router')
const eventRoutes = require('./routes/event.router')
const cors = require('cors');

const app = express();

app.use(bodyParser.json({ limit: '100mb' }));
app.use(bodyParser.urlencoded({ limit: '100mb', extended: true }));

// Middleware
app.use(express.json()); 
app.use(cors());


app.use("/assets", express.static("assets"));


//User Root Routes
app.use('/api', Routes);

//Club Routes
app.use('/api', clubRoutes);

//approval routes
app.use('/api' ,approvalRoutes );

//event routse
app.use('/api' ,eventRoutes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
