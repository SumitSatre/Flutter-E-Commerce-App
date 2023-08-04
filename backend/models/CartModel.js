const mongoose = require("mongoose");

let UserSchema = new mongoose.Schema({
    email : {
        type: String,
        required: [true, "Please Enter the Email"]
    },
    cartData: {
        type: Array,
        required: [true, "Please Enter the Contact Number"]
    }
});

module.exports = mongoose.model("carts", UserSchema);
