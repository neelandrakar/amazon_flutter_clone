const express = require('express');
const admin = require('../middleware/admin');
const {Product} = require('../models/product');


const adminRouter = express.Router();


//Adding product
adminRouter.post('/admin/add-product',admin, async(req,res) => {
    try{
        const{name, description, images, quantity, price, category} = req.body;

        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });

        product = await product.save();  //Saving to dataabse
        res.json(product);              // Returning data to client site


    } catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Get all the products

adminRouter.get('/admin/get-products',admin, async (req,res) => { 
    try{
        const products = await Product.find({});
        res.json(products);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Delete a product

adminRouter.post('/admin/delete-product',admin, async (req,res) => {

    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);

    }catch(e){
        res.status(500).json({msg: e.message});
    }

});

module.exports = adminRouter;

