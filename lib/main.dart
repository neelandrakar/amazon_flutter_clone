import 'dart:async';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String authkey ='';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  fetchUserData() async {
    authService.getUserData(context);
    setState(() {
    });
  }

  loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    print('Fetched token is $token');
  }

  @override
  void initState() {

    Future.delayed(Duration.zero,() {
      authService.getUserData(context);
    });
    loadUsername();
    // TODO: implement initState
    super.initState();

  }

  void asyncfun() async{
    print("this is an async function!");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: GlobalVariable.backgroundColor,
          colorScheme:
              ColorScheme.light(primary: GlobalVariable.secondaryColor),
          appBarTheme: AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? BottomBar() : AdminScreen()
          : const AuthScreen(),
    );
  }
}
