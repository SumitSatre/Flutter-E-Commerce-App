const express = require("express");
const mongoose = require("mongoose");

const ProductRouter = express.Router();

ProductRouter.post("/products" , async (req , res)=>{

    const response = await mongoose.connection.db.collection("products");
    const productsData = await response.find({}).toArray();

    if(req.body.category){
        const filteredData = productsData.filter((item)=> item.category == req.body.category);

        res.send({success : true , statusCode: 200 , message : "Data Shared Successfully!", filteredData});
    }

    else{
        res.send({success : true , statusCode: 200 , message : "Data Shared Successfully!", productsData});
    }
})

module.exports = ProductRouter;