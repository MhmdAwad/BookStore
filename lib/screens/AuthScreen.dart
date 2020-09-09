import 'dart:math';
import 'dart:ui';

import 'package:book_store/models/HttpException.dart';
import 'package:book_store/providers/UserProvider.dart';
import 'package:book_store/widgets/TextFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const String ROUTE_NAME = "AuthScreen";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "assets/images/login_book.jpg",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              child: Container(
                color: Colors.black12,
              ),
              filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
            ),
            AuthCard()
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  var expand = false;

  void changeCardHeight(bool changeExpand) {
    if (expand != changeExpand)
      setState(() {
        this.expand = changeExpand;
      });
  }

  void changeLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }
  void authentication(bool isLogin) async {
    if (!_form.currentState.validate()) {
      changeCardHeight(true);
      return;
    }
    changeCardHeight(false);
    changeLoading();
    try {
      if (isLogin)
        await Provider.of<UserProvider>(context, listen: false)
            .login(_emailController.text, _passwordController.text);
      else
        await Provider.of<UserProvider>(context, listen: false).signUp(
          _userNameController.text,
          _emailController.text,
          _passwordController.text,
        );
    } on HttpException catch (error) {
      _showErrorDialog(Provider.of<UserProvider>(context, listen: false)
          .authError(error.toString()));
      changeLoading();
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: expand ? deviceSize.height / 2 : 390,
      width: 360,
      alignment: Alignment.center,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Consumer<UserProvider>(
                builder: (ctx, user, _) => Column(
                  children: [
                    TextFormWidget(
                      "Email:",
                      _emailController,
                      TextInputAction.next,
                      false,
                      (val) {
                        if (val.isEmpty || !val.contains("@"))
                          return "Add a valid email.";
                        return null;
                      },
                    ),
                    if (!user.isLogin)
                      TextFormWidget(
                        "Username:",
                        _userNameController,
                        TextInputAction.next,
                        false,
                        (val) {
                          if (val.isEmpty) return "Add a valid username.";
                          return null;
                        },
                      ),
                    TextFormWidget(
                      "Password:",
                      _passwordController,
                      TextInputAction.next,
                      true,
                      (val) {
                        if (val.isEmpty)
                          return "Add a valid password.";
                        else if (val.length < 6)
                          return "Password must at least 6 characters";
                        return null;
                      },
                    ),
                    if (!user.isLogin)
                      TextFormWidget(
                        "Confirm Password:",
                        null,
                        TextInputAction.done,
                        true,
                        (val) {
                          if (val != _passwordController.text)
                            return "Passwords do not match!";
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            child: Text(
                              user.isLogin ? "Sign in" : "Sign up",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () => authentication(user.isLogin),
                          ),
                    FlatButton(
                      child: Text(
                        "${user.isLogin ? "SIGN UP" : "LOGIN"} INSTEAD.",
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: user.changeLoginStatus,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
