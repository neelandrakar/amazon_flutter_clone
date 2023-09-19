import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../product_details/screens/product_details_screen.dart';

class SearchedProduct extends StatefulWidget {

  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  void navigateToProductDetailsScreen(BuildContext context,Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }

  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();

    if (widget.product != null && widget.product.rating != null) {
      double totalRating = 0;
      for (int i = 0; i < widget.product.rating!.length; i++) {
        totalRating += widget.product.rating![i].rating;

        if (widget.product.rating![i].userId ==
            Provider.of<UserProvider>(context, listen: false).user.id) {
          myRating = widget.product.rating![i].rating;
          print('my rating is $myRating');
        }
      }

      if (totalRating != 0) {
        avgRating = totalRating / widget.product.rating!.length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateToProductDetailsScreen(context, widget.product);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image.network(
              widget.product.images[0],
              fit: BoxFit.fitHeight,
               height: 135,
              width: 135,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text(widget.product.name,
                  style: TextStyle(
                    fontSize: 15
                  ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Stars(rating: avgRating,raterCount: widget.product.rating!.length,),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text(
                    '\₹${widget.product.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                  )
                ),
                Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10,top: 5),
                    child: Text(
                      'FREE Delivery by Amazon',
                      maxLines: 1,
                    ),
                    ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Text(
                    widget.product.quantity <=5 ? 'Only ${widget.product.quantity.toInt()} left in stock' : 'In Stock',
                    style: TextStyle(
                      color: Colors.teal
                    ),
                    maxLines: 1,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
