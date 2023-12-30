import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<dynamic> cart = [];

  void addToCart(Map<String, dynamic> product) {
    cart.add(product);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email!.substring(0, 8))
        .update({'cart': cart});
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    cart.remove(product);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email!.substring(0, 8))
        .update({'cart': cart});
    notifyListeners();
  }
}
