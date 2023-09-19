import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/screen/account_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBarAdmin extends StatefulWidget {
  const BottomBarAdmin({super.key});
  static const String routeName = '/actual-home';

  @override
  State<BottomBarAdmin> createState() => _BottomBarAdminState();
}

class _BottomBarAdminState extends State<BottomBarAdmin> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const Center(
      child: Text('Analytics Page'),
    ),     const Center(
      child: Text('Analytics Page'),
    ),    const Center(
      child: Text('Orders Page'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                            color: _page == 1
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomNavBarBorderWidth))),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: ''),
        ],
      ),
    );
  }
}
