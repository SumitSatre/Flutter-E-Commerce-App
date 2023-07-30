const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const UserModel = require('../models/UserModel');
const ErrorHandler = require("../errorHandler");

let UserRouter = express.Router();

function isValidEmail(email) {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
  }
  
UserRouter.post("/signup", async (req, res, next) => {

    const { name, email, password, contact } = req.body;

    /* first checking all the details */

    // This is used to check email is valid or not
    if(!isValidEmail(email)){
        return next(new ErrorHandler("Please enter correct email!!" , 501));
    }

    // This is used to check password has minimum 6 letters or not
    if(password.length < 6){
        return next(new ErrorHandler("Please enter minimum 6 letter password!!" , 501));
    }
    
    // used to check contact is exactly 10 letters or not
    if(contact.toString().length != 10){
        return next(new ErrorHandler("Please enter correct contact!!" , 501));
    }

    // Ckeck if email and contact already present in databse or not
    const checkEmail = await UserModel.find({email : email });
    const checkContact = await UserModel.find({contact : contact});

    if(checkEmail.length > 0){
        return next(new ErrorHandler("Email already exist!!" , 501));
    }

    if(checkContact.length > 0){
        return next(new ErrorHandler("Contact already exist!!" , 501));
    }

    /* If correct Starting the process to create user */

    // Hash the password
    const securePassword = await bcrypt.hash(password, 10); // 10 is the salt rounds

    // Create the user in the database
    await UserModel.create({
        name,
        email,
        password: securePassword,
        contact,
    });

    const data = { email: email };

    const authToken = jwt.sign(data, process.env.JWtSecret);

    res.status(201).json({
        status: 201, success: true, message: "User registered successfully!",
        authToken: authToken
    });

});


UserRouter.post("/login", async (req, res, next) => {

    let email = req.body.email;
    let user = await UserModel.findOne({ email });

    if (!user) {
        return next(new ErrorHandler("User Not Found!!", 501));
    }

    const pwdCompare = await bcrypt.compare(req.body.password, user.password);

    if (!pwdCompare) {
        return next(new ErrorHandler("Enter Correct Password!!", 501));
    }

    const data = { email: email };
    const authToken = jwt.sign(data, process.env.JWtSecret);

    res.send({
        statusCode: 200, success: true,
        authToken: authToken, message: "User created Successfully!!"
    });


})

module.exports = UserRouter;