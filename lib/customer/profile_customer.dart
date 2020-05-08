import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/choice/customer_status.dart';
import 'package:finalproject/customer/choice/update_profile_customer.dart';
import 'package:finalproject/services/login_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileCustomer extends StatefulWidget {
  @override
  _ProfileCustomerState createState() => _ProfileCustomerState();
}

class _ProfileCustomerState extends State<ProfileCustomer> {
  final loginServices = new Login();
  var proFile;
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';
  var email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        proFile = user.photoUrl;
        email = user.email;
      });
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
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
                                  padding: EdgeInsets.symmetric(vertical: 20),
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
                            Text(email ?? 'Email',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>CustomerStatus())
                              );
                            },
                            leading: Icon(
                              Icons.person,
                            ),
                            title: Text(
                              'Profile',
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
                                  MaterialPageRoute(builder: (context)=>UpdateProfile())
                              );
                            },
                            leading: Icon(
                              Icons.settings,
                            ),
                            title: Text(
                              'Setting',
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
            ],
          ),
        ),
      ),
    );
  }
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('users').snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//        if(snapshot.hasError)
//          return Text('Error: ${snapshot.error}');
//        switch (snapshot.connectionState){
//          case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
//          default:
//            return ListView(
//              shrinkWrap: true,
//              children: snapshot.data.documents.map((DocumentSnapshot document){
//                return SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        width: 150.0,
//                        height: 150.0,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          image: DecorationImage(
//                            fit: BoxFit.cover,
//                              image: NetworkImage(
//                                  document['proFile'] == null ? proFile : document['proFile']
//                              )
//                          ),
//                        ),
//                      ),
//                      Text(document['role']),
//                      Text(document['email']),
//                    ],
//                  ),
//                );
//              }).toList(),
//            );
//        }
//      },
//    );
//  }
}