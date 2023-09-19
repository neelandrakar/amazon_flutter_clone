import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp; //Checking signup as default
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signInUser() {
    authService.signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundColor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signUp)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _nameController, hintText: 'Name'),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        SizedBox(height: 5),
                        CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundColor,
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        SizedBox(height: 5),
                        CustomButton(
                            text: 'Sign In',
                            onTap: (){
                             if(_signInFormKey.currentState!.validate()){
                               signInUser();
                             }
                            }
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
