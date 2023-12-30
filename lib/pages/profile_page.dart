import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ig_clone/auth_methods.dart';
import 'package:ig_clone/pages/user_bookings.dart';
import 'package:ig_clone/pages/user_login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name = "";
  int enrollment = 0;
  String email = "";
  List<dynamic> cart = [];

  Future<void> getUserInfo() async {
    DocumentSnapshot snap = await _firestore
        .collection('users')
        .doc(_auth.currentUser!.email!.substring(0, 8))
        .get();

    setState(() {
      name = (snap.data() as Map<String, dynamic>)['name'];
      email = (snap.data() as Map<String, dynamic>)['mail'];
      enrollment = (snap.data() as Map<String, dynamic>)['enrollment_number'];
      cart = (snap.data() as Map<String, dynamic>)['cart'];
    });
  }

  List<dynamic> get pintucart => cart;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 64,
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("$name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     shape: BoxShape.rectangle,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(
                    //       color: Colors.black,
                    //       width: 0,
                    //     )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enrollment\nNumber:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("$enrollment",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    )),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email Address:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('$email',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserBookingPage(),
                  ));
                },
                child: Text("Booking History",
                    style: TextStyle(
                        color: Color.fromRGBO(48, 48, 48, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
          ),
          SizedBox(height: 0),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {
                  AuthMethods().logOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text("Logout",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
          )
        ],
      ),
    ));
  }
}
