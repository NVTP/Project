import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/controlPageCustomer/main_event.dart';
import 'package:finalproject/model/event.dart';
import 'package:finalproject/services/notifier/event_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCustomer extends StatefulWidget {
  @override
  _CartCustomerState createState() => _CartCustomerState();
}

class _CartCustomerState extends State<CartCustomer> {
  //todo query user create event by eventID
  //todo in userCreate have eventID
  var avatar =
      'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg';
  var uId;

  another(EventNotifier eventNotifier) async {
    var uidAA;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uidAA = user.uid;
    });
    QuerySnapshot snapshot = await Firestore.instance
        .collection('events')
        .where('userCreateId', isEqualTo: uidAA)
        .getDocuments();
    List<Events> _eventList = [];
    snapshot.documents.forEach((docs) {
      Events events = Events.fromMap(docs.data);
      _eventList.add(
        events,
      );
    });
    eventNotifier.eventList = _eventList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventNotifier eventNotifier =
        Provider.of<EventNotifier>(context, listen: false);
    another(eventNotifier);
    FirebaseAuth.instance
        .currentUser()
        .then((value) => setState(() {
              uId = value.uid;
            }))
        .catchError((e) {
      print('112 $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Future<void> _refresh() async {
      another(eventNotifier);
    }

    if (eventNotifier.eventList.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'Sorry you don\'t have',
            style: TextStyle(color: Colors.red, fontSize: 40),
          ),
        ),
      );
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(uId)
              .collection('userCreate')
              .orderBy('createAt', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<DocumentSnapshot> reversedDocuments =
                  snapshot.data.documents.reversed.toList();
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 12,
                    child: Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                  );
                },
                itemCount: reversedDocuments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>MainEvent(
                                reversedDocuments[index].data['eventId']
                              ))
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 22),
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey[300], width: 2),
                                borderRadius: BorderRadius.circular(22),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              image: NetworkImage(reversedDocuments[index].data['image'])
                            ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text('Product Name : ' + reversedDocuments[index].data['productName'],
                              style: TextStyle(
                                fontSize: 22
                              ),),
                            Text('Amount : ' + reversedDocuments[index].data['userAmount'],
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),

//      body: RefreshIndicator(
//        onRefresh: _refresh,
//        child: ListView.separated(
//          separatorBuilder: (context, index) {
//            return Divider(
//              height: 10,
//              color: Colors.white,
//            );
//          },
//          itemCount: eventNotifier.eventList.length,
//          itemBuilder: (context, index) {
//            return InkWell(
//              onTap: () {
//                eventNotifier.currentEvent = eventNotifier.eventList[index];
////                Navigator.push(context,
////                    MaterialPageRoute(builder: (context) => MainEvent()));
//              },
//              child: Container(
//                width: MediaQuery
//                    .of(context)
//                    .size
//                    .width,
//                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(12),
//                    color: Colors.grey[200]
//                ),
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.symmetric(horizontal: 20),
//                      height: 250,
//                      width: MediaQuery
//                          .of(context)
//                          .size
//                          .width,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(12),
//                        border: Border.all(
//                            color: Colors.grey[400],
//                            width: 1
//                        ),
//                        image: DecorationImage(
//                            fit: BoxFit.cover,
//                            alignment: Alignment.center,
//                            image: NetworkImage(
//                                eventNotifier.eventList[index].image ?? avatar)
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      height: 8,
//                    ),
//                    Text('Product Name : ' +
//                        eventNotifier.eventList[index].productName),
//                    Text('Amount : ' +
//                        eventNotifier.eventList[index].userAmount),
//                    SizedBox(
//                      height: 8,
//                    ),
//                  ],
//                ),
//              ),
//            );
//          },
//        ),
//      ),

//      body: ListView.separated(
//        separatorBuilder: (BuildContext context, int index) {
//          return SizedBox(
//            height: 22,
//            child: Divider(
//              height: 1,
//              color: Colors.red,
//            ),
//          );
//        },
//        itemCount: userCreateNotifier.userCreateList.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Center(
//            child: Column(
//              children: <Widget>[
//                Text(userCreateNotifier.userCreateList[index].productName),
//                Image.network(
//                    userCreateNotifier.userCreateList[index].image ?? avatar),
//                Text(userCreateNotifier.userCreateList[index].eventId),
//                SizedBox(
//                  height: 12,
//                ),
//              ],
//            ),
//          );
//        },
//      ),

//      body: SafeArea(
//        child: SingleChildScrollView(
//          child: Column(
//            children: <Widget>[
//              InkWell(
//                onTap: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => MainEvent())
//                  );
//                },
//                child: Card(
//                  elevation: 1.1,
//                  margin: EdgeInsets.symmetric(vertical: 10.0),
//                  child: Container(
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Image.asset('assets/prototype/sony.jpg', height: 150,
//                          fit: BoxFit.cover,
//                          alignment: Alignment.topCenter,),
//                        Text('Sony wf-1000xm3', style: TextStyle(fontSize: 20.0,
//                            fontWeight: FontWeight.bold),),
//                        Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text('Quantity : ', style: TextStyle(
//                                  fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                              Text('120', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                            ]
//                        ),
//                        Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text('Shop : ', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                              Text('150', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                            ]
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//              InkWell(
//                onTap: () {},
//                child: Card(
//                  elevation: 1.1,
//                  margin: EdgeInsets.symmetric(vertical: 10.0),
//                  child: Container(
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Image.asset('assets/prototype/timbuk.jpg', height: 150,
//                          fit: BoxFit.cover,
//                          alignment: Alignment.topCenter,),
//                        Text('Timbuk 2', style: TextStyle(fontSize: 20.0,
//                            fontWeight: FontWeight.bold),),
//                        Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text('Quantity : ', style: TextStyle(
//                                  fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                              Text('99', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                            ]
//                        ),
//                        Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Text('Shop : ', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                              Text('100', style: TextStyle(fontSize: 15.0,
//                                  fontWeight: FontWeight.bold),),
//                            ]
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
