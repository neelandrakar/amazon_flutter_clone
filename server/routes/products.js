const express = require('express');
const auth = require('../middleware/auth');
const {Product} = require('../models/product');
const User = require('../models/user');


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

//Deal of the day

productsRouter.get('/api/deal-of-the-day', auth, async (req,res) => { 
    try{

        let products = await Product.find({});

        products = products.sort((a,b) => {
            
            let aSum = 0;
            let bSum = 0;

            for(let i=0; i<a.ratings.length; i++){

                aSum+=  a.ratings[i].rating;
            }

            for(let i=0; i<b.ratings.length; i++){

                bSum+=  b.ratings[i].rating;
            }

            return aSum < bSum ? 1 : -1;

        });

        res.json(products[0]);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});

//Check if product is already added to cart

productsRouter.get('/api/products/get-cart-status', auth, async (req,res) => { 
    try{

        let isAddedToCart = false;

        console.log(req.query._id);
        const product = await Product.find({
            _id: req.query._id
        });
        //console.log(product[0].name);

        let user = await User.findById(req.user);
        
        if(user.cart.length == 0){

            isAddedToCart= false

        } else{

            let isProductFound = false;

            for(let i=0; i<user.cart.length; i++){

                if(user.cart[i].product._id.equals(product[0]._id)){

                    isProductFound = true;
                } else{
                    isProductFound = false;
                }
            }

            if(isProductFound){

                isAddedToCart = true;

            } else{

                isAddedToCart = false;

            }
        }

        res.send(isAddedToCart);
       // res.send(product._id);

    }catch(e){
        res.status(500).json({msg: e.message});
    }
});


module.exports = productsRouter;