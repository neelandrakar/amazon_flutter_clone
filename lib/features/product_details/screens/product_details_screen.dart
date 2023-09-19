import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/stars.dart';
import '../../../constants/global_variable.dart';
import '../../../models/product.dart';
import '../../search/screen/search_screen.dart';
import '../services/product_details_services.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {


  final ProductDetailsServices productDetailsServices = ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;


  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

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
    return Scaffold(
      appBar: appBarMethod(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.id!,
                  ),
                  Stars(
                    rating: avgRating, raterCount: widget.product.rating!.length,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                    (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal Price: ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\₹${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Buy Now',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: (){},
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.only(left: 5,bottom: 5),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariable.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                    context: context,
                    product: widget.product,
                    rating: rating);
                print('New rating is $rating');
              },
            )
          ],
        ),
      ),
    );
  }

  PreferredSize appBarMethod() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariable.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                              borderSide:
                              BorderSide(
                                  color: Colors.black38,
                                  width: 1)
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontSize: 15
                          )
                      ),
                    ),
                  )),
            ),
            Container(
              color: Colors.transparent,
              height: 42,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(
                Icons.mic,
                color: Colors.black,
                size: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
