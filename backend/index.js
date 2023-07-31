const express = require('express');
const cors = require('cors');
const ErrorHandler = require('./errorHandler');

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
const CategoryRouter = require("./routes/CategoryRoute");
const ProductRouter = require('./routes/ProductRoute');

// Routes Used
app.use("/api/user" , UserRouter);
app.use("/api" , CategoryRouter);
app.use("/api" , ProductRouter);

app.all("*" , (req,res,next)=>{
    return next(new ErrorHandler(`Can't find ${req.originalUrl} on the server` , 404));
})

// Globle error handler
app.use((error , req , res , next)=>{
    error.message = error.message || "Internal Server Error";
    error.statusCode = error.statusCode || 500;

    res.send({success : false , statusCode : error.statusCode , message : error.message});
})

app.listen(5000);