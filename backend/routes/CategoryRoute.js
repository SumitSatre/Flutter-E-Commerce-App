const express = require("express");
const mongoose = require("mongoose");
const ErrorHandler = require("../errorHandler");

const CategoryRouter = express.Router();

CategoryRouter.get("/categories" , async (req , res , next)=>{
    let response = await mongoose.connection.db.collection("categories");

    let CategoryData = await response.find({}).toArray();

    if(!response && !CategoryData){
        return next(new ErrorHandler("Categories Not Found" , 501));
    }

    res.send({success : true , CategoryData});
})

module.exports = CategoryRouter;