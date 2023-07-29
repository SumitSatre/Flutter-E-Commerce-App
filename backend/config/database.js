const mongoose = require("mongoose");

let DatabaseConnect = async ()=>{
    try{
        await mongoose.connect(process.env.DB_URL);
        console.log("Connected");
    }
    catch(error){
        console.log("error" , error);
    }
}

module.exports = DatabaseConnect;