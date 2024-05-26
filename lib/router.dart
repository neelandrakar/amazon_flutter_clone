import 'package:amazon_clone/features/account/screen/my_orders_screen.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/orderstepper/screen/order_stepper_screen.dart';
import 'package:amazon_clone/features/orderstepper/screen/order_success%20_screen.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/product_details/screens/product_details_screen.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case MyOrdersScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyOrdersScreen(),
      );

    case OrderStepperScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderStepperScreen(),
      );

    case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddressScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );

    case OrderSuccessScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderSuccessScreen(),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchScreen(
            searchQuery: searchQuery),
      );

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  ProductDetailsScreen(
            product: product),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  CategoryDealsScreen(
            category: category),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page not found 404!"),
                ),
              ));
  }
}
