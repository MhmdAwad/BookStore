import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/providers/UserProvider.dart';
import 'package:book_store/screens/AuthScreen.dart';
import 'package:book_store/screens/MainCategoryScreen.dart';
import 'package:book_store/screens/SpecificCategory.dart';
import 'package:book_store/screens/SplashScreen.dart';
import 'package:book_store/screens/UploadBookScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => BooksProvider()),
//        ChangeNotifierProvider(create: (ctx) => CategoriesProvider()),
        ChangeNotifierProxyProvider<UserProvider, CategoriesProvider>(
          update: (ctx, auth, _) => CategoriesProvider(
            auth.token,
            auth.userId,
          ),
        ),
      ],
      child: Consumer<UserProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'BookStore',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontSize: 20, color: Colors.black))),
          home: auth.isAuth
              ? MainCategoryScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.ROUTE_NAME: (ctx) => AuthScreen(),
            SpecificCategory.ROUTE_NAME: (ctx) => SpecificCategory(),
            UploadBookScreen.ROUTE_NAME: (ctx) => UploadBookScreen(),
          },
        ),
      ),
    );
  }
}
