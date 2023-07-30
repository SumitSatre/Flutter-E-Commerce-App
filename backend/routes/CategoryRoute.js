const express = require("express");
const mongoose = require("mongoose");

const CategoryRouter = express.Router();

CategoryRouter.get("/categories" , async (req , res)=>{
    let response = await mongoose.connection.db.collection("categories");

    let CategoryData = await response.find({}).toArray();

    res.send({success : true , CategoryData});
})

module.exports = CategoryRouter;