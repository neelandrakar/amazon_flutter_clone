const express = require('express');
const auth = require('../middleware/auth');
const Product = require('../models/product');


const productsRouter = express.Router();

//Get category wise products products

productsRouter.get('/api/products', auth, async (req,res) => { 
    try{

        console.log(req.query.category);
        const products = await Product.find({
            category: req.query.category
        });
        res.json(products);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Get searched products

productsRouter.get('/api/products/search/:name', auth, async (req,res) => { 
    try{

        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i"}
        });
        res.json(products);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Rate a product

productsRouter.post('/api/rate-product',auth, async (req,res) => {

    try{

        const{id, rating} = req.body;
        let product = await Product.findById(id);

        for(let i=0; i<product.ratings.length; i++){

            if(product.ratings[i].userId == req.user){

                product.ratings.splice(i,1);   //Deleting if there is an rating with the same userId
                break;
            }
        }
            const ratingSchema = {
                userId: req.user,
                rating,
            }

            product.ratings.push(ratingSchema);   //Setting new rating for the product
            product = await product.save();
            res.json(product); 
        
        
    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

module.exports = productsRouter;