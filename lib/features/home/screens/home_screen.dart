import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/home/widgets/carousal_image.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: appBarMethod(),
      body: SingleChildScrollView(
        child: const Column(
          children: [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarousalImage(),
            DealOfTheDay()


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
