import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controllers/new_update_info.dart';
import 'package:finalproject/shop/controlPageShop/main_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterShop extends StatefulWidget {
  @override
  _RegisterShopState createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  bool showPW = true;
  String typeShop;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _shopPassword;
  TextEditingController _shopTax;
  TextEditingController _shopAddress;
  TextEditingController _shopEmail;
  TextEditingController _shopPhone;
  TextEditingController _shopName;
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  File imageProfile;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _handleRadioValueChange(String value) {
    setState(() {
      typeShop = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    typeShop = 'Individual';
    _shopPassword = TextEditingController();
    _shopTax = TextEditingController();
    _shopAddress = TextEditingController();
    _shopEmail = TextEditingController();
    _shopPhone = TextEditingController();
    _shopName = TextEditingController();

    super.initState();
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageProfile = image;
    });
  } //Camera

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageProfile = image;
    });
  } //Gallery

  Future uploadImageShop(BuildContext context) async {
    String fileName = basename(imageProfile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('ShopProfile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(imageProfile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUel = await snapshotTask.ref.getDownloadURL();
    if (downloadUel != null) {
      updateInfo.shopUpdatePic(downloadUel.toString(), context).then((val) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainShop()),
            ModalRoute.withName('/'));
      }).catchError((e) {
        print('upload shop er ${e}');
      });
    }
  }

  signUp(BuildContext context) async {
    _auth
        .createUserWithEmailAndPassword(
      email: _shopEmail.text.trim(),
      password: _shopPassword.text.trim(),
    )
        .then((signUpShop) => Firestore.instance
        .collection('users')
        .document(signUpShop.user.uid)
        .setData({
      'ShopName': _shopName.text.trim(),
      'uid': signUpShop.user.uid,
      'ShopPhone': _shopPhone.text.trim(),
      'Tax': _shopTax.text.trim(),
      'ShopAddress': _shopAddress.text.trim(),
      'email': _shopEmail.text.trim(),
      'role': 'shop'
    }).then((user) {
      print('shop ok ${signUpShop}');
      uploadImageShop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=>MainShop()),
          ModalRoute.withName('/'));
    }).catchError((e) {
      print('shop er ${e}');
    }));
  }

  Widget showImage() {
    return Center(
      child: imageProfile == null
          ? Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171'),
          ),
        ),
      )
          : CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: FileImage(imageProfile) == null
            ? Center(
          child: Text('loading....'),
        )
            : FileImage(imageProfile),
        radius: 120,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register Shop',
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        showImage(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            RaisedButton(
                              color: Colors.blueGrey[300],
                              child: Text(
                                'Take Photo',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                getImageCamera();
                              },
                            ),
                            RaisedButton(
                              color: Colors.blueGrey[300],
                              child: Text(
                                'Add Picture',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                getImageGallery();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Type Shop',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          ),
                        ), //TYPE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 'Individual',
                              groupValue: typeShop,
                              onChanged: _handleRadioValueChange,
                            ),
                            Text(
                              'Personal',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Radio(
                                value: 'Company',
                                groupValue: typeShop,
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Text(
                              'Company',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLength: 13,
                          maxLines: 1,
                          keyboardType:
                          TextInputType.number,
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          controller: _shopTax,
                          validator: (data) {
                            if (data.isEmpty) {
                              return null;
                            } else if (data.length != 13) {
                              return 'Please count tax invoice';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.attachment,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Tax Invoice',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Tax Invoice',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                          ),
                        ), //TAX INVOICE
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          controller: _shopEmail,
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Please check Email';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Email',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                          ),
                        ), //EMAIL
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: _shopPassword,
                          obscureText: showPW,
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Please check Password';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Password',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (showPW == true) {
                                    showPW = false;
                                  } else {
                                    showPW = true;
                                  }
                                });
                              },
                              icon: Icon(
                                showPW
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ), //PASSWORD
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType:
                          TextInputType.number,
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          maxLines: 1,
                          controller: _shopPhone,
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Please check Phone Number';
                            } else if (data.length != 10) {
                              return 'Please count Phone Number';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'PHONE',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'PHONE',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                          ),
                        ), //PHONE
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: _shopAddress,
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Please check Address';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.home,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Address',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Address',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                          ),
                        ), //ADDRESS
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: _shopName,
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Please check Name Shop';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.blueGrey[200],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Shop Name',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Shop Name',
                            labelStyle:
                            TextStyle(color: Colors.blueGrey[200]),
                          ),
                        ), //SHOP NAME
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                signUp(context);
                              }
                            },
                            elevation: 1.0,
                            color: Colors.blueGrey[400],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}