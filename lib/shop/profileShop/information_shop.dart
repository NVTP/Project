import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/shop/notificationsEventShop/detail_event_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  var proFile;
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';
  var email;
  var uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        email = user.email;
        proFile = user.photoUrl;
        uid = user.uid;
      });
    }).catchError((e){
      print('first Error $e');
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
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverAppBar(
//            title: Text('Information',style: TextStyle(color: Colors.white,fontSize: 20),),
//            centerTitle: true,
//            floating: true,
//          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              Center(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    SizedBox(
//                      height: 30,
//                    ),
//                    Container(
//                      width: 150,
//                      height: 150,
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        shape: BoxShape.circle,
//                        image: DecorationImage(
//                          fit: BoxFit.cover,
//                          image: NetworkImage(
//                              proFile ?? inStead
//                          ),
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Divider(
//                      height: 5.0,
//                      color: Colors.grey,
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Column(
//                          children: <Widget>[
//                            Text('Reviews'),
//                            SizedBox(
//                              height: 5.0,
//                            ),
//                            Text('1'),
//                          ],
//                        ),
//                      ],
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Divider(
//                      height: 5.0,
//                      color: Colors.grey,
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Card(
//                      elevation: 1.1,
//                      margin: EdgeInsets.symmetric(horizontal: 10),
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(20)
//                      ),
//                      child: ListTile(
//                        leading: CircleAvatar(
//                          backgroundColor: Colors.transparent,
//                          backgroundImage: AssetImage(
//                              'assets/prototype/virgil.jpg'
//                          ),
//                          radius: 35,
//                        ),
//                        title: Text('Virgil van Dijk'),
//                        subtitle: Text('Very Good !'),
//                        trailing: IconButton(
//                          onPressed: (){},
//                          icon: Icon(
//                              Icons.more_vert
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ]),
//          )
//        ],
//      ),
//    );
  }
}