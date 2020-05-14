import 'package:finalproject/services/login_services.dart';
import 'package:finalproject/shop/profileShop/information_shop.dart';
import 'package:finalproject/shop/profileShop/update_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileShop extends StatefulWidget {
  @override
  _ProfileShopState createState() => _ProfileShopState();
}

class _ProfileShopState extends State<ProfileShop> {
  final loginServices = new Login();
  var proFile;
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';
  var email;
  var uid;

  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        proFile = user.photoUrl;
        email = user.email;
        uid = user.uid;
      });
    }).catchError((e){
      print('first Error $e');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  color: Colors.blueGrey[600],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  proFile ?? inStead
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      email ?? 'Email', style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>InformationShop())
                      );
                    },
                    leading: Icon(
                      Icons.event,
                    ),
                    title: Text(
                      'Status',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    trailing: Icon(
                        Icons.arrow_forward_ios
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>UpdateShop(uid))
                      );
                    },
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text(
                      'Setting Profile',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                    trailing: Icon(
                        Icons.arrow_forward_ios
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  ListTile(
                    onTap: (){
                      loginServices.singOut(context);
                    },
                    leading: Icon(
                      Icons.power_settings_new,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}