import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/controlPageCustomer/main_customer.dart';
import 'package:finalproject/login_ui.dart';
import 'package:finalproject/shop/controlPageShop/main_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget handleAuth() {}

  singOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginUI()),
        ModalRoute.withName('/'));
  }

  Future singInAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        if (doc.documents[0].exists) {
          if (doc.documents[0].data['role'] == 'user') {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (context)=>MainCustomer()),
//                ModalRoute.withName('/'));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainCustomer()));
          } else {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(builder: (context)=>MainShop()),
//                ModalRoute.withName('/'));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainShop()));
          }
        }
      });
    } else {
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        if (doc.documents[0].exists) {
          if (doc.documents[0].data['role'] == 'user') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainCustomer()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MainShop()));
          }
        }
      });
    }
  }
}