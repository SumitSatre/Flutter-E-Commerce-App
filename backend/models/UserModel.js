const mongoose = require("mongoose");

let UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, "Please Enter the name"]
    },
    contact: {
        type: String,
        required: [true, "Please Enter the Contact Number"]
    },
    email: {
        type: String,
        required: [true, "Please Enter the Email"]
    },
    password: {
        type: String,
        required: [true, "Please Enter the Password"],
    }
});

module.exports = mongoose.model("users", UserSchema);
