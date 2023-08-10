const express = require('express');
const MyOrdersModel = require('../models/MyOrdersModel');
const ErrorHandler = require("../errorHandler");

const MyOrdersRouter = express.Router();

MyOrdersRouter.post("/myorders/update", async (req , res , next)=>{

    if(!req.body.email || !req.body.ordersData){
        return next(new ErrorHandler("Please! Enter Essential Details", 501));
    }

    const email = req.body.email;

    const ordersData = req.body.ordersData;
    await ordersData.splice(0, 0, { Order_date: req.body.order_date });

    let checkEmail = await MyOrdersModel.findOne({email});

    // If email is not present in the database
    if(!checkEmail){
        await MyOrdersModel.create({
           email : email,
           ordersData : [ordersData]
        });

        res.send({ success: true, statusCode: 200, message: "Data Saved Successfully!" });
    }

    // If email is already present in the database update the 
    else{
        await MyOrdersModel.findOneAndUpdate({email} , {$push : {"ordersData" : req.body.ordersData}});
        res.send({ success: true, statusCode: 200, message: "Data Updated Successfully!" });
    }
})

MyOrdersRouter.post("/myorders", async (req , res , next)=>{

    if(!req.body.email){
        return next(new ErrorHandler("Please! Enter Essential Details", 501));
    }

    const email = req.body.email;

    let MyOrders = await MyOrdersModel.findOne({email});

    if(UserCart){
        res.send({ success: true, statusCode: 200, message: "Data Shared Successfully!", MyOrders });
    }

    else{
        return next(new ErrorHandler("User Not Found!", 501));
    }
})

module.exports = MyOrdersRouter;