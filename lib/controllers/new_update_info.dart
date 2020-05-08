import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewUpdateInfo {
  Future updateProfilePic(picUrl, context) {
    var userInfo = new UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    FirebaseAuth.instance.currentUser().then((user){
      user.updateProfile(userInfo);
      FirebaseAuth.instance.currentUser().then((user) {
        user.updateProfile(userInfo);
        Firestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance
              .document('users/${docs.documents[0].documentID}')
              .updateData({'proFile': picUrl}).then((val) {
            print('ok');
          }).then((user) {
            print('ok wow');
          }).catchError((e) {
            print('can\'t change pages ${e}');
          });
        }).catchError((e) {
          print('users error ${e}');
        });
      }).catchError((e) {
        print('update pic er ${e}');
      });
    }).catchError((e){
      print('first er $e');
    });
  }

  Future shopUpdatePic(picUrl, context) {
    var userInfo = UserUpdateInfo();
    userInfo.photoUrl = picUrl;
    FirebaseAuth.instance.currentUser().then((user){
      user.updateProfile(userInfo);
      FirebaseAuth.instance.currentUser().then((user) {
        user.updateProfile(userInfo);
        Firestore.instance.collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments()
            .then((docs) {
          Firestore.instance.document('users/${docs.documents[0].documentID}')
              .updateData({'proFile': picUrl}).then((val){
            print('ok');
          }).then((user){
            print('shop ok');
          }).catchError((e){
            print('can\'t change page shop');
          });
        }).catchError((e){
          print('shop error ${e}');
        });
      }).catchError((e){
        print('update shop er ${e}');
      });
    }).catchError((e){
      print('first error shop $e');
    });
  }
}