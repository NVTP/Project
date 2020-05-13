import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/checkouts.dart';
import 'package:finalproject/customer/controlPageCustomer/main_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationCustomer extends StatefulWidget {
  @override
  _NotificationCustomerState createState() => _NotificationCustomerState();
}

class _NotificationCustomerState extends State<NotificationCustomer> {
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
        title: Text(
          'Status Event',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(uid)
                  .collection('userCreate')
                  .orderBy('createAt', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('NULL'),
                  );
                } else {
                  List<DocumentSnapshot> reversedDocuments =
                  snapshot.data.documents.reversed.toList();
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
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 12),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Checkouts(
                                            reversedDocuments[index]
                                                .data['eventId'],
                                            reversedDocuments[index]
                                                .data['userAmount'],
                                          ))),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  reversedDocuments[index]
                                                      .data['image'])),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('Product : ' +
                                              reversedDocuments[index]
                                                  .data['productName']),
                                          Text('status : Waiting')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                                child: Divider(
                                  height: 1,
                                  color: Colors.grey,
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
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(uid)
                  .collection('userJoin')
                  .orderBy('joinAt', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('NULL'),
                  );
                } else {
                  List<DocumentSnapshot> reversedDocuments =
                  snapshot.data.documents.reversed.toList();
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
                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 12),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Checkouts(
                                            reversedDocuments[index]
                                                .data['eventId'],
                                            reversedDocuments[index]
                                                .data['userAmount'],
                                          ))),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  reversedDocuments[index]
                                                      .data['image'])),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('Product : ' +
                                              reversedDocuments[index]
                                                  .data['productName']),
                                          Text('status : Waiting')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                                child: Divider(
                                  height: 1,
                                  color: Colors.grey,
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
          ),
        ],
      ),
//      body: CustomScrollView(
//        shrinkWrap: true,
//        slivers: <Widget>[
//          SliverAppBar(
//            floating: true,
//            centerTitle: true,
//            title: Text('Information Customer'),
//          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              Center(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 40,
//                    ),
//                    Container(
//                      padding: EdgeInsets.symmetric(vertical: 20),
//                      width: 150,
//                      height: 150,
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Colors.white,
//                        image: DecorationImage(
//                          fit: BoxFit.cover,
//                          image: NetworkImage(
//                              proFile ?? inStead
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              Divider(
//                color: Colors.grey,
//                height: 1.0,
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              ListTile(
//                leading: CircleAvatar(
//                  backgroundColor: Colors.transparent,
//                  backgroundImage: AssetImage(
//                      'assets/prototype/sony.jpg'
//                  ),
//                  radius: 30,
//                ),
//                title: Text('Sony wf-1000xm3'),
//                subtitle: Text('Status : Sending'),
//              ),
//              Divider(
//                height: 0.0,
//                color: Colors.grey,
//              ),
//            ]),
//          ),
//        ],
//      ),
    );
//    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text('Notifications', style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
//      ),
//      body: SafeArea(
//        child: ListView(
//          children: <Widget>[
//            SizedBox(
//              height: 10.0,
//            ),
////            ListTile(
////              onTap: (){
////                Navigator.push(context,
////                    MaterialPageRoute(builder: (context)=>MainEvent())
////                );
////              },
////              leading: CircleAvatar(
////                backgroundImage: AssetImage('assets/prototype/sony.jpg'),
////                backgroundColor: Colors.transparent,
////                radius: 30,
////              ),
////              title: Row(
////                mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                children: <Widget>[
////                  Text('Sony wf-1000xm3'),
////                  Container(
////                    child: Row(
////                      children: <Widget>[
////                        Icon(Icons.access_time),
////                        Text('2020/1/16'),
////                      ],
////                    ),
////                  ),
////                ],
////              ),
////              subtitle: Row(
////                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                children: <Widget>[
////                  Expanded(
////                    flex: 1,
////                    child: Container(
////                      width: MediaQuery.of(context).size.width,
////                      child: RaisedButton(
////                        onPressed: (){
////                          Navigator.push(context,
////                              MaterialPageRoute(builder: (context)=>Checkouts())
////                          );
////                        },
////                        elevation: 1.1,
////                        child: Text('OK',style: TextStyle(color: Colors.white),),
////                        color: Colors.blueGrey,
////                        shape: RoundedRectangleBorder(
////                            borderRadius: BorderRadius.circular(10)
////                        ),
////                      ),
////                    ),
////                  ),
////                  SizedBox(
////                    width: 10.0,
////                  ),
////                  Expanded(
////                    flex: 1,
////                    child: Container(
////                      width: MediaQuery.of(context).size.width,
////                      child: RaisedButton(
////                        onPressed: (){},
////                        elevation: 1.1,
////                        child: Text('Cancel',style: TextStyle(color: Colors.white),),
////                        shape: RoundedRectangleBorder(
////                            borderRadius: BorderRadius.circular(10)
////                        ),
////                      ),
////                    ),
////                  ),
////                ],
////              ),
////            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 10.0),
//              child: Divider(
//                height: 2.0,
//                color: Colors.blueGrey,
//              ),
//            ),
//            SizedBox(
//              height: 10.0,
//            ),
//            ListTile(
//              onTap: (){},
//              leading: CircleAvatar(
//                backgroundImage: AssetImage('assets/prototype/timbuk.jpg'),
//                backgroundColor: Colors.transparent,
//                radius: 30,
//              ),
//              title: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Text('Timbuk 2'),
//                  Container(
//                      child: Row(
//                        children: <Widget>[
//                          Icon(Icons.access_time),
//                          Text('2020/1/16'),
//                        ],
//                      )
//                  ),
//                ],
//              ),
//              subtitle: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: RaisedButton(
//                        onPressed: (){},
//                        elevation: 1.1,
//                        child: Text('OK',style: TextStyle(color: Colors.white),),
//                        color: Colors.blueGrey,
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(10)
//                        ),
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    width: 10.0,
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Container(
//                      width: MediaQuery.of(context).size.width,
//                      child: RaisedButton(
//                        onPressed: (){},
//                        elevation: 1.1,
//                        child: Text('Cancel',style: TextStyle(color: Colors.white),),
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(10)
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 10.0),
//              child: Divider(
//                height: 2.0,
//                color: Colors.blueGrey,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}