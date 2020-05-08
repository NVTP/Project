import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controllers/event_controller.dart';
import 'package:finalproject/customer/controlPageCustomer/main_customer.dart';
import 'package:finalproject/model/event.dart';
import 'package:finalproject/services/notifier/event_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FinishEvent extends StatefulWidget {
  final String category;

  const FinishEvent({this.category});

  @override
  _FinishEventState createState() => _FinishEventState();
}

class _FinishEventState extends State<FinishEvent> {
  final _formKey = GlobalKey<FormState>();
  List colorEvent = [];
  List userVariation = [];
  bool valColor;

  File imageEvent;
  var avatar =
      'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg';
  Events _currentEvent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    _productDetail = TextEditingController();
    _productName = TextEditingController();
    _productMediumPrice = TextEditingController();
    _colorController = TextEditingController();
    _userVariationController = TextEditingController();
    _amount = TextEditingController();
    valColor = true;
    _currentEvent = Events();
    colorEvent.addAll(_currentEvent.variations);
    userVariation.addAll(_currentEvent.userVariations);
  }

  TextEditingController _productDetail;
  TextEditingController _productMediumPrice;
  TextEditingController _amount;
  TextEditingController _productName;
  TextEditingController _colorController;
  TextEditingController _userVariationController;

  _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,maxHeight: 250,maxWidth: 250);
    setState(() {
      imageEvent = image;
    });
  }

  showImage() {
    return Center(
        child: imageEvent == null
            ? Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(avatar)),
          ),
        )
            : Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Image.file(
            imageEvent,
            fit: BoxFit.fill,
            height: 250,
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }

  _onUploadEvent(Events events) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    eventNotifier.addEvent(events);
    Navigator.pop(context);
  }

  saveEvent() async {
    print('called save event');
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('save form');

    _currentEvent.variations = colorEvent;
    _currentEvent.category = widget.category;
    print('category : ${_currentEvent.category}');
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _currentEvent.userPic = user.photoUrl;
    _currentEvent.userCreateId = user.uid;
    _currentEvent.userEmail = user.email;
    _currentEvent.userVariations = userVariation;

    CollectionReference subCollection = Firestore.instance.collection('users').document(user.uid).collection('userCreate');

    if (imageEvent == null) {
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              elevation: 1.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text('Warning !!!',style: TextStyle(color: Colors.red),),
              actions: <Widget>[
                FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
              content: Center(
                child: Text('Image can\'t empty',style: TextStyle(color: Colors.red,fontSize: 32),),
              ),
            );
          }
      );
    }else if(colorEvent.isEmpty || userVariation.isEmpty){
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text('Warning !!!',style: TextStyle(color: Colors.red),),
              elevation: 1.1,
              content: Center(
                child: Text('Please check Colors or Size is can\'t empty '),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: ()=>Navigator.pop(context),
                  child: Text('OK'),
                )
              ],
            );
          }
      );
    }else{
      DocumentReference docRef = await subCollection.add({
        'productName':_currentEvent.productName,
        'amount':_currentEvent.currentAmount,
        'shopId':_currentEvent.shopOwnId,
        'shopPic':_currentEvent.shopPic,
        'shopEmail':_currentEvent.shopEmail,
        'variation':_currentEvent.variations,
        'userAmount':_currentEvent.userAmount,
        'userVariations':_currentEvent.userVariations
      }).then((ev){
        uploadEventsAndImage(_currentEvent, imageEvent, _onUploadEvent,subID: ev.documentID);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=>MainCustomer()));
      }).catchError((e){
        print('can\'t sub $e');
      });
    }
  }

  _buildColor() {
    return SizedBox(
      width: 200,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _colorController,
        decoration: InputDecoration(
            hintText: 'Ex. Color , Size  \'For Event\'',
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
  _addColor(String text) {
    if (text.isNotEmpty) {
      setState(() {
        colorEvent.add(text);
      });
      _colorController.clear();
    }
  }
  _buildForUser(){
    return SizedBox(
      width: 200,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _userVariationController,
        decoration: InputDecoration(
            hintText: 'Ex. Color , Size  \'For you\'',
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
  _addUserVariation(String text){
    if(text.isNotEmpty){
      setState(() {
        userVariation.add(text);
      });
      _userVariationController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Create Event Step : 4'),
            centerTitle: true,
            floating: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      showImage(),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () => _getImage(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.blueGrey[300],
                        child: Text(
                          'Add Image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Category : ${widget.category}',
                          style: TextStyle(
                              fontSize: 25, color: Colors.blueGrey[300]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        controller: _productName,
                        onSaved: (String val) {
                          _currentEvent.productName = val;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.event,
                            color: Colors.blueGrey[300],
                          ),
                          hintText: 'Product Name',
                          hintStyle: TextStyle(color: Colors.blueGrey[300]),
                          labelText: 'Product Name',
                          labelStyle: TextStyle(color: Colors.blueGrey[300]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Plese Fill Product Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      //PRODUCT NAME
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: null,
                        textAlign: TextAlign.justify,
                        keyboardType: TextInputType.multiline,
                        controller: _productDetail,
                        onSaved: (String val) {
                          _currentEvent.eventDetail = val;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.details,
                            color: Colors.blueGrey[300],
                          ),
                          hintText: 'Product Detail',
                          hintStyle: TextStyle(color: Colors.blueGrey[300]),
                          labelText: 'Product Detail',
                          labelStyle: TextStyle(color: Colors.blueGrey[300]),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Plese Fill Product Detail';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Medium Price',
                            style:
                            TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Container(
                              child: TextFormField(
                                controller: _productMediumPrice,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                onSaved: (String val) {
                                  _currentEvent.mediumPrice = val;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: '0 Bath',
                                  hintStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (data) {
                                  if (data.isEmpty) {
                                    return 'Fill Price';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Amount You',
                            style:
                            TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Container(
                              child: TextFormField(
                                controller: _amount,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                onSaved: (String val) {
                                  _currentEvent.currentAmount = val;
                                  _currentEvent.userAmount = val;
                                },
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  hintText: '0 Piece',
                                  hintStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (data) {
                                  if (data.isEmpty) {
                                    return 'Fill Amount';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildColor(),
                          RaisedButton(
                            onPressed: () => _addColor(_colorController.text),
                            color: Colors.blueGrey[600],
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Add For Event',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: colorEvent.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 8),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 22),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.deepOrange[300],width: 2),
                                        color: Colors.blueGrey[300],
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          colorEvent.removeAt(index);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            colorEvent[index],style: TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons.clear
                                            ),
                                            color: Colors.white,
                                            onPressed: (){
                                              setState(() {
                                                colorEvent.removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildForUser(),
                          RaisedButton(
                            onPressed: ()=>_addUserVariation(_userVariationController.text),
                            color: Colors.redAccent[700],
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text('Add For You',style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: userVariation.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 8),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 22),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.deepOrange[300],width: 2),
                                        color: Colors.blueGrey[300],
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          userVariation.removeAt(index);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            userVariation[index],style: TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons.clear
                                            ),
                                            color: Colors.white,
                                            onPressed: (){
                                              setState(() {
                                                userVariation.removeAt(index);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: () {},
                                elevation: 1.1,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: () {
                                  saveEvent();
                                },
                                elevation: 1.1,
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}