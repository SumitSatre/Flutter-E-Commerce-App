const express = require('express');
const CartModel = require('../models/CartModel');
const ErrorHandler = require("../errorHandler");

const CartRouter = express.Router();

CartRouter.post("/cart/update", async (req , res , next)=>{

    if(!req.body.email || !req.body.cartData){
        return next(new ErrorHandler("Please! Enter Essential Details", 501));
    }

    const email = req.body.email;

    let checkEmail = await CartModel.findOne({email});

    if(!checkEmail){
        await CartModel.create({
           email : email,
           cartData : req.body.cartData
        });

        res.send({ success: true, statusCode: 200, message: "Data Saved Successfully!" });
    }

    else{
        await CartModel.updateOne({email} , {$set : {"cartData" : req.body.cartData}});
        res.send({ success: true, statusCode: 200, message: "Data Updated Successfully!" });
    }
})

CartRouter.get("/cart", async (req , res , next)=>{

    if(!req.body.email){
        return next(new ErrorHandler("Please! Enter Essential Details", 501));
    }

    const email = req.body.email;

    let UserCart = await CartModel.findOne({email});

    if(UserCart){
        res.send({ success: true, statusCode: 200, message: "Data Shared Successfully!", UserCart });
    }

    else{
        return next(new ErrorHandler("User Not Found!", 501));
    }
})

module.exports = CartRouter;