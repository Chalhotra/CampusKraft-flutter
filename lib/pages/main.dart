import 'package:flutter/material.dart';

import 'package:ig_clone/pages/shop_app_home.dart';

// import 'package:shop_app_proj/product_details_page.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Colors.black;
    return MaterialApp(
      home: const ShopAppHomePage(),
      title: "Shopping App",
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          primary: seedColor,
        ),
        textTheme: const TextTheme(
            titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 25, color: Colors.black),
        ),
      ),
    );
  }
}
