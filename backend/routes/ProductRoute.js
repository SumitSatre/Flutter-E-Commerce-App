const express = require("express");
const mongoose = require("mongoose");

const ProductRouter = express.Router();

ProductRouter.get("/products", async (req, res) => {

    const response = await mongoose.connection.db.collection("products");
    const productsData = await response.find({}).toArray();

    res.send({ success: true, statusCode: 200, message: "Data Shared Successfully!", productsData });

})

ProductRouter.get("/products/:category", async (req, res) => {

    const category = req.params.category;

    const response = await mongoose.connection.db.collection("products");
    const filteredData = await response.find({category}).toArray();

    res.send({ success: true, statusCode: 200, message: "Data Shared Successfully!", filteredData });

})

module.exports = ProductRouter;