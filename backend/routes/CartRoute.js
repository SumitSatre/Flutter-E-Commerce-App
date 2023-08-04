const express = require('express');
const CartModel = require('../models/CartModel');

const CartRouter = express.Router();

CartRouter.post("/cart/update", async (req , res)=>{

    if(!req.body.email || !req.body.cartData){
        return res.send({ success: false, statusCode: 400, message: "Please! Enter Essential Details" });
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

module.exports = CartRouter;