const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const UserModel = require('../models/UserModel');

let UserRouter = express.Router();

UserRouter.post("/signup", async (req, res) => {
    try {
        const { name, email, password, contact } = req.body;

        // Hash the password
        const securePassword = await bcrypt.hash(password, 10); // 10 is the salt rounds

        // Create the user in the database
        await UserModel.create({
            name,
            email,
            password: securePassword,
            contact,
        });

        const data = {email : email};

        const authToken = jwt.sign(data , process.env.JWtSecret);

        res.status(201).json({ status: 201, success: true, message: "User registered successfully!" ,
         authToken : authToken });
    } catch (error) {
        res.status(400).json({ status: 400, success: false, message: error.message });
    }
});


UserRouter.post("/login" , async (req , res)=>{
    try{
        let email = req.body.email ;
        let user = await UserModel.findOne({email});

        if(!user){
            return res.send({status : 400 , success : false , message : "User does not exist!!"});
        }

        const pwdCompare = await bcrypt.compare(req.body.password , user.password);

        if(!pwdCompare){
            return res.status(400).json({ status: 400, success: false, message: "Enter Correct Password" });
        }
        
        const data = {email : email};
        const authToken = jwt.sign(data , process.env.JWtSecret);

        res.send({status : 200 , success : true ,
            authToken : authToken , message : "User created Successfully!!"});
    }
    catch(error){
        res.send({status : 400 , success : false , message : error.message});
    }
})

module.exports = UserRouter;