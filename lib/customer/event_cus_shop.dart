import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/checkouts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventCusShop extends StatefulWidget {
  String evID;
  EventCusShop(this.evID);
  @override
  _EventCusShopState createState() => _EventCusShopState();
}

class _EventCusShopState extends State<EventCusShop> {
  var uid;

  _deal(String userId)async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
    if (uid != userId) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            elevation: 1.1,
            title: Text('You can\'t deal'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  print('OKayy');
                  print(userId);
                },
                child: Text('OK',style: TextStyle(color: Colors.red),),
              )
            ],
          );
        }
      );
    }else{
      return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            elevation: 1.1,
            title: Text('OK'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  print('ok112');
                },
                child: Text('ok'),
              ),
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: Firestore.instance.collection('events').document(widget.evID).collection('shopJoin').orderBy('joinAt',descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: Text('Null'),
              );
            }else{
              return ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot docs) =>
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey,width: 2),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(docs['shopPic'])
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(docs['shopEmail']),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Price : ' + docs['shopPrice']),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Quantity : ' + docs['shopAmount']),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          RaisedButton(
                            onPressed: (){
                              print('okok');
                              _deal(docs['userId']);
                            },
                            elevation: 1.1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)
                            ),
                            focusColor: Colors.red,
                            splashColor: Colors.red,
                            color: Colors.blueGrey[300],
                            child: Text('Deal' , style: TextStyle(fontSize: 22,color: Colors.white),),
                          ),
                        ],
                      ),
                  ).toList()
              );
            }
          },
        ),
//      body: SafeArea(
//        child: ListView(
//          children: <Widget>[
//            SizedBox(
//              height: 10.0,
//            ),
//            ListTile(
//              leading: CircleAvatar(
//                maxRadius: 35.0,
//                backgroundImage: AssetImage('assets/prototype/sony.jpg'),
//              ),
//              trailing: RaisedButton(
//                onPressed: (){
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context)=>Checkouts())
//                  );
//                },
//                elevation: 1.1,
//                color: Colors.blueGrey[400],
//                child: Text('Deal',style: TextStyle(color: Colors.white),),
//              ),
//              title: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text('Price : 1500.00'),
//                  Text('Quantity : 120'),
//                  SizedBox(
//                    height: 5,
//                  ),
//                ],
//              ),
//              subtitle: Text('Shop : Sony Thailand'),
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20.0),
//              child: Divider(
//                height: 4.8,
//                color: Colors.grey,
//              ),
//            ),
//            ListTile(
//              leading: CircleAvatar(
//                maxRadius: 35.0,
//                backgroundColor: Colors.transparent,
//                backgroundImage: AssetImage('assets/prototype/razer.jpg'),
//              ),
//              trailing: RaisedButton(
//                onPressed: (){},
//                elevation: 1.1,
//                color: Colors.blueGrey[400],
//                child: Text('Deal',style: TextStyle(color: Colors.white),),
//              ),
//              title: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text('Price : 1500.00'),
//                  Text('Quantity : 120'),
//                  SizedBox(
//                    height: 5,
//                  ),
//                ],
//              ),
//              subtitle: Text('Shop : AAAA'),
//            ),
//          ],
//        ),
//      ),
    );
  }
}