import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/shop/controlPageShop/main_event_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartShop extends StatefulWidget {
  @override
  _CartShopState createState() => _CartShopState();
}

class _CartShopState extends State<CartShop> {
  var uid;

  Future getEvents() async {
    QuerySnapshot snapshot = await Firestore.instance.collection('events')
        .orderBy('CreateAt', descending: true)
        .getDocuments();
    return snapshot.documents.length;
  }
  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        uid = user.uid;
      });
    }).catchError((e){
      print('err user $e');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refresh() async {
      await getEvents();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offer', style: TextStyle(color: Colors.white, fontSize: 20),),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          child: Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                StreamBuilder(
                  stream: Firestore.instance.collection('users').document(uid).collection('shopJoin').orderBy(
                      'joinAt', descending: false).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState == true) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<DocumentSnapshot> reversedDocuments = snapshot.data
                          .documents.reversed.toList();
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 22,
                              child: Divider(
                                height: 1,
                                color: Colors.red,
                              ),
                            );
                          },
                          itemCount: reversedDocuments.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(reversedDocuments[index].data['eventId']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            MainEventShop(
                                              reversedDocuments[index].data['eventId']
                                                  .toString(),
                                            ))
                                    );
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text('Loading...'),
                                        ),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300], width: 1),
                                          borderRadius: BorderRadius.circular(22),
                                          color: Colors.black12,
//                                          image: DecorationImage(
//                                              fit: BoxFit.cover,
//                                              image: NetworkImage(
//                                                  reversedDocuments[index]
//                                                      .data['image'].toString())
//                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                          reversedDocuments[index].data['productName']
                                              .toString())
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
      ),
//      body: SafeArea(
//        child: Center(
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//                height: 5.0,
//              ),
////              InkWell(
////                onTap: (){
////                  Navigator.push(context,
////                  MaterialPageRoute(builder: (context)=>MainEventShop())
////                  );
////                },
////                child: Card(
////                  elevation: 1.1,
////                  child: Container(
////                    width: MediaQuery.of(context).size.width,
////                    child: Column(
////                      crossAxisAlignment: CrossAxisAlignment.center,
////                      children: <Widget>[
////                        SizedBox(
////                          height: 5.0,
////                        ),
////                        Image.asset(
////                          'assets/prototype/sony.jpg',
////                          fit: BoxFit.cover,
////                          height: 150,
////                        ),
////                        SizedBox(
////                          height: 5.0,
////                        ),
////                        Text('Product : Sony WF-1000xm3'),
////                        Text('Quantity : 95'),
////                        SizedBox(
////                          height: 5.0,
////                        ),
////                      ],
////                    ),
////                  ),
////                ),
////              ),
//              InkWell(
//                onTap: (){},
//                child: Card(
//                  elevation: 1.1,
//                  child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SizedBox(
//                          height: 5.0,
//                        ),
//                        Image.asset(
//                          'assets/prototype/stan.jpg',
//                          fit: BoxFit.cover,
//                          height: 150,
//                        ),
//                        SizedBox(
//                          height: 5.0,
//                        ),
//                        Text('Product : Adidas Stan Smith'),
//                        Text('Quantity : 101'),
//                        SizedBox(
//                          height: 5.0,
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
    );
  }
}