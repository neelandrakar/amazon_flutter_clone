import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widget/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';
import '../../../constants/loader.dart';
import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';
import '../../product_details/screens/product_details_screen.dart';

class SearchScreen extends StatefulWidget {

  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? productList;
  final SearchServices searchServices = SearchServices();

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  void navigateToProductDetailsScreen(BuildContext context,Product product){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchSearchedProducts();
    });
  }

  fetchSearchedProducts() async {
    productList = await searchServices.fetchSearchedProducts(
        context: context, query: widget.searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMethod(),
        body: productList == null
        ? const Loader()
        : Column(
          children: [
            const AddressBox(),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                  itemCount: productList!.length,
                    itemBuilder: (context,index){
                    return SearchedProduct(product: productList![index]);
                }))
          ],
        )
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
                      initialValue: widget.searchQuery,
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
