import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  resetPass(){
    String email = emailController.text.trim();
    _auth.sendPasswordResetEmail(email: email);
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("We send the detail to $email successfully.",
          style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green[300],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3.1,
        title: Text('Reset Password',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration.collapsed(hintText: 'Email',hintStyle: TextStyle(color: Colors.white)),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18),
                      autofocus: true,
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      resetPass();
                    },
                    child: Text('Reset Email',style: TextStyle(color: Colors.white),),
                    elevation: 1.1,
                    color: Colors.blue,
                    splashColor: Colors.red,
                    focusColor: Colors.red,
                    highlightColor: Colors.red,
                    hoverColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
