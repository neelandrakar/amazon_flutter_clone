import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/screen/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  static const String routeName = '/actual-home';

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final user = context.watch<UserProvider>().user;
    int itemCount = 0;
    user.cart.map((e) => itemCount+= e['quantity'] as int).toList();

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariable.selectedNavBarColor,
        unselectedItemColor: GlobalVariable.unselectedNavBarColor,
        backgroundColor: GlobalVariable.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomNavBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          //Cart
          BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomNavBarBorderWidth))),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ''),
          //Cart
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomNavBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 2
                                  ? GlobalVariable.selectedNavBarColor
                                  : GlobalVariable.backgroundColor,
                              width: bottomNavBarBorderWidth))),
                  child:  Badge(
                    label: Text(itemCount.toString()),
                    child: Icon(Icons.shopping_cart_outlined),
                  )),
              label: ''),
        ],
      ),
    );
  }
}
