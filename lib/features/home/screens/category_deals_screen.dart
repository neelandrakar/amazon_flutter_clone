import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';
import '../../product_details/screens/product_details_screen.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/category-deals';
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchCategoryProducts();
    });
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  void navigateToProductDetailsScreen(BuildContext context,Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMethod(),
        body: productList == null
            ? Loader()
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Keep shopping for ${widget.category}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: GridView.builder(
                        itemCount: productList!.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = productList![index];
                          return GestureDetector(
                            onTap: (){
                              navigateToProductDetailsScreen(context, product);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 140,
                                  child: SingleProduct(
                                    productUrl: product.images[0],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }

  PreferredSize appBarMethod() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
