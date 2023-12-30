import 'package:flutter/material.dart';
import 'package:ig_clone/pages/cart_page.dart';
import 'package:ig_clone/pages/home_page.dart';
import 'package:ig_clone/pages/profile_page.dart';

class ShopAppHomePage extends StatefulWidget {
  const ShopAppHomePage({super.key});

  @override
  State<ShopAppHomePage> createState() => _ShopAppHomePageState();
}

class _ShopAppHomePageState extends State<ShopAppHomePage> {
  int currentPage = 0;
  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black26,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  );
  final focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black26,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              label: 'Requests'),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
                size: 30,
              )),
        ],
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
