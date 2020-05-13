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

  _deal(String userId, String shopID, String shopAmount, String shopPic, String shopPrice, String shopEmail) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
    if (uid != userId) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 1.1,
              title: Text('You can\'t deal'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('OKayy');
                    print(userId);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 1.1,
              title: Text('OK'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    _chooseShop(shopID, shopAmount, shopPic, shopPrice, shopEmail);
                    print('ok112');
                  },
                  child: Text('ok'),
                ),
              ],
            );
          });
    }
  }

  _chooseShop(String shopID, String shopAmount, String shopPic, String shopPrice, String shopEmail) async {
    DocumentReference docRef = Firestore.instance.collection('events').document(widget.evID);
    docRef.setData({
      'shopOwnId':shopID,
      'shopAmount' : shopAmount,
      'shopPic':shopPrice,
      'shopPrice':shopPic,
      'shopEmail':shopEmail,
      'stauts':'Wait pay'
    },merge: true).then((value){
      print('choose shop ok');
      Navigator.pop(context);
    }).catchError((e){
      print('ert $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('events')
            .document(widget.evID)
            .collection('shopJoin')
            .orderBy('joinAt', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Null'),
            );
          } else {
            List<DocumentSnapshot> reversedDocuments = snapshot.data.documents.reversed.toList();
            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                  child: Divider(
                    height: 1,
                    color: Colors.red,
                  ),
                );
              },
              itemCount: reversedDocuments.length,
              itemBuilder: (context, index) {
                var shopId = reversedDocuments[index].data['shopID'];
                var shopEmail = reversedDocuments[index].data['shopEmail'];
                var shopPic = reversedDocuments[index].data['shopPic'];
                var shopPrice = reversedDocuments[index].data['shopPrice'];
                var shopAmount = reversedDocuments[index].data['shopAmount'];
                return Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                reversedDocuments[index].data['shopPic']),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(reversedDocuments[index].data['shopEmail']),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Price : ' +
                            reversedDocuments[index].data['shopPrice']),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Quantity : ' +
                            reversedDocuments[index].data['shopAmount']),
                      ],
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    RaisedButton(
                      onPressed: () {
                        print('okok');
                        _deal(
                          reversedDocuments[index].data['userId'],
                          shopId,
                          shopAmount,
                          shopPrice,
                          shopPic,
                          shopEmail
                        );
                      },
                      elevation: 1.1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      focusColor: Colors.red,
                      splashColor: Colors.red,
                      color: Colors.blueGrey[300],
                      child: Text(
                        'Deal',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
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
