import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserBookingPage extends StatefulWidget {
  const UserBookingPage({super.key});

  @override
  State<UserBookingPage> createState() => _UserBookingPageState();
}

class _UserBookingPageState extends State<UserBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email!.substring(0, 8))
            .collection('bookings')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final bookList = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (context, index) {
              final currentBook = bookList[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 10,
                  child: Image.asset(currentBook['imageUrl']),
                ),
                title: Text(
                    "${currentBook['bhawan']} Bhawan, ${currentBook['room']}"),
                subtitle: Text(currentBook['date']),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      )),
    );
  }
}
