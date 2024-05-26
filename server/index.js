console.log("Hello World!");

//import from packages
const express = require('express');
const mongoose = require('mongoose');
//import from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productsRouter = require('./routes/products');
const userRouter = require('./routes/user');
const paymentMethodRouter = require('./routes/payment_methods');

//init
const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://neelandra:pass123@neelcluster.k9w4ake.mongodb.net/?retryWrites=true&w=majority';

//middleware
app.use(express.json());
app.use(adminRouter);
app.use(authRouter);
app.use(productsRouter);
app.use(userRouter);
app.use(paymentMethodRouter);

//connections
mongoose.connect(DB)
.then(()=>{
    console.log('Connected Successfully');
})
.catch((e)=>{
    console.log(`Error while connecting. Error: ${e}`);
});


app.listen(PORT,'0.0.0.0',function(){
    console.log(`Connected at ${PORT}`);
});

//Creating an API
//GET, PUT, POST, DELETE, UPDATE -> CRUD

