import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/choice/credit_card.dart';
import 'package:finalproject/customer/controlPageCustomer/main_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Checkouts extends StatefulWidget {
  String uid;
  String amount;
  Checkouts(this.uid,this.amount);
  @override
  _CheckoutsState createState() => _CheckoutsState();
}

class _CheckoutsState extends State<Checkouts> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _address;
  TextEditingController _tel;
  TextEditingController _name;
  bool _checkOuts;
  var uid;
  var email;
  var pic;

  @override
  void initState() {
    // TODO: implement initState
    _address = TextEditingController();
    _tel = TextEditingController();
    _name = TextEditingController();
    _checkOuts = false;
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        uid = user.uid;
        pic = user.photoUrl;
        email = user.email;
      });
    }).catchError((e){
      print('erna $e');
    });
  }
  _showPrice(String price, String amount){
    var resPrice = int.parse(price);
    var resAmount = int.parse(amount);
    var result = resPrice * resAmount;
    print(resAmount);
    print(resPrice);
    print(result);
    return Text(
      'Price All : ' + result.toString()
    );
  }

  _check(String address, String status,String tel,String name) async{
    print(address);
    print(status);
    _formKey.currentState.save();
    if (status == null) {
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('This Event Don\'t have Shop'),
              elevation: 1.1,
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                    _address.clear();
                    setState(() {
                      _checkOuts = false;
                    });
                  },
                  child: Text('OK'),
                ),
              ],
            );
          }
      );
    }else{
      CollectionReference colRef = Firestore.instance.collection('events').document(widget.uid).collection('payment');
      return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Sure'),
              elevation: 1.1,
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                    _address.clear();
                    _tel.clear();
                    _name.clear();
                    setState(() {
                      _checkOuts = false;
                    });
                  },
                  child: Text('Cancel',style: TextStyle(color: Colors.grey),),
                ),
                FlatButton(
                  child: Text('OK',style: TextStyle(color: Colors.red),),
                  onPressed: (){
                    if (_checkOuts == true) {
                      colRef.add({
                        'userId':uid,
                        'userEmail':email,
                        'userPic':pic,
                        'address' : _address.text,
                        'amount' : widget.amount,
                        'tel' : _tel.text,
                        'name' : _name.text,
                        'payment' : 'destination',
                        'payAt' : Timestamp.now(),
                      }).then((user){
                        print('pay ok');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>MainCustomer())
                        );
                      }).catchError((e){
                        print('ck er $e');
                      });
                    }else{
                      colRef.add({
                        'userId':uid,
                        'userEmail':email,
                        'userPic':pic,
                        'address' : _address.text,
                        'amount' : widget.amount,
                        'tel' : _tel.text,
                        'name' : _name.text,
                        'payAt' : Timestamp.now()
                      }).then((user){
                        print('pay ok');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>MainCustomer())
                        );
                      }).catchError((e){
                        print('check er $e');
                      });
                    }
                  },
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
        appBar: AppBar(
          title: Text('CheckOuts',style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance.collection('events').document(widget.uid).snapshots(),
              builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }else{
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot.data['image'])
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: 'Status : ',
                                    style: TextStyle(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: snapshot.data['status'] ?? 'Wait shop',
                                        style: TextStyle(color: Colors.red)
                                      ),
                                    ]
                                  )),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Product : ' + snapshot.data['productName']),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Shop : '),
                                  Text(snapshot.data['shopEmail'] ?? 'not')
                                ],
                              ),
                              SizedBox(
                                height: 8
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Price : '),
                                  Text(snapshot.data['shopPrice'] ?? 'not')
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text('Amount : '+widget.amount),
                              SizedBox(
                                height: 8,
                              ),
                                _showPrice(snapshot.data['shopPrice'] ?? '0', widget.amount),
                              SizedBox(
                                height: 8,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _name,
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.justify,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        hintStyle: TextStyle(color: Colors.blueGrey[300]),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                        ),
                                      ),
                                      validator: (data){
                                        if (data.isEmpty) {
                                          return 'Please fill Name';
                                        }else if(data.length > 4){
                                          return null;
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      controller: _address,
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.justify,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Address',
                                        hintStyle: TextStyle(color: Colors.blueGrey[300]),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                        ),
                                      ),
                                      validator: (data){
                                        if (data.isEmpty) {
                                          return 'Please fill Address';
                                        }else if(data.length > 4){
                                          return null;
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      controller: _tel,
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.justify,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        hintText: 'Tel',
                                        hintStyle: TextStyle(color: Colors.blueGrey[300]),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                        ),
                                      ),
                                      validator: (data){
                                        if (data.isEmpty) {
                                          return 'Please fill Tel';
                                        }else if(data.length > 4){
                                          return null;
                                        }else{
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                        value: _checkOuts,
                                        onChanged: (data){
                                          setState(() {
                                            _checkOuts = data;
                                          });
                                        },
                                      ),
                                      Text('Payment destination'),
                                    ],
                                  ),
                                  Text('< OR >',style: TextStyle(color: Colors.red),),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  RaisedButton(
                                    onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>CreditCard())
                                      );
                                    },
                                    elevation: 1.1,
                                    color: Colors.blueGrey[300],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Text('Credit Card',style: TextStyle(color: Colors.white,),),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: RaisedButton(
                                      onPressed: (){
                                        if (_formKey.currentState.validate()) {
                                          if (_checkOuts == false) {
                                            setState(() {
                                              _checkOuts = true;
                                            });
                                            _check(_address.text,snapshot.data['status'],_tel.text,_name.text);
                                          }
                                        }
                                      },
                                      color: Colors.blueGrey[300],
                                      elevation: 1.1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        'Checkouts',
                                        style: TextStyle(color: Colors.white,fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: RaisedButton(
                                      onPressed: (){
                                        setState(() {
                                          _checkOuts = false;
                                          _address.clear();
                                          _tel.clear();
                                          _name.clear();
                                        });
                                      },
                                      color: Colors.grey[300],
                                      elevation: 1.1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white,fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),//CHECKOUTS
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Checkouts',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
//        centerTitle: true,
//      ),
//      body: SafeArea(
//        child: SingleChildScrollView(
//          child: Center(
//            child: Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    height: 200.0,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.grey[200],
//                    ),
//                    child: Image.asset(
//                      'assets/prototype/sony.jpg',
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  RichText(
//                    text: TextSpan(
//                        text: 'Product : ',
//                        style: TextStyle(fontSize: 16,color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(
//                            text: 'Sony WF-1000xm3',
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  RichText(
//                    text: TextSpan(
//                        text: 'Shop : ',
//                        style: TextStyle(fontSize: 16,color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(
//                            text: 'Sony Thailand',
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  RichText(
//                    text: TextSpan(
//                        text: 'Quantity : ',
//                        style: TextStyle(fontSize: 16,color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(
//                            text: '2',
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  RichText(
//                    text: TextSpan(
//                        text: 'Price : ',
//                        style: TextStyle(fontSize: 16,color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(
//                            text: '1500.00',
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  RichText(
//                    text: TextSpan(
//                        text: 'Total : ',
//                        style: TextStyle(fontSize: 16,color: Colors.black),
//                        children: <TextSpan>[
//                          TextSpan(
//                            text: '3000.00',
//                          ),
//                        ]
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  SingleChildScrollView(
//                    scrollDirection: Axis.vertical,
//                    reverse: true,
//                    child: Form(
//                      key: _formKey,
//                      child: TextFormField(
//                        controller: _address,
//                        keyboardType: TextInputType.multiline,
//                        textAlign: TextAlign.justify,
//                        maxLines: null,
//                        decoration: InputDecoration(
//                          hintText: 'Address',
//                          hintStyle: TextStyle(color: Colors.blueGrey[300]),
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(10.0)
//                          ),
//                        ),
//                        validator: (data){
//                          if(data.isEmpty){
//                            return 'Plese add address';
//                          }else{
//                            return null;
//                          }
//                        },
//                      ),
//                    ),
//                  ),//ADDRESS
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Column(
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Checkbox(
//                            value: _checkOuts,
//                            onChanged: (data){
//                              setState(() {
//                                _checkOuts = data;
//                              });
//                            },
//                          ),
//                          Text('Payment destination'),
//                          Text('< OR >',style: TextStyle(color: Colors.red),),
//                          RaisedButton(
//                            onPressed: (){
//                              Navigator.push(context,
//                                  MaterialPageRoute(builder: (context)=>CreditCard())
//                              );
//                            },
//                            elevation: 1.1,
//                            color: Colors.blueGrey[300],
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(20)
//                            ),
//                            child: Text('Credit Card',style: TextStyle(color: Colors.white,),),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                  SizedBox(
//                    height: 20.0,
//                  ),
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    height: 50.0,
//                    child: RaisedButton(
//                      onPressed: (){},
//                      color: Colors.blueGrey[300],
//                      elevation: 1.1,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10)
//                      ),
//                      child: Text(
//                        'Checkouts',
//                        style: TextStyle(color: Colors.white,fontSize: 20),
//                      ),
//                    ),
//                  ),//CHECKOUTS
//                  SizedBox(
//                    height: 20,
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
  }
}