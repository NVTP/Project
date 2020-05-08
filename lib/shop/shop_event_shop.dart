import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopEventShop extends StatefulWidget {
  String evID;
  ShopEventShop(this.evID);
  @override
  _ShopEventShopState createState() => _ShopEventShopState();
}

class _ShopEventShopState extends State<ShopEventShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('events').document(widget.evID).collection('shopJoin').orderBy('joinAt',descending: true).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: Text('Null',style: TextStyle(fontSize: 25,color: Colors.red),),
            );
          }else{
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot docs) =>
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 23,
                    ),
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
                        Row(
                          children: <Widget>[
                            Text('Price : ' + docs['shopPrice']),
                            SizedBox(
                              width: 12,
                            ),
                            Text('Quantity : ' + docs['shopAmount']),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ).toList()
            );
          }
        },
      ),
//      body: SafeArea(
//        child: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//                height: 5.0,
//              ),
//              ListTile(
//                leading: CircleAvatar(
//                  backgroundColor: Colors.transparent,
//                  backgroundImage: AssetImage(
//                    'assets/images/xiaomi.png',
//                  ),
//                ),
//                title: Text('Shop Sony Thailand'),
//                subtitle: Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Price : 1500.00'),
//                    SizedBox(
//                      width: 10.0,
//                    ),
//                    Text('Quantity : 120'),
//                  ],
//                ),
//              ),
//              Divider(
//                height: 5.0,
//                color: Colors.grey,
//              ),
//            ],
//          ),
//        ),
//      ),
    );
  }
}