const express = require('express');
const cors = require('cors');

const dotenv = require('dotenv');
dotenv.config({path : "./config/.env"});

// Connecting to the database
const DatabaseConnect = require("./config/database");
DatabaseConnect();

const app = express();
app.use(express.json());

// Allow all origins (*) for simplicity. You can restrict it to specific origins.
app.use(cors());

// Routes Imported
const UserRouter = require('./routes/UserRoute');

// Routes Used
app.use("/api/user" , UserRouter);



app.listen(5000);