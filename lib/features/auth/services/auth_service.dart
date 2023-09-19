import 'dart:convert';

import 'package:amazon_clone/constants/http_error_handle.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';

class AuthService {
  //Sign up the user

  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");

      http.Response res = await http
          .post(Uri.parse('$uri/api/signup/'), //Calling the sign up API
              body: user.toJson(),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(res.statusCode);
      print(res.body);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              "Account has been created...",
            );
          });
    } catch (e) {
      print("Error $e");
      showSnackBar(context, e.toString());
    }
  }

  //Sign In

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http
          .post(Uri.parse('$uri/api/signin/'), //Calling the sign up API
              body: jsonEncode({'email': email, 'password': password}),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(res.statusCode);
      print("Signed in req body " + res.body);
      print("Signed in res body " + res.body);

      HttpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences.setMockInitialValues({});
            SharedPreferences signInSP = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await signInSP.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            var getToken = signInSP.getString('x-auth-token');
            print("New token is saved $getToken");

            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);

            showSnackBar(
              context,
              "Successfully signed in",
            );
            Future<void> setUserLoggedIn(bool value) async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('loggedIn', value);
            }
          });
    } catch (e) {
      print("Error $e");
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    print('get user data method ran');
    try {
      // SharedPreferences.resetStatic()
      final signInSP = await SharedPreferences.getInstance();
      String? token = signInSP.getString('x-auth-token');

      print('saved token is $token');

      if(token==''){
        print('token is blank');
      }

      if (token == null) {
        signInSP.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userResp = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResp.body);
        bool tokenStatus = Provider.of<UserProvider>(context, listen: false)
            .user
            .token
            .isNotEmpty;
        print(token);
        print("Service is started $tokenStatus");
      }
    } catch (e) {

      print(e);
    }
  }
}
