import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {

  final HomeServices homeServices = HomeServices();

  Product? product;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchDealOfTheDay();
    });
  }

  void fetchDealOfTheDay() async{

    product = await homeServices.getDealOfTheDay(context: context);
    setState(() {

    });
}

  void navigateToProductDetailsScreen(BuildContext context,Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }

  String dealOfTheDay =
      'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2014%2F04%2Fnike-unveils-2014-mercurial-superfly-0.jpg?w=960&cbr=1&q=90&fit=max';

  @override
  Widget build(BuildContext context) {
    return product == null
    ? const Loader()
    : product!.name.isEmpty
    ? const SizedBox()
    : GestureDetector(
      onTap: (){
        navigateToProductDetailsScreen(context, product!);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10, top: 15),
            child: Text(
              'Deal of the day',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Image.network(
            product!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15,top: 2),
            alignment: Alignment.topLeft,
            child: Text(
            "₹${product!.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500

              ),
            ),


          ),
          Container(
            padding: const EdgeInsets.only(left: 15,right: 30,top: 2),
            alignment: Alignment.topLeft,
            child:  Text(
                product!.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(

            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                product!.images.
                map((e) => Image.network(
                    e,
                    fit: BoxFit.fitWidth,
                    width: 100,
                    height: 100)).toList(),

            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See all deals',
              style: TextStyle(
                color: Colors.cyan[800],
                decoration: TextDecoration.underline
              ),
            ),
          )
        ],
      ),
    );
  }
}
