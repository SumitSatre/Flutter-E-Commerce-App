const mongoose = require("mongoose");

let UserSchema = new mongoose.Schema({
    email : {
        type: String,
        required: [true, "Please Enter the Email"]
    },
    ordersData: {
        type: Array,
        required: [true, "Please Enter the Order data"]
    }
});

module.exports = mongoose.model("orders", UserSchema);
