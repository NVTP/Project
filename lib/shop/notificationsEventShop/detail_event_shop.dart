import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/shop/notificationsEventShop/detail_customer.dart';
import 'package:flutter/material.dart';

class DetailEventShop extends StatefulWidget {
  String evId;
  DetailEventShop(this.evId);
  @override
  _DetailEventShopState createState() => _DetailEventShopState();
}

class _DetailEventShopState extends State<DetailEventShop> {
  var proFile = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Event',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('events').document(widget.evId).collection('payment').orderBy('payAt',descending: true).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot docs){
               return Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(docs['userPic']??proFile)
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('Name : '+docs['name']),
                              Text('Address : '+docs['address']),
                              Text('Amount : '+docs['amount']),
                              Text('Payment : '+docs['payment']),
                              Text('Email : '+docs['userEmail']),
                            ],
                          ),
                        )
                        ],
                      ),
                    )
                );
              }).toList(),
            );
          }
        },
      ),
    );
//    return Scaffold(
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverAppBar(
//            title: Text('Detail Event'),
//            centerTitle: true,
//            floating: true,
//          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                child: Column(
//                  children: <Widget>[
//                    ListTile(
//                      onTap: (){
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context)=>DetailCustomer())
//                        );
//                      },
//                      leading: CircleAvatar(
//                        backgroundColor: Colors.transparent,
//                        backgroundImage: AssetImage(
//                            'assets/prototype/virgil.jpg'
//                        ),
//                      ),
//                      title: Text('Virgil van Dijk'),
//                      subtitle: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text('Quantity : 2'),
//                          SizedBox(
//                            width: 10.0,
//                          ),
//                          Text('Color : Black'),
//                        ],
//                      ),
//                    ),
//                    Divider(
//                      height: 5.0,
//                      color: Colors.grey,
//                    ),
//                    ListTile(
//                      onTap: (){},
//                      leading: CircleAvatar(
//                        backgroundColor: Colors.transparent,
//                        backgroundImage: AssetImage(
//                            'assets/prototype/razer.jpg'
//                        ),
//                      ),
//                      title: Text('AAAA'),
//                      subtitle: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text('Quantity : 2'),
//                          SizedBox(
//                            width: 10.0,
//                          ),
//                          Text('Color : Black'),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ]),
//          ),
//        ],
//      ),
//    );
  }
}