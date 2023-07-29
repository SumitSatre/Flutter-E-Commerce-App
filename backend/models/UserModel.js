const mongoose = require("mongoose");
const uniqueValidator = require("mongoose-unique-validator");

let UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, "Please Enter the name"]
    },
    contact: {
        type: String,
        required: [true, "Please Enter the Contact Number"],
    },
    email: {
        type: String,
        required: [true, "Please Enter the Email"],
        unique: true // This will ensure that the email is unique
    },
    password: {
        type: String,
        required: [true, "Please Enter the Password"]
    }
});

// Apply the uniqueValidator plugin to the UserSchema
UserSchema.plugin(uniqueValidator);

module.exports = mongoose.model("users", UserSchema);
