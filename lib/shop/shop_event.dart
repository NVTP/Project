import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ShopEvent extends StatefulWidget {
  final String evID;

  ShopEvent(this.evID);

  @override
  _ShopEventState createState() => _ShopEventState();
}

class _ShopEventState extends State<ShopEvent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceOffer;
  TextEditingController _amountOffer;

  @override
  void initState() {
    // TODO: implement initState
    _priceOffer = TextEditingController();
    _amountOffer = TextEditingController();
    super.initState();
  }

  showLog(String productName, String image,String currentAmount) {
    if (_amountOffer.text.isEmpty || _priceOffer.text.isEmpty) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 1.1,
              title: Text('Price or Quantity can\'t empty'),
//              content: Center(
//                child: Text(
//                  'Price or Quantity can\'t empty',
//                  style: TextStyle(color: Colors.red,fontSize: 26),
//                ),
//              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    print('ok');
                    print(widget.evID);
                    print(productName);
                    print(image);
                    print(currentAmount);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 1.1,
              title: Text('Join Event'),
              content: Center(
                child: Text(
                  'Are you sure',
                  style: TextStyle(color: Colors.red, fontSize: 26),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    print('save ok');
                    print(widget.evID);
                    _onSubmit(productName,image,currentAmount);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          });
    }
  }

  _onSubmit(String productName, String image,String currentAmount) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_priceOffer.text);
    print(_amountOffer.text);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var eventID = widget.evID;
    DocumentReference docRef =
    Firestore.instance.collection('events').document(eventID);
    docRef.collection('shopJoin').document(user.uid).setData({
      'eventId': eventID,
      'shopPrice': _priceOffer.text,
      'shopAmount': _amountOffer.text,
      'shopEmail': user.email,
      'image':image,
      'shopPic': user.photoUrl,
      'productName': productName,
      'currentAmount':currentAmount,
      'shopID': user.uid,
      'joinAt':Timestamp.now()
    },merge: true).catchError((e) {
      print('er 112 $e');
    });
    Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('shopJoin')
        .add({
      'eventId':eventID,
      'productName':productName,
      'image':image,
      'joinAt':Timestamp.now(),
      'currentAmount':currentAmount,
    }).catchError((e) {
      print('er tttt $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('events')
            .document(widget.evID)
            .snapshots(),
        builder: (context, snapshot) {
          var productName = snapshot.data['productName'];
          var image = snapshot.data['image'];
          var currentAmount = snapshot.data['currentAmount'];
          if (!snapshot.hasData) return Text('loading');
          return SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(width: 2, color: Colors.grey[300]),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(productName),
                    SizedBox(
                      height: 4,
                    ),
                    Text('Category : ' + snapshot.data['category']),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Card(
                        color: Colors.grey[200],
                        elevation: 1.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(snapshot.data['eventDetail']),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                            'Amount : ${currentAmount ?? '0'}'),
                        Text(
                            'Shop Require : ${snapshot.data['shopAmount'] ?? '0'}'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Price : '),
                        Flexible(
                          child: Container(
                            width: 100,
                            child: TextFormField(
                              controller: _priceOffer,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: '0',
                                  hintStyle:
                                  TextStyle(color: Colors.blueGrey[300])),
                              validator: (data) {
                                if (data.isEmpty) {
                                  return 'Fill price';
                                } else if (data.toString() == '0') {
                                  return 'Can\'t be 0';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Text('Bath'),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Quantity : '),
                        Flexible(
                          child: Container(
                            width: 100,
                            child: TextFormField(
                              controller: _amountOffer,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: '0',
                                  hintStyle:
                                  TextStyle(color: Colors.blueGrey[300])),
                              validator: (data) {
                                if (data.isEmpty) {
                                  return 'Fill Quantity';
                                } else if (data.toString() == '0') {
                                  return 'Can\'t be 0';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Text('Piece'),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Date Start : ' +
                              DateFormat('hh:mm:ss dd-MM-yyyy ')
                                  .format(snapshot.data['createAt'].toDate())),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Date End : ' +
                              DateFormat('hh:mm:ss dd-MM-yyyy ')
                                  .format(snapshot.data['endAt'].toDate())),
                          SizedBox(
                            height: 32,
                          ),
                          RaisedButton(
                            onPressed: () {
                              showLog(productName,image,currentAmount);
                              print('when join');
                            },
                            elevation: 1.1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            color: Colors.blueGrey[300],
                            highlightColor: Colors.red,
                            splashColor: Colors.red,
                            focusColor: Colors.red,
                            child: Text(
                              'Offer',
                              style:
                              TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[300],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  ' The Creator ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshot.data['userPic'])),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(snapshot.data['userEmail']),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Quantity : ${snapshot.data['userAmount']}'),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
//      body: SafeArea(
//        child: SingleChildScrollView(
//          child: Center(
//            child: Form(
//              key: _formKey,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                    width: MediaQuery.of(context).size.width,
//                    height: 150,
//                    child: Image.asset(
//                      'assets/prototype/sony.jpg',
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                  Text('Product : Sony WF-1000xm3',style: TextStyle(fontSize: 15),),
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                    child: Card(
//                      elevation: 1.1,
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)
//                      ),
//                      child: Container(
//                        height: 100,
//                        padding: EdgeInsets.symmetric(horizontal: 20.0),
//                        width: MediaQuery.of(context).size.width,
//                        child: ListView(
//                          children: <Widget>[
//                            Text('Sony WF-1000xm3 เป็นหูฟังแบบ True Wireless แบบ in ear'),
//                            Text('หูฟัง Sony WF-1000XM3 นั้นใช้ไดร์เวอร์ชนิดไดนามิคขนาด 6 มม. ซึ่งออกแบบมาให้สามารถตอบสนองความถี่ได้ครบทุกย่านครับ โดยมาพร้อมชิป Sony QN1e ที่ทำหน้าที่ประมวลผลการตัดเสียงรบกวน และทำให้ที่เป็น DAC และ Sound Processing ในหนึ่งเดียว')
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),//DETAIL
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Text('Quantity : 99'),
//                      Text('Shop : 0'),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Text(
//                        'Price : '
//                      ),
//                      Flexible(
//                        child: Container(
//                          width: 100,
//                          child: TextFormField(
//                            controller: _priceOffer,
//                            keyboardType: TextInputType.number,
//                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                            maxLines: 1,
//                            decoration: InputDecoration(
//                              border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10),
//                              ),
//                              hintText: '0',
//                              hintStyle: TextStyle(color: Colors.blueGrey[300])
//                            ),
//                            validator: (data){
//                              if(data.isEmpty){
//                                return 'Fill price';
//                              }else{
//                                return null;
//                              }
//                            },
//                          ),
//                        ),
//                      ),
//                      Text('Bath'),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 5.0,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Text(
//                          'Quantity : '
//                      ),
//                      Flexible(
//                        child: Container(
//                          width: 100,
//                          child: TextFormField(
//                            controller: _amountOffer,
//                            keyboardType: TextInputType.number,
//                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                            maxLines: 1,
//                            decoration: InputDecoration(
//                                border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                ),
//                                hintText: '0',
//                                hintStyle: TextStyle(color: Colors.blueGrey[300])
//                            ),
//                            validator: (data){
//                              if(data.isEmpty){
//                                return 'Fill Quantity';
//                              }else{
//                                return null;
//                              }
//                            },
//                          ),
//                        ),
//                      ),
//                      Text('Piece'),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text('Date Start : 11/27/2020'),
//                        Text('Date End : 02/27/2020')
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  RaisedButton(
//                    onPressed: (){
//                      if(_formKey.currentState.validate()){
//
//                      }
//                    },
//                    elevation: 1.1,
//                    color: Colors.blueGrey[300],
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10)
//                    ),
//                    child: Text('Offer', style: TextStyle(color: Colors.white,fontSize: 20),),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  Divider(
//                    height: 5.0,
//                    color: Colors.grey,
//                  ),
//                  SizedBox(
//                    height: 5.0,
//                  ),
//                  ListTile(
//                    leading: CircleAvatar(
//                      backgroundColor: Colors.transparent,
//                      backgroundImage: AssetImage(
//                        'assets/images/sony.jpeg'
//                      ),
//                    ),
//                    title: Text('Sony Thailand'),
//                    subtitle: Row(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text('Price : 1500'),
//                        SizedBox(
//                          width: 10.0,
//                        ),
//                        Text('Quantity : 120'),
//                      ],
//                    ),
//                    trailing: InkWell(
//                      onTap: (){},
//                      child: Text('Cancel',style: TextStyle(color: Colors.red),),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
    );
  }
}