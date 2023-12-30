// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required int enrollment,
    required String name,
  }) async {
    String auth_id = "${enrollment}@campuskraft.com";
    String res = "Some error occurred";
    try {
      if (auth_id.isNotEmpty || password.isNotEmpty) {
        //signup
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: auth_id, password: password);

        //add user to db
        _firestore.collection('users').doc(enrollment.toString()).set({
          'name': name,
          'mail': email,
          'enrollment_number': enrollment,
          'password': password,
          'uid': cred.user!.uid,
          'auth_id': auth_id,
          'cart': [],
        });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required int enrollment, required String password}) async {
    final String email = "${enrollment}@campuskraft.com";
    String res = "Some Error occurred";
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      if (password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(cred);
        if (cred.additionalUserInfo!.isNewUser == false) {
          res = 'success';
        }
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future<String> signUpEmployee(
      {required String email,
      required String password,
      required int emp_id,
      required String name,
      required String service,
      required int number}) async {
    String auth_id = "${emp_id}@employee.campuskraft.com";
    String res = "Some error occurred";
    try {
      if (auth_id.isNotEmpty || password.isNotEmpty) {
        //signup
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: auth_id, password: password);

        //add user to db
        _firestore.collection('service_providers').doc(emp_id.toString()).set({
          'name': name,
          'mail': email,
          'employee_id': emp_id,
          'password': password,
          'uid': cred.user!.uid,
          'auth_id': auth_id,
          'service': service,
          'phone_number': number
        });

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginEmployee(
      {required int emp_id, required String password}) async {
    final String email = "${emp_id}@employee.campuskraft.com";
    String res = "Some Error occurred";
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      if (password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(cred); //print statement for debugging
        if (cred.additionalUserInfo!.isNewUser == false) {
          res = 'success';
        }
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
