import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/shop/notificationsEventShop/detail_event_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationShop extends StatefulWidget {
  @override
  _NotificationShopState createState() => _NotificationShopState();
}

class _NotificationShopState extends State<NotificationShop> {
  var uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        uid = user.uid;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Status',style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('users').document(uid).collection('shopJoin').orderBy('joinAt',descending: true).snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              List<DocumentSnapshot> reversedDocuments = snapshot.data.documents.reversed.toList();
              return ListView.separated(
                separatorBuilder: (context,index){
                  return SizedBox(
                    height: 8,
                    child: Divider(
                     height: 1,
                     color: Colors.red,
                    ),
                  );
                },
                itemCount: reversedDocuments.length,
                itemBuilder: (context,index){
                  return SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>DetailEventShop(reversedDocuments[index].data['eventId'])));
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey,width: 2),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          reversedDocuments[index].data['image']
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text('Product : '+reversedDocuments[index].data['productName'])
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Notifications',
//          style: TextStyle(color: Colors.white,fontSize: 20),
//        ),
//        centerTitle: true,
//      ),
//      body: SafeArea(
//        child: Center(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              SizedBox(
//                height: 5.0,
//              ),
//              ListTile(
//                onTap: (){
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context)=>DetailEventShop())
//                  );
//                },
//                leading: CircleAvatar(
//                  backgroundImage: AssetImage(
//                    'assets/prototype/sony.jpg',
//                  ),
//                  maxRadius: 35.0,
//                ),
//                title: Text('Product : Sony WF-1000xm3',style: TextStyle(fontSize: 18),),
//                subtitle: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Need to Deal with You'),
//                    Row(
//                      children: <Widget>[
//                        Icon(Icons.access_time),
//                        Text('01/27/2020')
//                      ],
//                    ),
//                  ],
//                ),
//                trailing: IconButton(
//                  onPressed: (){},
//                  icon: Icon(
//                      Icons.more_vert
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 5.0,
//              ),
//              Divider(
//                height: 5.0,
//                color: Colors.grey,
//              ),
//              SizedBox(
//                height: 5.0,
//              ),
//              ListTile(
//                onTap: (){},
//                leading: CircleAvatar(
//                  backgroundImage: AssetImage(
//                    'assets/prototype/timbuk.jpg',
//                  ),
//                  maxRadius: 35.0,
//                ),
//                title: Text('Product : Timbuk 2',style: TextStyle(fontSize: 18),),
//                subtitle: Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('Need to Deal with You'),
//                    Row(
//                      children: <Widget>[
//                        Icon(Icons.access_time),
//                        Text('01/27/2020')
//                      ],
//                    ),
//                  ],
//                ),
//                trailing: IconButton(
//                  onPressed: (){},
//                  icon: Icon(
//                      Icons.more_vert
//                  ),
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
//    );
  }
}