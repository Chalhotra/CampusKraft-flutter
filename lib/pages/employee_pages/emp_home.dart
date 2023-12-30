import 'package:flutter/material.dart';
import 'package:ig_clone/pages/employee_pages/emp_bookings.dart';
import 'package:ig_clone/pages/employee_pages/emp_requests.dart';
import 'package:ig_clone/pages/employee_profile_page.dart';

class EmployeeHome extends StatefulWidget {
  const EmployeeHome({super.key});

  @override
  State<EmployeeHome> createState() => _EmployeeHomeState();
}

class _EmployeeHomeState extends State<EmployeeHome> {
  List<Widget> pages = [
    EmployeeProfilePage(),
    EmployeeRequests(),
    EmployeeBookings()
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.request_page), label: "Requests"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Bookings")
        ],
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
