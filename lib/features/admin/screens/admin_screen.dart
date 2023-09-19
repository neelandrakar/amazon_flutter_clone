import 'package:amazon_clone/features/admin/screens/appbar_admin.dart';
import 'package:amazon_clone/features/admin/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class AdminScreen extends StatefulWidget {

  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const ProductsScreen(),
    const Center(
      child: Text('Analytics Page'),
    ),    const Center(
      child: Text('Orders Page'),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
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
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ''),
          //Orders
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
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: ''),
        ],
      ),
    );
  }


  PreferredSize appBarMethod() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariable.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/amazon_in.png',
                width: 120,
                height: 45,
                color: Colors.black,
              ),
            ),
            const Text('Admin',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}
